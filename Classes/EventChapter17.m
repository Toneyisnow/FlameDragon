//
//  EventChapter17.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter17.h"
#import "FDDurationActivity.h"

@implementation EventChapter17

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
	[self loadTurnEvent:TurnType_Friend Turn:4 Action:@selector(reinforcement)];
	
	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	[self loadDyingEvent:199 Action:@selector(bossDyingMessage)];
	
	NSLog(@"Chapter17 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	shouldRemoveMidi = NO;
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(24,37)];
	[self settleFriend:2 At:CGPointMake(25,37)];
	[self settleFriend:3 At:CGPointMake(24,38)];
	[self settleFriend:4 At:CGPointMake(25,38)];
	[self settleFriend:5 At:CGPointMake(23,7)];
	[self settleFriend:6 At:CGPointMake(24,7)];
	[self settleFriend:7 At:CGPointMake(23,8)];
	[self settleFriend:8 At:CGPointMake(24,8)];
	[self settleFriend:9 At:CGPointMake(7,24)];
	[self settleFriend:10 At:CGPointMake(8,24)];
	[self settleFriend:11 At:CGPointMake(7,25)];
	[self settleFriend:12 At:CGPointMake(8,25)];
	[self settleFriend:13 At:CGPointMake(39,23)];
	[self settleFriend:14 At:CGPointMake(40,23)];
	[self settleFriend:15 At:CGPointMake(39,24)];
	[self settleFriend:16 At:CGPointMake(40,24)];
	
	if ([field getCreatureById:18] == nil && [field getUnsettledCreatureById:18] == nil) {
		// If Midi was not join, adding Midi Npc
		[field addFriend:[[[FDFriend alloc] initWithDefinition:18 Id:18] autorelease] Position:CGPointMake(24,35)];
		shouldRemoveMidi = YES;
	}
	
	// Add Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51703 Id:101] autorelease] Position:CGPointMake(18,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51703 Id:102] autorelease] Position:CGPointMake(30,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51703 Id:103 DropItem:103] autorelease] Position:CGPointMake(15,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51703 Id:104] autorelease] Position:CGPointMake(32,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51703 Id:105] autorelease] Position:CGPointMake(20,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51703 Id:106] autorelease] Position:CGPointMake(28,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51703 Id:107] autorelease] Position:CGPointMake(24,18)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51705 Id:108] autorelease] Position:CGPointMake(14,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51705 Id:109] autorelease] Position:CGPointMake(33,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51705 Id:110] autorelease] Position:CGPointMake(23,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51705 Id:111] autorelease] Position:CGPointMake(24,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51705 Id:112] autorelease] Position:CGPointMake(25,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51705 Id:113 DropItem:103] autorelease] Position:CGPointMake(14,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51705 Id:114] autorelease] Position:CGPointMake(33,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51705 Id:115] autorelease] Position:CGPointMake(23,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51705 Id:116] autorelease] Position:CGPointMake(24,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51705 Id:117] autorelease] Position:CGPointMake(25,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51704 Id:118 DropItem:103] autorelease] Position:CGPointMake(23,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51704 Id:119] autorelease] Position:CGPointMake(26,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51704 Id:120] autorelease] Position:CGPointMake(22,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51704 Id:121] autorelease] Position:CGPointMake(26,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51704 Id:122] autorelease] Position:CGPointMake(22,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51704 Id:123] autorelease] Position:CGPointMake(26,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51704 Id:124] autorelease] Position:CGPointMake(13,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51704 Id:125] autorelease] Position:CGPointMake(13,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51704 Id:126] autorelease] Position:CGPointMake(35,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51704 Id:127 DropItem:103] autorelease] Position:CGPointMake(35,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51704 Id:128] autorelease] Position:CGPointMake(21,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51704 Id:129] autorelease] Position:CGPointMake(27,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51704 Id:130] autorelease] Position:CGPointMake(24,15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51704 Id:131] autorelease] Position:CGPointMake(21,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51704 Id:132] autorelease] Position:CGPointMake(27,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51702 Id:133] autorelease] Position:CGPointMake(24,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51702 Id:134] autorelease] Position:CGPointMake(23,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51702 Id:135] autorelease] Position:CGPointMake(25,20)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51701 Id:199 DropItem:117] autorelease] Position:CGPointMake(24,19)];
	
	// Talk
	for (int i = 1; i <= 12; i++) {
		[self showTalkMessage:17 conversation:1 sequence:i];
	}
}

-(void) reinforcement
{
	// Add NPC
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51706 Id:201] autorelease] Position:CGPointMake(23,43)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51706 Id:201] autorelease] Position:CGPointMake(24,43)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51706 Id:201] autorelease] Position:CGPointMake(25,43)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51706 Id:201] autorelease] Position:CGPointMake(23,44)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51706 Id:201] autorelease] Position:CGPointMake(24,44)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51706 Id:201] autorelease] Position:CGPointMake(25,44)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51706 Id:201] autorelease] Position:CGPointMake(23,45)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51706 Id:201] autorelease] Position:CGPointMake(25,45)];
	
	for (int i = 1; i <= 3; i++) {
		[self showTalkMessage:17 conversation:2 sequence:i];
	}
}

-(void) bossDyingMessage
{
	for (int i = 1; i <= 6; i++) {
		[self showTalkMessage:17 conversation:3 sequence:i];
	}
}

-(void) enemyClear
{
	if (!shouldRemoveMidi) {
		for (int i = 1; i <= 4; i++) {
			[self showTalkMessage:17 conversation:4 sequence:i];
		}
	} else {
		for (int i = 1; i <= 3; i++) {
			[self showTalkMessage:17 conversation:5 sequence:i];
		}
	}
	
	[layers appendToCurrentActivityMethod:@selector(enemyClear2) Param1:nil Param2:nil Obj:self];
}

-(void) enemyClear2
{
	[field addFriend:[[[FDFriend alloc] initWithDefinition:19 Id:19] autorelease] Position:CGPointMake(24,1)];
	[layers moveCreatureId:19 To:CGPointMake(24, 7) showMenu:FALSE];
	[layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:0.5] autorelease]];
	
	for (int i = 1; i <= 19; i++) {
		[self showTalkMessage:17 conversation:6 sequence:i];
	}
	
	if (shouldRemoveMidi) {
		
		for (FDCreature *c in [field getFriendList]) {
			if (c.identifier == 18) {
				[[field getFriendList] removeObject:c];
				break;
			}
		}
		for (FDCreature *c in [field getDeadCreatureList]) {
			if (c.identifier == 18) {
				[[field getDeadCreatureList] removeObject:c];
				break;
			}
		}
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end
