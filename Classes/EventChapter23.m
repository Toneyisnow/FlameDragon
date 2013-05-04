//
//  EventChapter23.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter23.h"


@implementation EventChapter23

-(void) loadEvents
{
    [self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
	[self loadTurnEvent:TurnType_Friend Turn:5 Action:@selector(reinforcement)];
	[self loadTurnEvent:TurnType_Friend Turn:8 Action:@selector(reinforcement2)];

	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadDieEvent:25 Action:@selector(gameOver)];
	[self loadDieEvent:199 Action:@selector(enemyClear)];
	
	NSLog(@"Chapter23 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(20,36)];
	[self settleFriend:2 At:CGPointMake(21,36)];
	[self settleFriend:3 At:CGPointMake(22,36)];
	[self settleFriend:4 At:CGPointMake(19,37)];
	[self settleFriend:5 At:CGPointMake(20,37)];
	[self settleFriend:6 At:CGPointMake(21,37)];
	[self settleFriend:7 At:CGPointMake(22,37)];
	[self settleFriend:8 At:CGPointMake(23,37)];
	[self settleFriend:9 At:CGPointMake(19,38)];
	[self settleFriend:10 At:CGPointMake(20,38)];
	[self settleFriend:11 At:CGPointMake(21,38)];
	[self settleFriend:12 At:CGPointMake(22,38)];
	[self settleFriend:13 At:CGPointMake(23,38)];
	[self settleFriend:14 At:CGPointMake(20,39)];
	[self settleFriend:15 At:CGPointMake(21,39)];
	[self settleFriend:16 At:CGPointMake(22,39)];
	
	[field addFriend:[[[FDFriend alloc] initWithDefinition:28 Id:28] autorelease] Position:CGPointMake(20,31)];
	[field addFriend:[[[FDFriend alloc] initWithDefinition:29 Id:29] autorelease] Position:CGPointMake(22,31)];
	
	// Add Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:101] autorelease] Position:CGPointMake(18,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:102] autorelease] Position:CGPointMake(24,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:103] autorelease] Position:CGPointMake(15,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:104] autorelease] Position:CGPointMake(27,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:105] autorelease] Position:CGPointMake(7,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:106] autorelease] Position:CGPointMake(8,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:107] autorelease] Position:CGPointMake(7,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:108] autorelease] Position:CGPointMake(8,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:109] autorelease] Position:CGPointMake(34,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:110] autorelease] Position:CGPointMake(35,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:111] autorelease] Position:CGPointMake(34,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:112] autorelease] Position:CGPointMake(35,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:113] autorelease] Position:CGPointMake(21,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:114] autorelease] Position:CGPointMake(20,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:115] autorelease] Position:CGPointMake(22,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:116] autorelease] Position:CGPointMake(19,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:117] autorelease] Position:CGPointMake(23,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:118] autorelease] Position:CGPointMake(18,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52302 Id:119] autorelease] Position:CGPointMake(24,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52303 Id:120] autorelease] Position:CGPointMake(19,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52303 Id:121] autorelease] Position:CGPointMake(23,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52308 Id:122] autorelease] Position:CGPointMake(20,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52308 Id:123] autorelease] Position:CGPointMake(22,20)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52301 Id:199] autorelease] Position:CGPointMake(21,18)];
	
	// Talk
	for (int i = 1; i <= 12; i++) {
		[self showTalkMessage:23 conversation:1 sequence:i];
	}
}

-(void) reinforcement
{
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52304 Id:201] autorelease] Position:CGPointMake(8,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52304 Id:202] autorelease] Position:CGPointMake(9,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52304 Id:203] autorelease] Position:CGPointMake(10,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52304 Id:204] autorelease] Position:CGPointMake(32,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52304 Id:205] autorelease] Position:CGPointMake(33,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52304 Id:206] autorelease] Position:CGPointMake(34,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52306 Id:207] autorelease] Position:CGPointMake(8,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52306 Id:208] autorelease] Position:CGPointMake(9,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52306 Id:209] autorelease] Position:CGPointMake(10,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52306 Id:210] autorelease] Position:CGPointMake(32,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52306 Id:211] autorelease] Position:CGPointMake(33,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52306 Id:212] autorelease] Position:CGPointMake(34,17)];
	
}

-(void) reinforcement2
{
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52305 Id:213] autorelease] Position:CGPointMake(8,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52305 Id:214] autorelease] Position:CGPointMake(9,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52305 Id:215] autorelease] Position:CGPointMake(10,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52305 Id:216] autorelease] Position:CGPointMake(32,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52305 Id:217] autorelease] Position:CGPointMake(33,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52305 Id:218] autorelease] Position:CGPointMake(34,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52307 Id:219] autorelease] Position:CGPointMake(8,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52307 Id:220] autorelease] Position:CGPointMake(9,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52307 Id:221] autorelease] Position:CGPointMake(10,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52307 Id:222] autorelease] Position:CGPointMake(32,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52307 Id:223] autorelease] Position:CGPointMake(33,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52307 Id:224] autorelease] Position:CGPointMake(34,17)];
	
}

-(void) enemyClear
{
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end
