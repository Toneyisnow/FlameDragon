//
//  EventChapter1.m
//  FlameDragon
//
//  Created by sui toney on 11-12-11.
//  Copyright 2011 ms. All rights reserved.
//

#import "EventChapter1.h"
#import "FDEnemy.h"
#import "FDTalkActivity.h"
#import "BattleField.h"
#import "FDEmptyActivity.h"
#import "FDLocalString.h"
#import "FDDurationActivity.h"
#import "FDTreasure.h"

@implementation EventChapter1

/*
-(id) initWithLayers:(ActionLayers *)l
{
	self = [super initWithLayers:l];
	
	return self;
}
*/

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(round1_1)];
	[self loadTurnEvent:TurnType_Friend Turn:3 Action:@selector(round3)];
	[self loadTurnEvent:TurnType_Friend Turn:4 Action:@selector(round4)];
	[self loadTurnEvent:TurnType_Friend Turn:5 Action:@selector(round5_Boss)];
	[self loadTurnEvent:TurnType_Friend Turn:6 Action:@selector(round6_Npc)];

	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadDieEvent:5 Action:@selector(hanuoDie)];
	[self loadDieEvent:6 Action:@selector(hawateDie)];
	
	[self loadDyingEvent:29 Action:@selector(showBossDyingMessage)];
	
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	//[self loadGameOverEvent];
	
	NSLog(@"Chapter1 events loaded.");
	
}
-(void) round1
{
	// Creatures
	FDFriend *friend1 = [[FDFriend alloc] initWithDefinition:1 Id:1];
	[field addFriend:friend1 Position:CGPointMake(8, 15)];
	[friend1 release];
	
	FDFriend *friend2 = [[FDFriend alloc] initWithDefinition:2 Id:2];
	[field addFriend:friend2 Position:CGPointMake(6, 16)];
	[friend2 release];
	
	FDFriend *friend3 = [[FDFriend alloc] initWithDefinition:3 Id:3];
	[field addFriend:friend3 Position:CGPointMake(9, 17)];
	[friend3 release];
	
	FDFriend *friend4 = [[FDFriend alloc] initWithDefinition:4 Id:4];
	[field addFriend:friend4 Position:CGPointMake(12, 18)];
	[friend4 release];
	
	FDFriend *friend5 = [[FDFriend alloc] initWithDefinition:5 Id:5];
	[field addFriend:friend5 Position:CGPointMake(10, 18)];
	[friend5 release];
	
	FDFriend *friend16 = [[FDFriend alloc] initWithDefinition:1016 Id:16];
	[field addFriend:friend16 Position:CGPointMake(9, 18)];
	[friend16 release];
	
	FDFriend *friend6 = [[FDFriend alloc] initWithDefinition:6 Id:6];
	[field addFriend:friend6 Position:CGPointMake(9, 19)];
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

-(void) round1_1
{
	NSLog(@"Event round1 triggered.");
	
	// Creatures
	FDFriend *friend1 = [[FDFriend alloc] initWithDefinition:1 Id:1];
	[field addFriend:friend1 Position:CGPointMake(8, 20)];
	[friend1 release];
	
	FDFriend *friend2 = [[FDFriend alloc] initWithDefinition:2 Id:2];
	[field addFriend:friend2 Position:CGPointMake(11, 21)];
	[friend2 release];
	
	FDFriend *friend3 = [[FDFriend alloc] initWithDefinition:3 Id:3];
	[field addFriend:friend3 Position:CGPointMake(9,22)];
	[friend3 release];
	
	FDFriend *friend4 = [[FDFriend alloc] initWithDefinition:4 Id:4];
	[field addFriend:friend4 Position:CGPointMake(12, 23)];
	[friend4 release];
	
	[layers moveCreature:friend1 To:CGPointMake(8, 15) showMenu:FALSE];
	
	[layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:0.8] autorelease]];

	for (int i = 1; i <= 5; i++) {
		[self showTalkMessage:1 conversation:1 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(round1_2_1) Param1:nil Param2:nil Obj:self];
	
	// Add branch activities
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:friend2 To:CGPointMake(11, 16) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:friend3 To:CGPointMake(9, 17) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:friend4 To:CGPointMake(12, 18) showMenu:FALSE];
	
	[layers appendToCurrentActivityMethod:@selector(setCursorObjTo:) Param1:[FDPosition positionX:8 Y:15] Param2:nil Obj:field];

}

