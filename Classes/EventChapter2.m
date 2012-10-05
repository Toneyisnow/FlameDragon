//
//  EventChapter2.m
//  FlameDragon
//
//  Created by sui toney on 12-4-1.
//  Copyright 2012 ms. All rights reserved.
//

#import "EventChapter2.h"
#import "FDEnemy.h"
#import "FDRandom.h"
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
	[self loadTurnEvent:TurnType_Friend Turn:3 Action:@selector(round3)];

	[self loadDieEvent:1 Action:@selector(gameOver)];

	[self loadDyingEvent:91 Action:@selector(showNpcDyingMessage91)];
	[self loadDyingEvent:92 Action:@selector(showNpcDyingMessage92)];
	[self loadDyingEvent:93 Action:@selector(showNpcDyingMessage93)];
	[self loadDyingEvent:94 Action:@selector(showNpcDyingMessage94)];
	[self loadDyingEvent:95 Action:@selector(showNpcDyingMessage95)];
	[self loadDyingEvent:96 Action:@selector(showNpcDyingMessage96)];

	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	[self loadTeamEvent:CreatureType_Npc Action:@selector(gameOver)];

	NSLog(@"Chapter2 events loaded.");
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
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:28] autorelease] Position:CGPointMake(4, 10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:29] autorelease] Position:CGPointMake(3, 11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:30] autorelease] Position:CGPointMake(2, 12)];
	
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

-(void) round3
{
	BattleField *field = [[layers getFieldLayer] getField];
	
	[layers appendToCurrentActivityMethod:@selector(setCursorObjTo:) Param1:[FDPosition positionX:16 Y:1] Param2:nil Obj:field];
	
	// Enemy
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:31] autorelease] Position:CGPointMake(16, 1)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:32] autorelease] Position:CGPointMake(16, 1)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:33] autorelease] Position:CGPointMake(16, 1)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:34] autorelease] Position:CGPointMake(16, 1)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:35] autorelease] Position:CGPointMake(16, 1)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:701 Id:36] autorelease] Position:CGPointMake(16, 1)];
	
	
	[layers moveCreatureId:31 To:CGPointMake(16, 4) showMenu:FALSE];
	
	[layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:0.5] autorelease]];
	
	for (int i = 1; i <= 6; i++) {
		[self showTalkMessage:2 conversation:2 sequence:i];
	}
	
	// Add branch activities	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:32 To:CGPointMake(15, 3) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:33 To:CGPointMake(17, 3) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:34 To:CGPointMake(14, 2) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:35 To:CGPointMake(18, 2) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:36 To:CGPointMake(16, 2) showMenu:FALSE];
	
	[self setAiOfId:91 EscapeTo:CGPointMake(26, 20)];
	[self setAiOfId:92 EscapeTo:CGPointMake(26, 20)];
	[self setAiOfId:93 EscapeTo:CGPointMake(26, 20)];
	[self setAiOfId:94 EscapeTo:CGPointMake(26, 20)];
	[self setAiOfId:95 EscapeTo:CGPointMake(26, 20)];
	[self setAiOfId:96 EscapeTo:CGPointMake(26, 20)];
}

-(void) enemyClear
{
	BattleField *field = [[layers getFieldLayer] getField];
	
	// Select one of the messages
	if ([[field getNpcList] count] == 6) {
		isAllNpcSaved = TRUE;
	} else {
		isAllNpcSaved = FALSE;
	}
	
	NSString *talkMessage = [FDLocalString chapter:2 conversation:3 sequence:1 choice:(isAllNpcSaved ? 'B' : 'A')];
	FDCreature *creature = [field getCreatureById:92];
	if (creature == nil) {
		creature = [field getDeadCreatureById:92];
	}
	
	FDTalkActivity *talk = [[FDTalkActivity alloc] initWithCreature:creature Message:talkMessage Layer:[layers getMessageLayer]];
	[layers appendToCurrentActivity:talk];
	
	[layers appendToCurrentActivityMethod:@selector(enemyClear_2) Param1:nil Param2:nil Obj:self];
	
	// Save some data into Record
}

-(void) enemyClear_2
{
	BattleField *field = [[layers getFieldLayer] getField];

	// Xiliya appears
	FDFriend *friend6 = [[FDFriend alloc] initWithDefinition:6 Id:6];
	[field addFriend:friend6 Position:CGPointMake(23, 5)];
	[friend6 release];
	
	[layers moveCreatureId:6 To:CGPointMake(23, 7) showMenu:FALSE];

	for (int i = 2; i <= 24; i++) {
		[self showTalkMessage:2 conversation:3 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(adjustFriends) Param1:nil Param2:nil Obj:self];
	
	// Save some data into Record
	//ChapterRecord *record = [layers composeChapterRecord];
	//[layers appendToCurrentActivityMethod:@selector(gameWin:) Param1:record Param2:nil];
	
	// Save data into BattleField data, and then converted to saved data
	
}

-(void) adjustFriends
{
	BattleField *field = [[layers getFieldLayer] getField];
	
	// Add Power Medician to Creature 1
	if (isAllNpcSaved) {
		
		for (int i = 1; i <= 6; i++) {
			FDCreature *creature = [field getCreatureById:i];
			if ([creature.data.itemList count] < [CreatureData ITEM_MAX]) {
				// Add item
				
				break;
			}
		}	
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

-(void) showNpcDyingMessage91
{
	[self showTalkMessage:2 conversation:91 sequence:1];
}
-(void) showNpcDyingMessage92
{
	[self showTalkMessage:2 conversation:92 sequence:1];
}
-(void) showNpcDyingMessage93
{
	[self showTalkMessage:2 conversation:93 sequence:1];
}
-(void) showNpcDyingMessage94
{
	[self showTalkMessage:2 conversation:94 sequence:1];
}
-(void) showNpcDyingMessage95
{
	[self showTalkMessage:2 conversation:95 sequence:1];
}
-(void) showNpcDyingMessage96
{
	[self showTalkMessage:2 conversation:96 sequence:1];
}

-(void) setAiOfId:(int)creatureId EscapeTo:(CGPoint)pos
{
	BattleField *field = [[layers getFieldLayer] getField];
	
	FDCreature *creature = [field getCreatureById:creatureId];
	
	if (creature != nil) {
		creature.data.aiType = AIType_Escape;
		creature.data.aiParam = [[[FDPosition alloc] initX:pos.x Y:pos.y] autorelease];
	}
}


@end
