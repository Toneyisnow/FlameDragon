//
//  TeamEliminatedCondition.m
//  FlameDragon
//
//  Created by sui toney on 12-1-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "TeamEliminatedCondition.h"

@implementation TeamEliminatedCondition

-(id) initWithTeam:(CreatureType)t
{
	self = [super init];
	
	teamType = t;
	previousCount = 0;
	
	return self;
}

-(BOOL) isMatch:(ActionLayers *)layers
{
	BattleField *field = [[layers getFieldLayer] getField];
	
	int teamCount = 0;
	switch (teamType) {
		case CreatureType_Friend:
			teamCount = [[field getFriendList] count];
			break;
		case CreatureType_Npc:
			teamCount = [[field getNpcList] count];
			break;
		case CreatureType_Enemy:
			teamCount = [[field getEnemyList] count];
			break;
		default:
			break;
	}
	
	if (previousCount == 0) {
		previousCount = teamCount;
		return FALSE;
	}
	
	if (previousCount > 0 && teamCount == 0) {
		return TRUE;
	}

	return FALSE;
}

@end