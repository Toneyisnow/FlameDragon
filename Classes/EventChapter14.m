//
//  EventChapter14.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter14.h"


@implementation EventChapter14

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
	[self loadTurnEvent:TurnType_Friend Turn:3 Action:@selector(batch1)];
	[self loadTurnEvent:TurnType_Friend Turn:10 Action:@selector(batch2)];

	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	NSLog(@"Chapter14 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(33,34)];
	[self settleFriend:2 At:CGPointMake(35,33)];
	[self settleFriend:3 At:CGPointMake(34,31)];
	[self settleFriend:4 At:CGPointMake(37,31)];
	[self settleFriend:5 At:CGPointMake(38,34)];
	[self settleFriend:6 At:CGPointMake(36,36)];
	[self settleFriend:7 At:CGPointMake(33,36)];
	[self settleFriend:8 At:CGPointMake(30,35)];
	[self settleFriend:9 At:CGPointMake(30,38)];
	[self settleFriend:10 At:CGPointMake(35,38)];
	[self settleFriend:11 At:CGPointMake(38,37)];
	[self settleFriend:12 At:CGPointMake(40,32)];
	[self settleFriend:13 At:CGPointMake(35,29)];
	[self settleFriend:14 At:CGPointMake(28,37)];
	[self settleFriend:15 At:CGPointMake(30,33)];
	[self settleFriend:16 At:CGPointMake(31,30)];
	
	// Add Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51404 Id:101] autorelease] Position:CGPointMake(20,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51404 Id:102] autorelease] Position:CGPointMake(12,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51404 Id:103 DropItem:901] autorelease] Position:CGPointMake(31,13)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51401 Id:104] autorelease] Position:CGPointMake(17,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51401 Id:105] autorelease] Position:CGPointMake(22,18)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51401 Id:106] autorelease] Position:CGPointMake(26,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51401 Id:107] autorelease] Position:CGPointMake(17,10)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:108] autorelease] Position:CGPointMake(14,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:109] autorelease] Position:CGPointMake(15,27)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:110] autorelease] Position:CGPointMake(17,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:111] autorelease] Position:CGPointMake(21,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:112 DropItem:103] autorelease] Position:CGPointMake(20,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:113] autorelease] Position:CGPointMake(23,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:114] autorelease] Position:CGPointMake(24,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:115] autorelease] Position:CGPointMake(29,6)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:116] autorelease] Position:CGPointMake(23,7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:117] autorelease] Position:CGPointMake(21,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:118] autorelease] Position:CGPointMake(18,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:119] autorelease] Position:CGPointMake(16,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:120] autorelease] Position:CGPointMake(11,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:121] autorelease] Position:CGPointMake(8,24)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51403 Id:122] autorelease] Position:CGPointMake(18,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51403 Id:123 DropItem:902] autorelease] Position:CGPointMake(10,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51403 Id:124] autorelease] Position:CGPointMake(24,18)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51403 Id:125] autorelease] Position:CGPointMake(15,14)];

	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51405 Id:126] autorelease] Position:CGPointMake(18,18)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51405 Id:127 DropItem:339] autorelease] Position:CGPointMake(13,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51405 Id:128] autorelease] Position:CGPointMake(5,22)];
	
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51404 Id:129 DropItem:106] autorelease] Position:CGPointMake(2,3)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51404 Id:130] autorelease] Position:CGPointMake(21,3)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51404 Id:131] autorelease] Position:CGPointMake(10,9)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51401 Id:132] autorelease] Position:CGPointMake(8,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51401 Id:133] autorelease] Position:CGPointMake(10,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51401 Id:134] autorelease] Position:CGPointMake(13,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51401 Id:135] autorelease] Position:CGPointMake(5,5)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:136] autorelease] Position:CGPointMake(19,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:137] autorelease] Position:CGPointMake(11,15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:138 DropItem:804] autorelease] Position:CGPointMake(8,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:139] autorelease] Position:CGPointMake(1,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:140] autorelease] Position:CGPointMake(5,15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:141] autorelease] Position:CGPointMake(8,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:142] autorelease] Position:CGPointMake(16,7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:143 DropItem:901] autorelease] Position:CGPointMake(16,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:144] autorelease] Position:CGPointMake(11,6)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:145] autorelease] Position:CGPointMake(8,7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:146] autorelease] Position:CGPointMake(6,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51402 Id:147] autorelease] Position:CGPointMake(3,8)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51403 Id:148 DropItem:901] autorelease] Position:CGPointMake(5,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51403 Id:149] autorelease] Position:CGPointMake(18,5)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51403 Id:150] autorelease] Position:CGPointMake(10,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51403 Id:151] autorelease] Position:CGPointMake(7,3)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51405 Id:152 DropItem:107] autorelease] Position:CGPointMake(13,3)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51405 Id:153] autorelease] Position:CGPointMake(3,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51405 Id:154] autorelease] Position:CGPointMake(13,11)];
	
	for (int i = 101; i <= 154; i++) {
		[self setAiOfId:i withType:AIType_StandBy];
	}
	
	// Talk
	for (int i = 1; i <= 4; i++) {
		[self showTalkMessage:14 conversation:1 sequence:i];
	}
}

-(void) batch1
{
	// Talk
	for (int i = 1; i <= 4; i++) {
		[self showTalkMessage:14 conversation:2 sequence:i];
	}
	
	for (int i = 101; i <= 128; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
}

-(void) batch2
{
	for (int i = 129; i <= 154; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
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
	for (int i = 1; i <= 17; i++) {
		[self showTalkMessage:14 conversation:3 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end
