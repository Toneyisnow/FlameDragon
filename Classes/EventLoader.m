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
#import "ArrivePositionCondition.h"

@implementation EventLoader

-(void) loadWithLayers:(ActionLayers *)l
{
	eventHandler = [[EventHandler alloc] initWithLayers:l];
	layers = l;
	field = [[layers getFieldLayer] getField];
	
	//[layers setEventLoader:self];
	[layers setEventListener:eventHandler];
	
	generatedEventId = 1;
	
	[self loadEvents];
	
}

// Written by sub classes
-(void) loadEvents
{
	
}

-(int) loadTurnEvent:(TurnType) turnType Turn:(int)turnNum Action:(SEL)action
{
	TurnCondition *condition = [[TurnCondition alloc] initWithTurnType:turnType Number:turnNum];
	int eventId = [self loadSingleEvent:condition Action:action];
	[condition release];	
	
	return eventId;
}

-(int) loadDyingEvent:(int)creatureId Action:(SEL)action
{	
	CreatureDyingCondition *condition = [[CreatureDyingCondition alloc] initWithCreatureId:creatureId];
	int eventId = [self loadSingleEvent:condition Action:action];
	[condition release];
	
	return eventId;
}

-(int) loadDieEvent:(int)creatureId Action:(SEL)action
{	
	CreatureDeadCondition *condition = [[CreatureDeadCondition alloc] initWithCreatureId:creatureId];
	int eventId = [self loadSingleEvent:condition Action:action];
	[condition release];
	
	return eventId;
}

-(int) loadTeamEvent:(CreatureType) creatureType Action:(SEL)action
{
	TeamEliminatedCondition *condition = [[TeamEliminatedCondition alloc] initWithTeam:creatureType];
	int eventId = [self loadSingleEvent:condition Action:action];
	[condition release];
	
	return eventId;
}

-(int) loadPositionEvent:(int)creatureId AtPosition:(CGPoint)pos Action:(SEL)action
{
	ArrivePositionCondition *condition = [[ArrivePositionCondition alloc] initWithCreatureId:creatureId Position:pos];
	int eventId = [self loadSingleEvent:condition Action:action];
	[condition release];
	
	return eventId;
}

-(int) loadSingleEvent:(FDEventCondition *)condition Action:(SEL)action
{
	FDEvent *event = [[FDEvent alloc] initWithCondition:condition Delegate:self Method:action];
	event.eventId = generatedEventId ++;
	[eventHandler addEvent:event];
	[event release];
	
	return event.eventId;
}

-(void) showTalkMessage:(int)charId conversation:(int)converId sequence:(int)sequenceId
{
	NSString *talkMessage = [FDLocalString chapter:charId conversation:converId sequence:sequenceId];
	NSString *creatureIdStr = [FDLocalString chapterCreature:charId conversation:converId sequence:sequenceId];
	
	FDCreature *creature = [field getCreatureById:[creatureIdStr intValue]];
	if (creature == nil) {
		creature = [field getDeadCreatureById:[creatureIdStr intValue]];
	}
	
	
	[layers appendToCurrentActivityMethod:@selector(setCursorToObject:) Param1:creature Param2:nil Obj:field];
	
	FDTalkActivity *talk = [[FDTalkActivity alloc] initWithCreature:creature Message:talkMessage Layer:[layers getMessageLayer]];	
	[layers appendToCurrentActivity:talk];	
}

-(void) settleFriend:(int)creatureId At:(CGPoint)loc
{
	FDFriend *friend = (FDFriend *)[field getUnSettledCreatureById:creatureId];
	if (friend != nil) {
		[field addFriend:friend Position:loc];
		[[field getUnsettledCreatureList] removeObject:friend];
	}
	
}

-(void) setAiOfId:(int)creatureId EscapeTo:(CGPoint)pos
{
	FDCreature *creature = [field getCreatureById:creatureId];
	
	if (creature != nil) {
		creature.data.aiType = AIType_Escape;
		creature.data.aiParam = [[[FDPosition alloc] initX:pos.x Y:pos.y] autorelease];
	}
}

-(void) setAiOfId:(int)creatureId withType:(AIType) type
{
	FDCreature *creature = [field getCreatureById:creatureId];
	
	if (creature != nil) {
		creature.data.aiType = type;
	}
}

-(void) gameOver
{
	[layers gameOver];
}



@end
