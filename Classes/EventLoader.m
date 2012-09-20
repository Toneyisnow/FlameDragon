//
//  EventLoader.m
//  FlameDragon
//
//  Created by sui toney on 12-3-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "EventLoader.h"
#import "FDEnemy.h"
#import "FDFriend.h"
#import "FDTalkActivity.h"
#import "BattleField.h"
#import "FDEmptyActivity.h"
#import "FDLocalString.h"
#import "FDDurationActivity.h"
#import "FDTreasure.h"
#import "TurnCondition.h"
#import "CreatureDeadCondition.h"
#import "CreatureDyingCondition.h"
#import "TeamEliminatedCondition.h"


@implementation EventLoader

-(void) loadWithLayers:(ActionLayers *)l
{
	eventHandler = [[EventHandler alloc] initWithLayers:l];
	layers = l;
	
	//[layers setEventLoader:self];
	[layers setEventListener:eventHandler];
	
	[self loadEvents];
	
}

// Written by sub classes
-(void) loadEvents
{
	
}

-(void) loadTurnEvent:(TurnType) turnType Turn:(int)turnNum Action:(SEL)action
{
	TurnCondition *condition = [[TurnCondition alloc] initWithTurnType:turnType Number:turnNum];
	FDEvent *event = [[FDEvent alloc] initWithCondition:condition Delegate:self Method:action];
	[eventHandler addEvent:event];
	[condition release];
	[event release];
	
}

-(void) loadDyingEvent:(int)creatureId Action:(SEL)action
{	
	CreatureDyingCondition *condition = [[CreatureDyingCondition alloc] initWithCreatureId:creatureId];
	FDEvent *event = [[FDEvent alloc] initWithCondition:condition Delegate:self Method:action];
	[eventHandler addEvent:event];
	[condition release];
	[event release];
}

-(void) loadDieEvent:(int)creatureId Action:(SEL)action
{	
	CreatureDeadCondition *condition = [[CreatureDeadCondition alloc] initWithCreatureId:creatureId];
	FDEvent *event = [[FDEvent alloc] initWithCondition:condition Delegate:self Method:action];
	[eventHandler addEvent:event];
	[condition release];
	[event release];
}

-(void) loadTeamEvent:(CreatureType) creatureType Action:(SEL)action
{
	TeamEliminatedCondition *condition = [[TeamEliminatedCondition alloc] initWithTeam:creatureType];
	FDEvent *event = [[FDEvent alloc] initWithCondition:condition Delegate:self Method:action];
	[eventHandler addEvent:event];
	[condition release];
	[event release];	
}

-(void) showTalkMessage:(int)charId conversation:(int)converId sequence:(int)sequenceId
{
	BattleField *field = [[layers getFieldLayer] getField];
	
	NSString *talkMessage = [FDLocalString chapter:charId conversation:converId sequence:sequenceId];
	NSString *creatureIdStr = [FDLocalString chapterCreature:charId conversation:converId sequence:sequenceId];
	
	FDCreature *creature = [field getCreatureById:[creatureIdStr intValue]];
	if (creature == nil) {
		creature = [field getDeadCreatureById:[creatureIdStr intValue]];
	}
	
	FDTalkActivity *talk = [[FDTalkActivity alloc] initWithCreature:creature Message:talkMessage Layer:[layers getMessageLayer]];
	[layers appendToCurrentActivity:talk];	
}

-(void) settleFriend:(int)creatureId At:(CGPoint)loc
{
	BattleField *field = [[layers getFieldLayer] getField];
	
	FDFriend *friend = (FDFriend *)[field getUnSettledCreatureById:creatureId];
	if (friend != nil) {
		[field addFriend:friend Position:loc];
		[[field getUnsettledCreatureList] removeObject:friend];
	}
	
}

-(void) gameOver
{
	[layers gameOver];
}



@end
