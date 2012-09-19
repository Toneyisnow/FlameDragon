//
//  EventChapter2.m
//  FlameDragon
//
//  Created by sui toney on 12-4-1.
//  Copyright 2012 ms. All rights reserved.
//

#import "EventChapter2.h"
#import "FDEnemy.h"
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


@implementation EventChapter2

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(round1)];
	NSLog(@"Chapter2 events loaded.");
}

-(void) loadTurnEvent:(TurnType) turnType Turn:(int)turnNum Action:(SEL)action
{
	TurnCondition *condition = [[TurnCondition alloc] initWithTurnType:turnType Number:turnNum];
	FDEvent *event = [[FDEvent alloc] initWithCondition:condition Delegate:self Method:action];
	[eventHandler addEvent:event];
	[condition release];
	[event release];
}

-(void) round1_test
{
	NSLog(@"round1 event triggered.");
	
	BattleField *field = [[layers getFieldLayer] getField];
	// Creatures
	
	
	FDFriend *friend1 = (FDFriend *)[field getUnSettledCreatureById:1];
	if (friend1 != nil) {
		[field addFriend:friend1 Position:CGPointMake(27, 16)];
		[[field getUnsettledCreatureList] removeObject:friend1];
	}
	
	FDFriend *friend2 = (FDFriend *)[field getUnSettledCreatureById:2];
	if (friend2 != nil) {
		[field addFriend:friend2 Position:CGPointMake(27, 16)];
		[[field getUnsettledCreatureList] removeObject:friend2];
	}
	
	FDFriend *friend3 = [[FDFriend alloc] initWithDefinition:3 Id:3];
	[field addFriend:friend3 Position:CGPointMake(9, 17)];
	[friend3 release];
	
	FDFriend *friend4 = [[FDFriend alloc] initWithDefinition:4 Id:4];
	[field addFriend:friend4 Position:CGPointMake(12, 18)];
	[friend4 release];
	
	FDFriend *friend5 = [[FDFriend alloc] initWithDefinition:5 Id:5];
	[field addFriend:friend5 Position:CGPointMake(10, 18)];
	[friend5 release];
	
	FDFriend *friend6 = [[FDFriend alloc] initWithDefinition:1016 Id:6];
	[field addFriend:friend6 Position:CGPointMake(9, 18)];
	[friend6 release];
	
	FDNpc *npc = [[FDNpc alloc] initWithDefinition:703 Id:41];
	[field addNpc:npc Position:CGPointMake(8, 20)];
	[npc release];
	
	// Enemy
	FDEnemy *enemy1 = [[FDEnemy alloc] initWithDefinition:701 Id:11];
	[field addEnemy: enemy1 Position:CGPointMake(3, 19)];
	[enemy1 release];
	
	FDEnemy *enemy2 = [[FDEnemy alloc] initWithDefinition:702 Id:29];
	[field addEnemy: enemy2 Position:CGPointMake(4, 19)];
	[enemy2 release];
	
	FDEnemy *enemy3 = [[FDEnemy alloc] initWithDefinition:701 Id:13];
	[field addEnemy: enemy3 Position:CGPointMake(6, 18)];
	[enemy3 release];
	
	FDTreasure *treasure1 = [FDTreasure treasureWithType:TreasureType_Red Item:101];
	[field addObject:treasure1 Position:CGPointMake(4, 2)];
}

-(void) round1
{
	NSLog(@"round1 event triggered.");
	
	BattleField *field = [[layers getFieldLayer] getField];
	// Creatures
	
	[self settleFriend:1 At:CGPointMake(27, 16)];
	[self settleFriend:2 At:CGPointMake(27, 16)];
	[self settleFriend:3 At:CGPointMake(27, 16)];
	[self settleFriend:4 At:CGPointMake(27, 16)];
	[self settleFriend:5 At:CGPointMake(27, 16)];

	[layers moveCreatureId:1 To:CGPointMake(23, 15) showMenu:FALSE];
	
	[layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:0.5] autorelease]];
	
	[layers appendToCurrentActivityMethod:@selector(setCursorObjTo:) Param1:[FDPosition positionX:23 Y:15] Param2:nil Obj:field];
	
	[self showTalkMessage:2 conversation:1 sequence:1];
	
	[layers appendToCurrentActivityMethod:@selector(round1_2) Param1:nil Param2:nil Obj:self];

	
	
	// Add branch activities	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:2 To:CGPointMake(25, 17) showMenu:FALSE];

	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:3 To:CGPointMake(24, 14) showMenu:FALSE];

	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:4 To:CGPointMake(25, 15) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:5 To:CGPointMake(26, 16) showMenu:FALSE];
}