-(void) round1_2_1
{
	// Enemy
	FDEnemy *enemy1 = [[FDEnemy alloc] initWithDefinition:701 Id:11];
	[field addEnemy: enemy1 Position:CGPointMake(2, 22)];
	[enemy1 release];
	
	FDEnemy *enemy2 = [[FDEnemy alloc] initWithDefinition:701 Id:12];
	[field addEnemy: enemy2 Position:CGPointMake(3, 22)];
	[enemy2 release];
	
	FDEnemy *enemy3 = [[FDEnemy alloc] initWithDefinition:701 Id:13];
	[field addEnemy: enemy3 Position:CGPointMake(4, 23)];
	[enemy3 release];
	
	FDEnemy *enemy4 = [[FDEnemy alloc] initWithDefinition:701 Id:14];
	[field addEnemy: enemy4 Position:CGPointMake(5, 23)];
	[enemy4 release];
	
	[layers moveCreature:enemy3 To:CGPointMake(6, 20) showMenu:FALSE];
	[layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:0.2] autorelease]];

	
	[layers appendToCurrentActivityMethod:@selector(round1_2_2) Param1:nil Param2:nil Obj:self];
	
	
	// Add branch activities
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy2 To:CGPointMake(4, 19) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy4 To:CGPointMake(5, 20) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy1 To:CGPointMake(3, 19) showMenu:FALSE];
	
	
}

-(void) round1_2_2
{
	[field setCursorTo:CGPointMake(3, 3)];
	
	// Enemy
	FDEnemy *enemy5 = [[FDEnemy alloc] initWithDefinition:701 Id:15];
	[field addEnemy: enemy5 Position:CGPointMake(4, 2)];
	[enemy5 release];
	
	FDEnemy *enemy6 = [[FDEnemy alloc] initWithDefinition:701 Id:16];
	[field addEnemy: enemy6 Position:CGPointMake(3, 2)];
	[enemy6 release];
	
	FDEnemy *enemy7 = [[FDEnemy alloc] initWithDefinition:701 Id:17];
	[field addEnemy: enemy7 Position:CGPointMake(2, 3)];
	[enemy7 release];
	
	FDEnemy *enemy8 = [[FDEnemy alloc] initWithDefinition:701 Id:18];
	[field addEnemy: enemy8 Position:CGPointMake(2, 3)];
	[enemy8 release];
	
	[layers moveCreature:enemy5 To:CGPointMake(7, 2) showMenu:FALSE];
	[layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:0.5] autorelease]];

	[layers appendToCurrentActivityMethod:@selector(setCursorObjTo:) Param1:[FDPosition positionX:5 Y:20] Param2:nil Obj:field];
	
	for (int i = 6; i <= 7; i++) {
		[self showTalkMessage:1 conversation:1 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(round1_3) Param1:nil Param2:nil Obj:self];
	
	
	// Add branch activities	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureSimple:enemy8 To:CGPointMake(2, 5)];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy6 To:CGPointMake(5, 3) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy7 To:CGPointMake(3, 3) showMenu:FALSE];

}

-(void) round1_3
{
	FDCreature *enemy = [field getCreatureById:14];
	
	[layers moveCreature:enemy To:CGPointMake(8, 24) showMenu:FALSE];
	
	[layers appendToCurrentActivityMethod:@selector(removeObject:) Param1:enemy Param2:nil Obj:field];
	
	CGPoint pos = [field getObjectPos:[field getCreatureById:1]];
	FDPosition *posObj = [[FDPosition alloc] initX:pos.x Y:pos.y];
	[layers appendToCurrentActivityMethod:@selector(setCursorObjTo:) Param1:posObj Param2:nil Obj:field];
	

	for (int i = 8; i <= 19; i++) {
		[self showTalkMessage:1 conversation:1 sequence:i];
	}
	
}

