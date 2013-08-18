//
//  AIMagicalGuardDelegate.m
//  FlameDragon
//
//  Created by sui toney on 13-8-17.
//
//

#import "AIMagicalGuardDelegate.h"
#import "DataDepot.h"

@implementation AIMagicalGuardDelegate

-(id) initWithCreature:(FDCreature *)c Layers:(ActionLayers *)l {
    self = [super initWithCreature:c Layers:l];
    return self;
}

-(void) takeAction
{
	CCLOG(@"AIMagicalGuardDelegate take action on creature %d", [creature getIdentifier]);
	
	BattleField *field = [[layers getFieldLayer] getField];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if ([creature getCreatureType] == CreatureType_Enemy) {
        [arr addObjectsFromArray:[field getFriendList]];
        [arr addObjectsFromArray:[field getNpcList]];
    } else {
        [arr addObjectsFromArray:[field getEnemyList]];
    }
    
    int maxMagicScope = 0;
    for (NSNumber *num in creature.data.magicList) {
        MagicDefinition *magic = [[DataDepot depot] getMagicDefinition:[num intValue]];
        if ([magic effectScope] < maxMagicScope) {
            maxMagicScope = [magic effectScope];
        }
    }
    
    BOOL guardHoldPosition = YES;
    for (FDCreature *c in arr) {
        if ([field getDirectDistance:creature And:c] <= maxMagicScope) {
            guardHoldPosition = NO;
            break;
        }
    }
    
    [arr release];
    
    if (guardHoldPosition) {
        [layers appendToCurrentActivityMethod:@selector(creatureEndTurn:) Param1:creature Param2:nil];
    } else {
        [super takeAction];
    }
    
}

@end
