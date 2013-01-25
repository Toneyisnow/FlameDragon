//
//  EventChapter10.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter10.h"


@implementation EventChapter10

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
	[self loadTurnEvent:TurnType_Friend Turn:5 Action:@selector(reinforcement)];
	
	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	[self loadDyingEvent:199 Action:@selector(bossDyingMessage)];
	
	NSLog(@"Chapter8 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(18, 41)];
	[self settleFriend:2 At:CGPointMake(16, 43)];
	[self settleFriend:3 At:CGPointMake(14, 43)];
	[self settleFriend:4 At:CGPointMake(15, 42)];
	[self settleFriend:5 At:CGPointMake(17, 42)];
	[self settleFriend:6 At:CGPointMake(14, 41)];
	[self settleFriend:7 At:CGPointMake(18, 43)];
	[self settleFriend:8 At:CGPointMake(15, 44)];
	[self settleFriend:9 At:CGPointMake(17, 44)];
	[self settleFriend:10 At:CGPointMake(14, 45)];
	[self settleFriend:11 At:CGPointMake(18, 45)];
	// [self settleFriend:13 At:CGPointMake(16, 41)];
	
	[field addFriend:[[[FDFriend alloc] initWithDefinition:13 Id:13] autorelease] Position:CGPointMake(16, 41)];
	
	// Add Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51004 Id:101] autorelease] Position:CGPointMake(14,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51004 Id:102] autorelease] Position:CGPointMake(18,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51004 Id:103] autorelease] Position:CGPointMake( 8,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51004 Id:104] autorelease] Position:CGPointMake(24,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51004 Id:105] autorelease] Position:CGPointMake(13,15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51004 Id:106] autorelease] Position:CGPointMake(19,15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51004 Id:107] autorelease] Position:CGPointMake(15, 7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51004 Id:108] autorelease] Position:CGPointMake(17, 7)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51002 Id:109] autorelease] Position:CGPointMake(15,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51002 Id:110] autorelease] Position:CGPointMake(17,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51002 Id:111] autorelease] Position:CGPointMake( 9,27)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51002 Id:112] autorelease] Position:CGPointMake(23,27)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51002 Id:113] autorelease] Position:CGPointMake( 5,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51002 Id:114] autorelease] Position:CGPointMake( 7,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51002 Id:115] autorelease] Position:CGPointMake(25,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51002 Id:116] autorelease] Position:CGPointMake(27,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51002 Id:117] autorelease] Position:CGPointMake(15,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51002 Id:118] autorelease] Position:CGPointMake(17,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51002 Id:119] autorelease] Position:CGPointMake( 9,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51002 Id:120] autorelease] Position:CGPointMake(23,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51002 Id:121] autorelease] Position:CGPointMake(13, 6)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51002 Id:122] autorelease] Position:CGPointMake(19, 6)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51002 Id:123] autorelease] Position:CGPointMake(11, 5)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51002 Id:124] autorelease] Position:CGPointMake(21, 5)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51003 Id:125] autorelease] Position:CGPointMake(13,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51003 Id:126] autorelease] Position:CGPointMake(19,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51003 Id:127] autorelease] Position:CGPointMake( 6,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51003 Id:128] autorelease] Position:CGPointMake(26,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51003 Id:129] autorelease] Position:CGPointMake(14,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51003 Id:130] autorelease] Position:CGPointMake(18,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51003 Id:131] autorelease] Position:CGPointMake(13, 4)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51003 Id:132] autorelease] Position:CGPointMake(19, 4)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51005 Id:133] autorelease] Position:CGPointMake(14,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51005 Id:134] autorelease] Position:CGPointMake(18,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51003 Id:135] autorelease] Position:CGPointMake(13,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51003 Id:136] autorelease] Position:CGPointMake(19,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51003 Id:137] autorelease] Position:CGPointMake(14, 4)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51003 Id:138] autorelease] Position:CGPointMake(18, 4)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51001 Id:199] autorelease] Position:CGPointMake(16, 5)];
	
	// Add NPC
	[field addNpc:[[[FDNpc alloc] initWithDefinition:901 Id:901] autorelease] Position:CGPointMake(25, 9)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition: 12 Id: 12] autorelease] Position:CGPointMake( 7, 9)];
	FDCreature *c901 = [field getCreatureById:901];
	FDCreature *c12 = [field getCreatureById:12];
	c901.data.statusFrozen = 255;
	c12.data.statusFrozen = 255;
	
	
	// Talk
	for (int i = 1; i <= 12; i++) {
		[self showTalkMessage:10 conversation:1 sequence:i];
	}
	
}

-(void) reinforcement
{
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51006 Id:201] autorelease] Position:CGPointMake(17,41)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51006 Id:202] autorelease] Position:CGPointMake(15,41)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51006 Id:203] autorelease] Position:CGPointMake(16,42)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51006 Id:204] autorelease] Position:CGPointMake(14,42)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51006 Id:205] autorelease] Position:CGPointMake(17,43)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51006 Id:206] autorelease] Position:CGPointMake(15,43)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51006 Id:207] autorelease] Position:CGPointMake(16,44)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51006 Id:208] autorelease] Position:CGPointMake(14,44)];
	
	for (int i = 1; i <= 3; i++) {
		[self showTalkMessage:10 conversation:2 sequence:i];
	}
}

-(void) bossDyingMessage
{
	for (int i = 1; i <= 5; i++) {
		[self showTalkMessage:10 conversation:3 sequence:i];
	}
}

-(void) enemyClear
{
	FDCreature *suofeiyaNpc = [field getCreatureById:12];
	
	FDFriend *suofeiya = [[FDFriend alloc] initWithDefinition:12 Id:12];
	[field addFriend:suofeiya Position:[field getObjectPos:suofeiyaNpc]];
	[suofeiya release];
	
	for (int i = 1; i <= 35; i++) {
		[self showTalkMessage:10 conversation:4 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end
