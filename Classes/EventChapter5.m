//
//  EventChapter5.m
//  FlameDragon
//
//  Created by sui toney on 12-12-10.
//  Copyright 2012 ms. All rights reserved.
//

#import "EventChapter5.h"
#import "FDDurationActivity.h"
#import "FDEmptyActivity.h"

@implementation EventChapter5

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(round1)];
	[self loadTurnEvent:TurnType_Friend Turn:3 Action:@selector(round3)];
	[self loadTurnEvent:TurnType_Friend Turn:4 Action:@selector(round4)];
	[self loadTurnEvent:TurnType_Friend Turn:7 Action:@selector(round7)];
	
	
	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	
	ed1 = [self loadDieEvent:101 Action:@selector(oneDead)];
	ed2 = [self loadDieEvent:102 Action:@selector(oneDead)];
	ed3 = [self loadDieEvent:103 Action:@selector(oneDead)];
	ed4 = [self loadDieEvent:104 Action:@selector(oneDead)];
	
	int e1 = [self loadPositionEvent:101 AtPosition:CGPointMake( 1, 9) Action:@selector(onEscaped1)];
	int e2 = [self loadPositionEvent:102 AtPosition:CGPointMake(39, 9) Action:@selector(onEscaped2)];
	int e3 = [self loadPositionEvent:103 AtPosition:CGPointMake(15,23) Action:@selector(onEscaped3)];
	int e4 = [self loadPositionEvent:104 AtPosition:CGPointMake(22,23) Action:@selector(onEscaped4)];
	
	[eventHandler setEvent:e1 dependentOn:ed1];
	[eventHandler setEvent:e2 dependentOn:ed2];
	[eventHandler setEvent:e3 dependentOn:ed3];
	[eventHandler setEvent:e4 dependentOn:ed4];
	
	NSLog(@"Chapter5 events loaded.");
}

-(void) round1
{
	NSLog(@"round1 event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(15, 20)];
	[self settleFriend:2 At:CGPointMake(16, 21)];
	[self settleFriend:3 At:CGPointMake(14, 21)];
	[self settleFriend:4 At:CGPointMake(15, 21)];
	[self settleFriend:5 At:CGPointMake(16, 22)];
	[self settleFriend:6 At:CGPointMake(14, 22)];
	[self settleFriend:7 At:CGPointMake(15, 22)];
	
	[field addFriend:[[[FDFriend alloc] initWithDefinition:8 Id:8] autorelease] Position:CGPointMake(10, 9)];
	
	[field addNpc:[[[FDNpc alloc] initWithDefinition:50503 Id:81] autorelease] Position:CGPointMake(17, 8)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:50503 Id:82] autorelease] Position:CGPointMake(16, 9)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:50503 Id:83] autorelease] Position:CGPointMake(16, 10)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:50503 Id:84] autorelease] Position:CGPointMake(17, 11)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50505 Id:21] autorelease] Position:CGPointMake(25, 8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50505 Id:22 DropItem:901] autorelease] Position:CGPointMake(27, 8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50506 Id:23] autorelease] Position:CGPointMake(28, 9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:24 DropItem:802] autorelease] Position:CGPointMake(26, 7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50502 Id:25] autorelease] Position:CGPointMake(26, 9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:26] autorelease] Position:CGPointMake(24, 9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:27 DropItem:102] autorelease] Position:CGPointMake(25, 10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:28 DropItem:101] autorelease] Position:CGPointMake(27, 10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:29] autorelease] Position:CGPointMake(26, 11)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:31] autorelease] Position:CGPointMake(30, 7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:32] autorelease] Position:CGPointMake(31, 7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:33] autorelease] Position:CGPointMake(32, 7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:34 DropItem:802] autorelease] Position:CGPointMake(30, 8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50502 Id:35] autorelease] Position:CGPointMake(31, 8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:36 DropItem:901] autorelease] Position:CGPointMake(32, 8)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:41] autorelease] Position:CGPointMake(30, 10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:42] autorelease] Position:CGPointMake(31, 10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:43] autorelease] Position:CGPointMake(32, 10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:44] autorelease] Position:CGPointMake(30, 11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50502 Id:45 DropItem:101] autorelease] Position:CGPointMake(31, 11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:46] autorelease] Position:CGPointMake(32, 11)];
	
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50505 Id:51 DropItem:108] autorelease] Position:CGPointMake(35, 10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50505 Id:52] autorelease] Position:CGPointMake(37, 10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50506 Id:53] autorelease] Position:CGPointMake(38, 9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:54] autorelease] Position:CGPointMake(36, 7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50508 Id:99 DropItem:214] autorelease] Position:CGPointMake(36, 9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:56] autorelease] Position:CGPointMake(34, 9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:57] autorelease] Position:CGPointMake(35, 8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:58] autorelease] Position:CGPointMake(37, 8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50501 Id:59] autorelease] Position:CGPointMake(36, 11)];
	
	for (int i = 31; i <= 59; i++) {
		[self setAiOfId:i withType:AIType_StandBy];
	}
	[self setAiOfId:99 withType:AIType_StandBy];
	
	[layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:0.5] autorelease]];
	
	for (int i = 1; i <= 15; i++) {
		[self showTalkMessage:5 conversation:1 sequence:i];
	}
}

