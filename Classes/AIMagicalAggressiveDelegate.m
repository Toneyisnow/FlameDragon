//
//  AIMagicalDelegate.m
//  FlameDragon
//
//  Created by sui toney on 12-11-8.
//  Copyright 2012 ms. All rights reserved.
//

#import "AIMagicalAggressiveDelegate.h"
#import "MagicDefinition.h"
#import "DataDepot.h"
#import "FDRandom.h"
#import "Common.h"

@implementation AIMagicalAggressiveDelegate

-(id) initWithCreature:(FDCreature *)c Layers:(ActionLayers *)l
{
	self = [super initWithCreature:c Layers:l];	
	return self;
}

-(void) takePendAction
{
	BattleField *field = [[layers getFieldLayer] getField];

	CCLOG(@"takePendAction");
    
    // Only move when the HP is enough
    if (creature.data.hpCurrent > creature.data.hpMax / 2) {
        FDCreature *target = [self findTarget];
        if (target != nil) {
            CCLOG(@"target != nil");
            CGPoint targetPos = [self generatePos:[field getObjectPos:target]];
            CCLOG(@"generated targetPos.");
            [field setCursorTo:targetPos];
            [layers moveCreature:creature To:targetPos showMenu:FALSE];
        }
	}
    
	CCLOG(@"End Pend Action;");
	[layers appendToCurrentActivityMethod:@selector(takeAttackAction) Param1:creature Param2:nil Obj:self];
}

-(void) takeAttackAction {
    
    BattleField *field = [[layers getFieldLayer] getField];
    FDRange *range = [creature attackRange];
	
    FDCreature *attackTarget = nil;
    
    NSMutableArray *targetList = [[NSMutableArray alloc] init];
    if ([creature getCreatureType] == CreatureType_Enemy) {
        [targetList addObjectsFromArray:[field getFriendList]];
        [targetList addObjectsFromArray:[field getNpcList]];
    } else {
        [targetList addObjectsFromArray:[field getEnemyList]];
    }
    
    for (FDCreature *target in targetList) {
        if (target != nil && [creature isAbleToAttack:target]
		&& (range != nil && [range containsValue:[field getDirectDistance:creature And:target]])) {
            attackTarget = target;
            break;
        }
    }
	[targetList release];
    
    if (attackTarget != nil) {
		[layers appendToCurrentActivityMethod:@selector(attackFrom:Target:) Param1:creature Param2:attackTarget];
	}
	else {
		[layers appendToCurrentActivityMethod:@selector(creatureEndTurn:) Param1:creature Param2:nil];
	}
}


@end
