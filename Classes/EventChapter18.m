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

	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	[self loadDyingEvent:199 Action:@selector(bossDyingMessage)];
	
	NSLog(@"Chapter18 events loaded.");
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
	
	// Add Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51004 Id:101] autorelease] Position:CGPointMake(14,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51001 Id:199] autorelease] Position:CGPointMake(16, 5)];
	
	for (int i = 119; i <= 138; i++) {
		[self setAiOfId:i withType:AIType_StandBy];
	}
	[self setAiOfId:199 withType:AIType_StandBy];
	
	// Add NPC
	[field addNpc:[[[FDNpc alloc] initWithDefinition:901 Id:901] autorelease] Position:CGPointMake(25, 9)];
	
	// Talk
	for (int i = 1; i <= 12; i++) {
		[self showTalkMessage:10 conversation:1 sequence:i];
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
	[layers gameCleared];
    
    for (int i = 1; i <= 35; i++) {
		[self showTalkMessage:10 conversation:4 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end