-(void) round3
{
	for (int i = 31; i <= 59; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
	[self setAiOfId:99 withType:AIType_Aggressive];
	
	[self showTalkMessage:5 conversation:2 sequence:1];
}

-(void) round4
{
	// Npc
	for (int iden = 111; iden <= 116; iden++) {
		[field addNpc:[[[FDNpc alloc] initWithDefinition:50507 Id:iden] autorelease] Position:CGPointMake(22, 1)];
	}
	
	[layers moveCreatureId:111 To:CGPointMake(22, 4) showMenu:FALSE];
	
	[layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:0.5] autorelease]];
	
	for (int i = 1; i <= 3; i++) {
		[self showTalkMessage:5 conversation:3 sequence:i];
	}
	
	// Add branch activities	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:112 To:CGPointMake(21, 3) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:113 To:CGPointMake(23, 3) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:114 To:CGPointMake(20, 2) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:115 To:CGPointMake(24, 2) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:116 To:CGPointMake(22, 2) showMenu:FALSE];
}

-(void) round7
{
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50504 Id:101 DropItem:802] autorelease] Position:CGPointMake( 1, 9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50504 Id:102 DropItem:802] autorelease] Position:CGPointMake(39, 9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50504 Id:103 DropItem:802] autorelease] Around:  CGPointMake(15,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50504 Id:104 DropItem:802] autorelease] Around:  CGPointMake(22,23)];
	
	for (int i = 1; i <= 4; i++) {
		[self showTalkMessage:5 conversation:4 sequence:i];
	}
}

-(void) oneDead
{
	[self showTalkMessage:5 conversation:5 sequence:1];
	
	[eventHandler deactivateEvent:ed1];
	[eventHandler deactivateEvent:ed2];
	[eventHandler deactivateEvent:ed3];
	[eventHandler deactivateEvent:ed4];
	
	[super setAiOfId:101 EscapeTo:CGPointMake( 1, 9)];
	[super setAiOfId:102 EscapeTo:CGPointMake(39, 9)];
	[super setAiOfId:103 EscapeTo:CGPointMake(15, 23)];
	[super setAiOfId:104 EscapeTo:CGPointMake(22, 23)];
}

-(void) onEscaped1
{
	FDCreature *c = [field getCreatureById:101];
	if (c != nil) {
		[field removeObject:c];
	}
}
-(void) onEscaped2
{
	FDCreature *c = [field getCreatureById:102];
	if (c != nil) {
		[field removeObject:c];
	}
}
-(void) onEscaped3
{
	FDCreature *c = [field getCreatureById:103];
	if (c != nil) {
		[field removeObject:c];
	}
}
-(void) onEscaped4
{
	FDCreature *c = [field getCreatureById:104];
	if (c != nil) {
		[field removeObject:c];
	}
}

-(void) enemyClear
{
	for (int i = 1; i <= 20; i++) {
		[self showTalkMessage:5 conversation:6 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}


@end
