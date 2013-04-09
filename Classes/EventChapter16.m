//
//  EventChapter16.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter16.h"


@implementation EventChapter16

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
	[self loadTurnEvent:TurnType_Friend Turn:8 Action:@selector(batch2)];
	
	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadDieEvent:18 Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	NSLog(@"Chapter16 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(13, 8)];
	[self settleFriend:2 At:CGPointMake(17, 5)];
	[self settleFriend:3 At:CGPointMake(14, 5)];
	[self settleFriend:4 At:CGPointMake(13, 4)];
	[self settleFriend:5 At:CGPointMake(10, 6)];
	[self settleFriend:6 At:CGPointMake(11, 8)];
	[self settleFriend:7 At:CGPointMake(17, 7)];
	[self settleFriend:8 At:CGPointMake(16, 4)];
	[self settleFriend:9 At:CGPointMake(12, 2)];
	[self settleFriend:10 At:CGPointMake(9, 4)];
	[self settleFriend:11 At:CGPointMake(11, 4)];
	[self settleFriend:12 At:CGPointMake(12, 6)];
	[self settleFriend:13 At:CGPointMake(15, 7)];
	[self settleFriend:14 At:CGPointMake(16, 8)];
	[self settleFriend:15 At:CGPointMake(10, 2)];
	[self settleFriend:16 At:CGPointMake(14, 2)];
	
	// Add Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51601 Id:101] autorelease] Position:CGPointMake(17,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51601 Id:102] autorelease] Position:CGPointMake(20,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51601 Id:103] autorelease] Position:CGPointMake(32,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51603 Id:104] autorelease] Position:CGPointMake(17,15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51603 Id:105] autorelease] Position:CGPointMake(18,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51603 Id:106] autorelease] Position:CGPointMake(19,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51603 Id:107] autorelease] Position:CGPointMake(31,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51603 Id:108] autorelease] Position:CGPointMake(30,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51603 Id:109] autorelease] Position:CGPointMake(31,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51603 Id:110] autorelease] Position:CGPointMake(33,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51602 Id:111] autorelease] Position:CGPointMake(16,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51602 Id:112] autorelease] Position:CGPointMake(21,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51604 Id:113] autorelease] Position:CGPointMake(17,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51604 Id:114] autorelease] Position:CGPointMake(16,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51604 Id:115] autorelease] Position:CGPointMake(19,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51604 Id:116] autorelease] Position:CGPointMake(20,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51604 Id:117] autorelease] Position:CGPointMake(29,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51604 Id:118] autorelease] Position:CGPointMake(29,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51604 Id:119] autorelease] Position:CGPointMake(30,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51604 Id:120] autorelease] Position:CGPointMake(32,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51605 Id:121] autorelease] Position:CGPointMake(18,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51605 Id:122] autorelease] Position:CGPointMake(19,15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51605 Id:123] autorelease] Position:CGPointMake(30,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51605 Id:124] autorelease] Position:CGPointMake(34,14)];
	
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51601 Id:125] autorelease] Position:CGPointMake(23,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51601 Id:126] autorelease] Position:CGPointMake(30,35)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51601 Id:127] autorelease] Position:CGPointMake(35,35)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51606 Id:128] autorelease] Position:CGPointMake(31,37)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51606 Id:129] autorelease] Position:CGPointMake(33,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51603 Id:130] autorelease] Position:CGPointMake(22,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51603 Id:131] autorelease] Position:CGPointMake(23,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51603 Id:132] autorelease] Position:CGPointMake(24,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51602 Id:133] autorelease] Position:CGPointMake(32,35)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51602 Id:134] autorelease] Position:CGPointMake(33,36)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51604 Id:135] autorelease] Position:CGPointMake(22,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51604 Id:136] autorelease] Position:CGPointMake(21,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51604 Id:137] autorelease] Position:CGPointMake(24,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51604 Id:138] autorelease] Position:CGPointMake(25,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51604 Id:139] autorelease] Position:CGPointMake(32,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51604 Id:140] autorelease] Position:CGPointMake(32,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51604 Id:141] autorelease] Position:CGPointMake(30,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51604 Id:142] autorelease] Position:CGPointMake(31,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51604 Id:143] autorelease] Position:CGPointMake(30,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51604 Id:144] autorelease] Position:CGPointMake(29,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51605 Id:145] autorelease] Position:CGPointMake(23,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51605 Id:146] autorelease] Position:CGPointMake(20,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51605 Id:147] autorelease] Position:CGPointMake(26,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51605 Id:148] autorelease] Position:CGPointMake(33,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51605 Id:149] autorelease] Position:CGPointMake(31,36)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51608 Id:150] autorelease] Position:CGPointMake( 5,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51608 Id:151] autorelease] Position:CGPointMake(32, 6)];
	
	for (int i = 125; i <= 149; i++) {
		[self setAiOfId:i withType:AIType_StandBy];
	}
	
	// Add NPC
	[field addNpc:[[[FDNpc alloc] initWithDefinition:18 Id:18] autorelease] Position:CGPointMake(23,21)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51607 Id:201] autorelease] Position:CGPointMake(22,21)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51607 Id:201] autorelease] Position:CGPointMake(24,21)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51607 Id:201] autorelease] Position:CGPointMake(23,20)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51607 Id:201] autorelease] Position:CGPointMake(23,22)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51607 Id:201] autorelease] Position:CGPointMake(22,20)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51607 Id:201] autorelease] Position:CGPointMake(24,20)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51607 Id:201] autorelease] Position:CGPointMake(22,22)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51607 Id:201] autorelease] Position:CGPointMake(24,22)];
	
	// Talk
	for (int i = 1; i <= 16; i++) {
		[self showTalkMessage:16 conversation:1 sequence:i];
	}
}

-(void) batch2 {
	
	for (int i = 125; i <= 149; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
}

-(void) enemyClear
{
	BOOL matchCriteria = YES;
	FDCreature *suoer = [field getCreatureById:1];
	if (suoer.data.hpMax < 320) {
		matchCriteria = NO;
	}
	
	if ([[field getNpcList] count] < 5) {
		matchCriteria = NO;
	}
	
	if ([layers getTurnNumber] > 18) {
		matchCriteria = NO;
	}
	
	if (matchCriteria) {
		for (int i = 1; i <= 13; i++) {
			[self showTalkMessage:16 conversation:2 sequence:i];
		}
		
		// Adding Midi to the team
		FDFriend *midi = [[FDFriend alloc] initWithDefinition:18 Id:18];
		[[field getFriendList] addObject:midi];
		[midi release];
		
	} else {
		for (int i = 1; i <= 8; i++) {
			[self showTalkMessage:16 conversation:3 sequence:i];
		}
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end

