//
//  ArrivePositionCondition.m
//  FlameDragon
//
//  Created by sui toney on 12-11-18.
//  Copyright 2012 ms. All rights reserved.
//

#import "ArrivePositionCondition.h"


@implementation ArrivePositionCondition

-(id) initWithCreatureId:(int)c Position:(CGPoint)pos
{
	self = [super init];
	
	creatureId = c;
	eventPosition = pos;
	
	return self;
}

-(BOOL) isMatch:(ActionLayers *)layers
{
	BattleField *field = [[layers getFieldLayer] getField];
	
	FDCreature *creature = [field getCreatureByPos:eventPosition];
	if (creature != nil && [creature getIdentifier] == creatureId) {
		return TRUE;
	}

	return FALSE;
}


@end