-(void) round3
{
	NSLog(@"Event round3 triggered.");
	
	FDFriend *friend5 = [[FDFriend alloc] initWithDefinition:5 Id:5];
	[field addFriend:friend5 Position:CGPointMake(12, 12)];
	[friend5 release];
	
	FDFriend *friend6 = [[FDFriend alloc] initWithDefinition:1016 Id:6];
	[field addFriend:friend6 Position:CGPointMake(12, 12)];
	[friend6 release];
	
	[layers moveCreature:friend5 To:CGPointMake(12, 14) showMenu:FALSE];
	[layers moveCreature:friend6 To:CGPointMake(12, 13) showMenu:FALSE];
	
	for (int i = 1; i <= 13; i++) {
		[self showTalkMessage:1 conversation:2 sequence:i];
	}

}

-(void) round4
{
	NSLog(@"Event round4 triggered. Enemy.");
	
	[layers appendToCurrentActivityMethod:@selector(setCursorObjTo:) Param1:[FDPosition positionX:23 Y:23] Param2:nil Obj:field];
	
	FDEnemy *enemy1 = [[FDEnemy alloc] initWithDefinition:701 Id:21];
	[field addEnemy:enemy1 Position:CGPointMake(19, 23)];
	[enemy1 release];
	
	FDEnemy *enemy2 = [[FDEnemy alloc] initWithDefinition:701 Id:22];
	[field addEnemy:enemy2 Position:CGPointMake(20,22)];
	[enemy2 release];
	
	FDEnemy *enemy3 = [[FDEnemy alloc] initWithDefinition:701 Id:23];
	[field addEnemy:enemy3 Position:CGPointMake(21, 21)];
	[enemy3 release];
	
	FDEnemy *enemy4 = [[FDEnemy alloc] initWithDefinition:701 Id:24];
	[field addEnemy:enemy4 Position:CGPointMake(22, 21)];
	[enemy4 release];
	
	[layers moveCreature:enemy1 To:CGPointMake(17, 21) showMenu:FALSE];
	[layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:0.3] autorelease]];
	
	for (int i = 1; i <= 2; i++) {
		[self showTalkMessage:1 conversation:3 sequence:i];
	}
	
	// Add branch activities	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy2 To:CGPointMake(18, 20) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy3 To:CGPointMake(20, 20) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy4 To:CGPointMake(21, 19) showMenu:FALSE];
	
}

-(void) round5_Boss
{
	NSLog(@"Event round5 triggered. Boss.");
	
	FDEnemy *enemy1 = [[FDEnemy alloc] initWithDefinition:701 Id:25];
	[field addEnemy:enemy1 Position:CGPointMake(1, 22)];
	[enemy1 release];
	
	FDEnemy *enemy2 = [[FDEnemy alloc] initWithDefinition:701 Id:26];
	[field addEnemy:enemy2 Position:CGPointMake(2, 22)];
	[enemy2 release];
	
	FDEnemy *enemy3 = [[FDEnemy alloc] initWithDefinition:701 Id:27];
	[field addEnemy:enemy3 Position:CGPointMake(5, 24)];
	[enemy3 release];
	
	FDEnemy *enemy4 = [[FDEnemy alloc] initWithDefinition:701 Id:28];
	[field addEnemy:enemy4 Position:CGPointMake(5, 24)];
	[enemy4 release];
	
	FDEnemy *enemyBoss = [[FDEnemy alloc] initWithDefinition:702 Id:29];
	[field addEnemy:enemyBoss Position:CGPointMake(4, 23)];
	[enemyBoss release];
	
	[layers moveCreature:enemyBoss To:CGPointMake(4, 22) showMenu:FALSE];
	[layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:0.3] autorelease]];
	
	for (int i = 1; i <= 11; i++) {
		[self showTalkMessage:1 conversation:4 sequence:i];
	}
	
	// Add branch activities	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy1 To:CGPointMake(1, 21) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy2 To:CGPointMake(2, 21) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureSimple:enemy3 To:CGPointMake(5, 23)];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy4 To:CGPointMake(6, 24) showMenu:FALSE];
	
}

