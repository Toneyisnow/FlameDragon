//
//  EventChapter3.m
//  FlameDragon
//
//  Created by sui toney on 12-10-10.
//  Copyright 2012 ms. All rights reserved.
//

#import "EventChapter3.h"


@implementation EventChapter3

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(round1)];
	[self loadTurnEvent:TurnType_Friend Turn:3 Action:@selector(round3)];
	
	[self loadDieEvent:1 Action:@selector(gameOver)];
	
	[self loadDyingEvent:91 Action:@selector(showNpcDyingMessage91)];
	[self loadDyingEvent:92 Action:@selector(showNpcDyingMessage92)];
	[self loadDyingEvent:93 Action:@selector(showNpcDyingMessage93)];
	[self loadDyingEvent:94 Action:@selector(showNpcDyingMessage94)];
	[self loadDyingEvent:95 Action:@selector(showNpcDyingMessage95)];
	[self loadDyingEvent:96 Action:@selector(showNpcDyingMessage96)];
	
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	[self loadTeamEvent:CreatureType_Npc Action:@selector(gameOver)];
	
	NSLog(@"Chapter3 events loaded.");
}

-(void) round1
{
	NSLog(@"round1 event triggered.");
	
	BattleField *field = [[layers getFieldLayer] getField];
	// Creatures
	
	[self settleFriend:1 At:CGPointMake( 8, 23)];
	[self settleFriend:2 At:CGPointMake(10, 23)];
	[self settleFriend:3 At:CGPointMake( 9, 24)];
	[self settleFriend:4 At:CGPointMake(11, 24)];
	[self settleFriend:5 At:CGPointMake(10, 25)];
	[self settleFriend:6 At:CGPointMake( 8, 25)];
	
	[field addNpc:[[[FDNpc alloc] initWithDefinition:7 Id:7] autorelease] Position:CGPointMake(9, 12)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:704 Id:21] autorelease] Position:CGPointMake(9, 11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:704 Id:22] autorelease] Position:CGPointMake(10, 11)];
	
}

-(void) round3
{
}

@end
