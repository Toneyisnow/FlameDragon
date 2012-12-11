//
//  EventChapter6.m
//  FlameDragon
//
//  Created by sui toney on 12-12-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "EventChapter6.h"


@implementation EventChapter6


-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(round1)];
	[self loadTurnEvent:TurnType_Friend Turn:10 Action:@selector(round10)];
	[self loadTurnEvent:TurnType_Friend Turn:15 Action:@selector(round15)];
	
	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	[self loadDyingEvent:199 Action:@selector(showBossDyingMessage)];
	
}

-(void) round1
{
	NSLog(@"round1 event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(15, 23)];
	[self settleFriend:2 At:CGPointMake( 8, 24)];
	[self settleFriend:3 At:CGPointMake(11, 26)];
	[self settleFriend:4 At:CGPointMake(16, 24)];
	[self settleFriend:5 At:CGPointMake(15, 26)];
	[self settleFriend:6 At:CGPointMake(17, 25)];
	[self settleFriend:7 At:CGPointMake(10, 25)];
	[self settleFriend:8 At:CGPointMake(13, 26)];
	
	[field addNpc:[[[FDNpc alloc] initWithDefinition:50606 Id:51] autorelease] Position:CGPointMake(11,23)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:50606 Id:52] autorelease] Position:CGPointMake(13,23)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:50606 Id:53] autorelease] Position:CGPointMake(12,25)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:50606 Id:54] autorelease] Position:CGPointMake(14,25)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50603 Id:101] autorelease] Position:CGPointMake(11, 15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50603 Id:102] autorelease] Position:CGPointMake(12, 14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50608 Id:103] autorelease] Position:CGPointMake( 9, 15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50608 Id:104] autorelease] Position:CGPointMake(13, 15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50605 Id:105] autorelease] Position:CGPointMake(10, 14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50605 Id:106] autorelease] Position:CGPointMake(14, 14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50602 Id:107] autorelease] Position:CGPointMake(10, 17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50602 Id:108] autorelease] Position:CGPointMake(11, 16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50602 Id:109] autorelease] Position:CGPointMake(12, 16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50602 Id:110] autorelease] Position:CGPointMake(13, 17)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50603 Id:111] autorelease] Position:CGPointMake( 8,  9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50603 Id:112] autorelease] Position:CGPointMake(12,  9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50608 Id:113] autorelease] Position:CGPointMake(10,  7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50608 Id:114] autorelease] Position:CGPointMake(10, 11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50605 Id:115] autorelease] Position:CGPointMake( 7, 11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50605 Id:116] autorelease] Position:CGPointMake(14, 11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50602 Id:117] autorelease] Position:CGPointMake( 9,  8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50602 Id:118] autorelease] Position:CGPointMake(11,  8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50602 Id:119] autorelease] Position:CGPointMake(11, 10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50602 Id:120] autorelease] Position:CGPointMake( 9, 10)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50601 Id:199] autorelease] Position:CGPointMake(10, 9)];
	
	[layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:0.5] autorelease]];
	
	for (int i = 1; i <= 18; i++) {
		[self showTalkMessage:6 conversation:1 sequence:i];
	}
}

-(void) round10
{
	// If boss has dead, return
	if ([field getDeadCreatureById:199] != nil) {
		return;
	}
	
	for (int i = 1; i <= 6; i++) {
		[self showTalkMessage:6 conversation:2 sequence:i];
	}
}

-(void) round15
{
	// If boss has dead, return
	if ([field getDeadCreatureById:199] != nil) {
		return;
	}
	
	
}

-(void) showBossDyingMessage
{
	[self showTalkMessage:6 conversation:4 sequence:1];
	[self showTalkMessage:6 conversation:4 sequence:2];
	
}

-(void) enemyClear
{
	// Beikewei appears
	FDFriend *friend9 = [[FDFriend alloc] initWithDefinition:9 Id:9];
	[field addFriend:friend9 Position:CGPointMake(12, 26)];
	[friend9 release];
	
	[layers moveCreatureId:9 To:CGPointMake(12, 23) showMenu:FALSE];
	
	for (int i = 1; i <= 19; i++) {
		[self showTalkMessage:6 conversation:5 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}


@end