-(void) round6_Npc
{
	NSLog(@"Event round6 triggered. Npc.");
	
	FDNpc *npc1 = [[FDNpc alloc] initWithDefinition:703 Id:31];
	[field addNpc:npc1 Position:CGPointMake(24, 15)];
	[npc1 release];

	FDNpc *npc2 = [[FDNpc alloc] initWithDefinition:703 Id:32];
	[field addNpc:npc2 Position:CGPointMake(24, 15)];
	[npc2 release];
	
	FDNpc *npc3 = [[FDNpc alloc] initWithDefinition:703 Id:33];
	[field addNpc:npc3 Position:CGPointMake(24, 15)];
	[npc3 release];
	
	FDNpc *npc4 = [[FDNpc alloc] initWithDefinition:703 Id:34];
	[field addNpc:npc4 Position:CGPointMake(24, 15)];
	[npc4 release];
	
	//[layers appendToCurrentActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	//[layers appendToCurrentActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:npc1 To:CGPointMake(18, 15) showMenu:FALSE];
	//[layers moveCreatureSimple:npc1 To:CGPointMake(18, 15)];
	
	[layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:0.3] autorelease]];
	
	for (int i = 1; i <= 6; i++) {
		[self showTalkMessage:1 conversation:5 sequence:i];
	}
	
	// Add branch activities	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureSimple:npc2 To:CGPointMake(19, 15)];
	[layers moveCreatureSimple:npc2 To:CGPointMake(19, 14)];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureSimple:npc3 To:CGPointMake(19, 15)];
	[layers moveCreatureSimple:npc3 To:CGPointMake(19, 16)];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureSimple:npc4 To:CGPointMake(19, 15)];
	[layers moveCreatureSimple:npc4 To:CGPointMake(20, 15)];

	
}

-(void) hanuoDie
{
	NSLog(@"Hanuo Die Triggered.");
	
	
	// Hawate convert to Npc
	FDCreature *hawate = [field getCreatureById:6];
	if (hawate != nil) {
		
		for (int i = 1; i <= 4; i++) {
			[self showTalkMessage:1 conversation:6 sequence:i];
		}
		
		// Convert to Npc
		CGPoint pos = [field getObjectPos:hawate];
		FDNpc *hawateNpc = [[FDNpc alloc] initWithCreature:hawate];
		
		[field addNpc:hawateNpc Position:pos];
		
		[field removeObject:hawate];
	}
}

-(void) hawateDie
{
	// Nothing to do
}

-(void) enemyClear
{
	for (int i = 1; i <= 13; i++) {
		[self showTalkMessage:1 conversation:7 sequence:i];
	}
	
	
	[layers appendToCurrentActivityMethod:@selector(adjustFriends) Param1:nil Param2:nil Obj:self];
	
	// Save some data into Record
	//ChapterRecord *record = [layers composeChapterRecord];
	//[layers appendToCurrentActivityMethod:@selector(gameWin:) Param1:record Param2:nil];
	
	// Save data into BattleField data, and then converted to saved data
	
}

-(void) adjustFriends
{
	// 1. Remove Hawate from friend list
	FDCreature *hawate = [field getCreatureById:6];
	if (hawate != nil) {
		[[field getFriendList] removeObject:hawate];
		[[field getDeadCreatureList] removeObject:hawate];
	}
	
	/*
	FDCreature *hawateDead = [field getDeadCreatureById:6];
	if (hawateDead != nil) {
		[[field getDeadCreatureList] removeObject:hawate];
	}
	*/
	
	// 2. Confirm Hanuo is in the friend list
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

-(void) showBossDyingMessage
{
	[self showTalkMessage:1 conversation:99 sequence:1];
}

-(void) dealloc
{
	[eventHandler release];
	
	[super dealloc];
}

@end
