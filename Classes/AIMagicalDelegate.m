//
//  AIMagicalDelegate.m
//  FlameDragon
//
//  Created by sui toney on 13-8-17.
//
//

#import "AIMagicalDelegate.h"
#import "Common.h"
#import "DataDepot.h"
#import "FDRandom.h"

@implementation AIMagicalDelegate


-(void) takeAction
{
	CCLOG(@"AIMagicalAggressiveDelegate take action on creature %d", [creature getIdentifier]);
	if (!creature.pendingAction) {
		
        if ([self needAndCanRecover]) {
            
            [self selfRecover];
            [layers appendToCurrentActivityMethod:@selector(creatureEndTurn:) Param1:creature Param2:nil];
        } else {
            
            [self takeMagicAction];
        }
	} else {
		
		[self takePendAction];
	}
}

-(void) takePendAction
{
    // Implement in sub class
}

-(void) takeMagicAction
{
	BattleField *field = [[layers getFieldLayer] getField];
	
    NSMutableArray *magicList = [self getAvailableMagic];
	
    if (magicList == nil || [magicList count] == 0) {
        [layers appendToCurrentActivityMethod:@selector(creaturePendAction:) Param1:creature Param2:nil];
        return;
    }
	
    NSMutableArray *canMagicList = [[NSMutableArray alloc] init];
    NSMutableArray *candidateList = [[NSMutableArray alloc] init];
    for (MagicDefinition *magic in magicList)
	{
        FDCreature *candidate = nil;
        if (magic.magicType == MagicType_Attack || magic.magicType == MagicType_Offensive) {
            candidate = [self findAffensiveTarget:magic];
        }
        else if (magic.magicType == MagicType_Recover || magic.magicType == MagicType_Defensive) {
            candidate = [self findDefensiveTarget:magic];
        }
        
        if (candidate != nil) {
            [canMagicList addObject:magic];
            [candidateList addObject:candidate];
        }
	}
    
    @try {
        if ([canMagicList count] == 0) {
            CCLOG(@"Didn't find candidate.");
            [layers appendToCurrentActivityMethod:@selector(creaturePendAction:) Param1:creature Param2:nil];
            return;
        }
        
        int magicIndex = [self chooseMagicFromCandidate:canMagicList];
        MagicDefinition *selectedMagic = [canMagicList objectAtIndex:magicIndex];
        FDCreature *selectedCandidate = [candidateList objectAtIndex:magicIndex];
        
        if (selectedMagic == nil || selectedCandidate == nil) {
            CCLOG(@"Didn't find candidate.");
            [layers appendToCurrentActivityMethod:@selector(creaturePendAction:) Param1:creature Param2:nil];
            return;
        }
        
        // Locate the Magic Position
        CGPoint magicPosition;
        CGPoint candidatePosition = [field getObjectPos:selectedCandidate];
        CGPoint creaturePosition = [field getObjectPos:creature];
        int directX = (candidatePosition.x > creaturePosition.x) ? 1 : -1;
        int directY = (candidatePosition.y > creaturePosition.y) ? 1 : -1;
        int distanceX = [Common getAbs:candidatePosition.x - creaturePosition.x];
        int distanceY = [Common getAbs:candidatePosition.y - creaturePosition.y];
        
        if (selectedMagic.effectScope >= distanceX + distanceY) {
            magicPosition = candidatePosition;
        } else if (selectedMagic.effectScope >= distanceX) {
            int dy = (selectedMagic.effectScope - distanceX) * directY;
            magicPosition = CGPointMake(candidatePosition.x, creaturePosition.y + dy);
        } else {
            int dx = selectedMagic.effectScope * directX;
            magicPosition = CGPointMake(creaturePosition.x + dx, creaturePosition.y);
        }
        
        // Use Magic
        [field setCursorTo:magicPosition];
        [layers magicFrom:creature TargetPos:magicPosition Id:selectedMagic.identifier];
    }
    @finally {
        [canMagicList release];
        [candidateList release];
    }
}

