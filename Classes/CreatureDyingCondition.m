//
//  CreatureDyingCondition.m
//  FlameDragon
//
//  Created by sui toney on 12-1-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "CreatureDyingCondition.h"
#import "ActionLayers.h"
#import "BattleField.h"
#import "FDCreature.h"

@implementation CreatureDyingCondition


-(id) initWithCreatureId:(int)c
{
	self = [super init];
	
	creatureId = c;
	
	return self;
}

-(BOOL) isMatch:(ActionLayers *)layers
{
	if ([layers getTurnNumber] < 1) {
		return FALSE;
	}
	
	BattleField *field = [[layers getFieldLayer] getField];
	
	FDCreature *creature = [field getCreatureById:creatureId];
	
	if (creature != nil && creature.data.hpCurrent <= 0) {
		CCLOG(@"Creature Dying Condition is matched.");
		return TRUE;
	}
	
	return FALSE;
}

@end
