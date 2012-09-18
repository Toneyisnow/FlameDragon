//
//  CreatureDeadCondition.m
//  FlameDragon
//
//  Created by sui toney on 12-1-13.
//  Copyright 2012 ms. All rights reserved.
//

#import "CreatureDeadCondition.h"


@implementation CreatureDeadCondition


-(id) initWithCreatureId:(int)c
{
	self = [super init];
	
	creatureId = c;
	creatureFound = FALSE;
	
	return self;
}

-(BOOL) isMatch:(ActionLayers *)layers
{
	if ([layers getTurnNumber] < 1) {
		return FALSE;
	}
	
	BattleField *field = [[layers getFieldLayer] getField];
	
	FDCreature *creature = [field getCreatureById:creatureId];
	
	if (creature == nil) {
		
		if (creatureFound) {
			NSLog(@"Creature Dead Condition is matched.");
		}
	
	}
	else {
		creatureFound = TRUE;		
	}

	
	
	return (creature == nil);
}




@end