-(FDCreature *) findAffensiveTarget:(MagicDefinition *)magic
{
    CCLOG(@"finding Affensive Target for %d, %d %d", magic.identifier, magic.effectScope, magic.effectRange);
	BattleField *field = [[layers getFieldLayer] getField];
	
	NSMutableArray *candidateList = [[NSMutableArray alloc] init];
    
    if ([creature getCreatureType] == CreatureType_Enemy) {
        [candidateList addObjectsFromArray:[field getFriendList]];
        [candidateList addObjectsFromArray:[field getNpcList]];
	} else {
        [candidateList addObjectsFromArray:[field getEnemyList]];
    }
    
	FDCreature *candidate = nil;
    CGPoint creaturePos = [field getObjectPos:creature];
	for (FDCreature *c in candidateList) {
		
		if (![c isNoticable]) {
			continue;
		}
		
		float distance = [field getDirectDistance:creature And:c];
		CGPoint cPos = [field getObjectPos:c];
        
		if (distance <= magic.effectScope + magic.effectRange && (!magic.isCross || cPos.x == creaturePos.x || cPos.y == creaturePos.y)) {
			if (candidate == nil || candidate.data.hpCurrent > c.data.hpCurrent) {
				candidate = c;
			}
		}
	}
	
	[candidateList release];
	return candidate;
}

-(FDCreature *) findDefensiveTarget:(MagicDefinition *)magic
{
	BattleField *field = [[layers getFieldLayer] getField];
	
	NSMutableArray *candidateList = [[NSMutableArray alloc] init];
	
    if ([creature getCreatureType] == CreatureType_Enemy) {
        [candidateList addObjectsFromArray:[field getEnemyList]];
    } else {
        [candidateList addObjectsFromArray:[field getFriendList]];
        [candidateList addObjectsFromArray:[field getNpcList]];
    }
    
	FDCreature *candidate = nil;
	CGPoint creaturePos = [field getObjectPos:creature];
	for (FDCreature *c in candidateList) {
		
		float distance = [field getDirectDistance:creature And:c];
		CGPoint cPos = [field getObjectPos:c];
        
		if (distance <= magic.effectScope + magic.effectRange && (!magic.isCross || cPos.x == creaturePos.x || cPos.y == creaturePos.y)) {
			if ([magic hasDefensiveEffectOn:c] && c.data.hpCurrent < c.data.hpMax && (candidate == nil || candidate.data.hpCurrent > c.data.hpCurrent)) {
				candidate = c;
			}
		}
	}
	
	[candidateList release];
	return candidate;
}

-(NSMutableArray *) getAvailableMagic
{
	if (![creature canFireMagic]) {
		return nil;
	}
	
    NSMutableArray *magicList = [[NSMutableArray alloc] init];
    
	for (int index = [creature.data.magicList count] - 1; index >= 0; index--) {
		NSNumber *magicId = [creature.data.magicList objectAtIndex:index];
		MagicDefinition *magic = [[DataDepot depot] getMagicDefinition:[magicId intValue]];
        
		if (magic == nil) {
			continue;
		}
		
		if (creature.data.mpCurrent >= magic.mpCost) {
			[magicList addObject:magic];
		}
	}
	
	return [magicList autorelease];
}

-(int) chooseMagicFromCandidate:(NSMutableArray *)candidateMagicList {
    
    int totalConsideration = 0;
    
    for (MagicDefinition *magic in candidateMagicList) {
        totalConsideration += magic.aiConsiderRate;
    }
    
    int ranValue = [FDRandom from:0 to:totalConsideration];
    for (int i = 0; i < [candidateMagicList count]; i++) {
        MagicDefinition *magic = [candidateMagicList objectAtIndex:i];
        ranValue -= magic.aiConsiderRate;
        if (ranValue <= 0) {
            return i;
        }
    }
    return 0;
}

@end
