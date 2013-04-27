//
//  EventChapter18.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter18.h"


@implementation EventChapter18

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
	[self loadTurnEvent:TurnType_Friend Turn:5 Action:@selector(npcStart)];
	[self loadTurnEvent:TurnType_Friend Turn:8 Action:@selector(reinforcement)];
	
	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadDieEvent:20 Action:@selector(gameOver)];
	[self loadDieEvent:21 Action:@selector(gameOver)];
	[self loadDieEvent:199 Action:@selector(enemyClear)];
	
	NSLog(@"Chapter18 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(7,9)];
	[self settleFriend:2 At:CGPointMake(7,7)];
	[self settleFriend:3 At:CGPointMake(7,11)];
	[self settleFriend:4 At:CGPointMake(6,13)];
	[self settleFriend:5 At:CGPointMake(5,11)];
	[self settleFriend:6 At:CGPointMake(5,9)];
	[self settleFriend:7 At:CGPointMake(5,7)];
	[self settleFriend:8 At:CGPointMake(6,5)];
	[self settleFriend:9 At:CGPointMake(4,8)];
	[self settleFriend:10 At:CGPointMake(3,10)];
	[self settleFriend:11 At:CGPointMake(4,12)];
	[self settleFriend:12 At:CGPointMake(3,14)];
	[self settleFriend:13 At:CGPointMake(2,13)];
	[self settleFriend:14 At:CGPointMake(2,11)];
	[self settleFriend:15 At:CGPointMake(1,9)];
	[self settleFriend:16 At:CGPointMake(2,16)];
	
	// Add Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51802 Id:101] autorelease] Position:CGPointMake(38,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51802 Id:102] autorelease] Position:CGPointMake(40,6)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51802 Id:103] autorelease] Position:CGPointMake(40,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51802 Id:104] autorelease] Position:CGPointMake(43,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51802 Id:105] autorelease] Position:CGPointMake(46,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51803 Id:106] autorelease] Position:CGPointMake(35,15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51803 Id:107] autorelease] Position:CGPointMake(38,15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51803 Id:108] autorelease] Position:CGPointMake(36,18)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51803 Id:109] autorelease] Position:CGPointMake(39,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51803 Id:110] autorelease] Position:CGPointMake(41,3)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51803 Id:111] autorelease] Position:CGPointMake(41,1)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51804 Id:112] autorelease] Position:CGPointMake(36,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51804 Id:113] autorelease] Position:CGPointMake(37,7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51804 Id:114] autorelease] Position:CGPointMake(37,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51804 Id:115] autorelease] Position:CGPointMake(38,6)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51804 Id:116] autorelease] Position:CGPointMake(38,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51804 Id:117] autorelease] Position:CGPointMake(45,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51804 Id:118] autorelease] Position:CGPointMake(46,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51804 Id:119] autorelease] Position:CGPointMake(46,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51804 Id:120] autorelease] Position:CGPointMake(47,7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51804 Id:121] autorelease] Position:CGPointMake(47,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51805 Id:122] autorelease] Position:CGPointMake(39,7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51805 Id:123] autorelease] Position:CGPointMake(39,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51805 Id:124] autorelease] Position:CGPointMake(49,7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51805 Id:125] autorelease] Position:CGPointMake(49,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51806 Id:126] autorelease] Position:CGPointMake(40,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51806 Id:127] autorelease] Position:CGPointMake(44,6)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51806 Id:128] autorelease] Position:CGPointMake(44,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51806 Id:129] autorelease] Position:CGPointMake(47,9)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51802 Id:130] autorelease] Position:CGPointMake(40,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51805 Id:131] autorelease] Position:CGPointMake(39,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51805 Id:132] autorelease] Position:CGPointMake(41,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51806 Id:133] autorelease] Position:CGPointMake(41,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51806 Id:134] autorelease] Position:CGPointMake(39,25)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51801 Id:199] autorelease] Position:CGPointMake(49,9)];
	
	for (int i = 130; i <= 134; i++) {
		[self setAiOfId:i withType:AIType_StandBy];
	}
	
	// Add NPC
	[field addNpc:[[[FDNpc alloc] initWithDefinition:20 Id:20] autorelease] Position:CGPointMake(23, 9)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:21 Id:21] autorelease] Position:CGPointMake(23, 8)];
    [self setAiOfId:20 withType:AIType_StandBy];
    [self setAiOfId:21 withType:AIType_StandBy];
	
	// Talk
	for (int i = 1; i <= 24; i++) {
		[self showTalkMessage:18 conversation:1 sequence:i];
	}
}

-(void) npcStart {
   
    [self setAiOfId:20 withType:AIType_Aggressive];
    [self setAiOfId:21 withType:AIType_Aggressive];
}

-(void) reinforcement {
	
	for (int i = 130; i <= 134; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51803 Id:135] autorelease] Position:CGPointMake(7,3)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51803 Id:136] autorelease] Position:CGPointMake(7,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51807 Id:137] autorelease] Position:CGPointMake(7,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51807 Id:138] autorelease] Position:CGPointMake(7,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51804 Id:139] autorelease] Position:CGPointMake(1,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51804 Id:140] autorelease] Position:CGPointMake(2,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51804 Id:141] autorelease] Position:CGPointMake(3,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51804 Id:142] autorelease] Position:CGPointMake(1,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51804 Id:143] autorelease] Position:CGPointMake(2,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51804 Id:144] autorelease] Position:CGPointMake(3,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51804 Id:145] autorelease] Position:CGPointMake(3,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51804 Id:146] autorelease] Position:CGPointMake(4,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51805 Id:147] autorelease] Position:CGPointMake(4,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51805 Id:148] autorelease] Position:CGPointMake(4,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51805 Id:149] autorelease] Position:CGPointMake(4,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51805 Id:150] autorelease] Position:CGPointMake(5,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51805 Id:151] autorelease] Position:CGPointMake(5,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51805 Id:152] autorelease] Position:CGPointMake(5,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51806 Id:153] autorelease] Position:CGPointMake(4,7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51806 Id:154] autorelease] Position:CGPointMake(4,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51806 Id:155] autorelease] Position:CGPointMake(5,7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51806 Id:156] autorelease] Position:CGPointMake(5,8)];
	
	// Talk
	for (int i = 1; i <= 4; i++) {
		[self showTalkMessage:18 conversation:2 sequence:i];
	}
}

-(void) enemyClear
{
	FDCreature *lanNpc = [field getCreatureById:20];
	FDFriend *lan = [[FDFriend alloc] initWithDefinition:20 Id:20];
	[field addFriend:lan Position:[field getObjectPos:lanNpc]];
	[lan release];
	
	FDCreature *yueNpc = [field getCreatureById:21];
	FDFriend *yue = [[FDFriend alloc] initWithDefinition:21 Id:21];
	[field addFriend:yue Position:[field getObjectPos:yueNpc]];
	[yue release];
	
	for (int i = 1; i <= 22; i++) {
		[self showTalkMessage:18 conversation:3 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end
