//
//  TurnCondition.m
//  FlameDragon
//
//  Created by sui toney on 11-12-11.
//  Copyright 2011 ms. All rights reserved.
//

#import "TurnCondition.h"
#import "BattleField.h"

@implementation TurnCondition


-(id) initWithTurnType:(TurnType)type Number:(int)n
{
	self = [super init];
	
	turnType = type;
	turnNumber = n;
	
	return self;
}

-(BOOL) isMatch:(ActionLayers *)layers
{
	// This must be triggered after the turn
	
	BattleField *field = [[layers getFieldLayer] getField];
	
	NSMutableArray *creatureList;
	switch (turnType) {
		case TurnType_Friend:
			creatureList = [field getFriendList];
			break;
		case TurnType_NPC:
			creatureList = [field getNpcList];
			break;
		case TurnType_Enemy:
			creatureList = [field getEnemyList];
			break;
		default:
			break;
	}
	
	if (turnNumber == 0) {
		return TRUE;
	}
	
	for (FDCreature *creature in creatureList)
	{
		if(![creature hasActioned])
		{
			return FALSE;
		}
	}
	
	return ([layers getTurnType] == turnType && [layers getTurnNumber] == turnNumber);
}


@end