-(void) round1_2
{
	// BattleField *field = [[layers getFieldLayer] getField];

	[layers moveCreatureId:1 To:CGPointMake(22, 15) showMenu:FALSE];
	[layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:1.0] autorelease]];

	for (int i = 2; i <= 4; i++) {
		[self showTalkMessage:2 conversation:1 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(round1_3) Param1:nil Param2:nil Obj:self];
}

-(void) round1_3
{
	BattleField *field = [[layers getFieldLayer] getField];

	[field setCursorTo:CGPointMake(17, 15)];
	
	// NPC
	[field addNpc:[[[FDNpc alloc] initWithDefinition:719 Id:91] autorelease] Position:CGPointMake(17, 13)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:750 Id:92] autorelease] Position:CGPointMake(16, 13)];
	
	[field addNpc:[[[FDNpc alloc] initWithDefinition:750 Id:93] autorelease] Position:CGPointMake(8, 8)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:750 Id:94] autorelease] Position:CGPointMake(24, 7)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:719 Id:95] autorelease] Position:CGPointMake(7, 11)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:719 Id:96] autorelease] Position:CGPointMake(10, 13)];
	
	[self setAiOfId:91 EscapeTo:CGPointMake(20, 2)];
	[self setAiOfId:92 EscapeTo:CGPointMake(20, 2)];
	[self setAiOfId:93 EscapeTo:CGPointMake(20, 2)];
	[self setAiOfId:94 EscapeTo:CGPointMake(20, 2)];
	[self setAiOfId:95 EscapeTo:CGPointMake(20, 2)];
	[self setAiOfId:96 EscapeTo:CGPointMake(20, 2)];
	
	
	[layers moveCreatureId:91 To:CGPointMake(17, 15) showMenu:FALSE];
	
	[layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:0.5] autorelease]];
	
	for (int i = 6; i <= 11; i++) {
		[self showTalkMessage:2 conversation:1 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(round1_4) Param1:nil Param2:nil Obj:self];

	// Add branch activities	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:92 To:CGPointMake(16, 14) showMenu:FALSE];
	
}

-(void) round1_4
{
	BattleField *field = [[layers getFieldLayer] getField];
	
	[field setCursorTo:CGPointMake(10, 21)];
	
	// Enemy
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:21] autorelease] Position:CGPointMake(10, 21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:22] autorelease] Position:CGPointMake(10, 21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:23] autorelease] Position:CGPointMake(10, 21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:24] autorelease] Position:CGPointMake(10, 21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:25] autorelease] Position:CGPointMake(10, 21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:26] autorelease] Position:CGPointMake(10, 21)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:27] autorelease] Position:CGPointMake(3, 9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:27] autorelease] Position:CGPointMake(4, 10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:27] autorelease] Position:CGPointMake(3, 11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:27] autorelease] Position:CGPointMake(2, 12)];
	
	[layers moveCreatureId:21 To:CGPointMake(10, 18) showMenu:FALSE];
	
	[layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:0.5] autorelease]];

	for (int i = 12; i <= 21; i++) {
		[self showTalkMessage:2 conversation:1 sequence:i];
	}

	// Add branch activities	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:22 To:CGPointMake(9, 19) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:23 To:CGPointMake(11, 19) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:24 To:CGPointMake(8, 20) showMenu:FALSE];

	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:25 To:CGPointMake(12, 20) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:26 To:CGPointMake(10, 20) showMenu:FALSE];
	
}

-(void) setAiOfId:(int)creatureId EscapeTo:(CGPoint)pos
{
	BattleField *field = [[layers getFieldLayer] getField];
	
	FDCreature *creature = [field getCreatureById:creatureId];
	creature.data.aiType = AIType_Escape;
	creature.data.aiParam = [[[FDPosition alloc] initX:pos.x Y:pos.y] autorelease];
}


@end
