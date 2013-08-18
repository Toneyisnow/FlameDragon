//
//  EventChapter8.m
//  FlameDragon
//
//  Created by sui toney on 12-12-15.
//  Copyright 2012 ms. All rights reserved.
//

#import "EventChapter8.h"


@implementation EventChapter8

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(round1)];
	[self loadTurnEvent:TurnType_Friend Turn:2 Action:@selector(knightAppear)];
	[self loadTurnEvent:TurnType_Friend Turn:3 Action:@selector(knightAppear)];
	[self loadTurnEvent:TurnType_Friend Turn:4 Action:@selector(knightAppear)];
	[self loadTurnEvent:TurnType_Friend Turn:5 Action:@selector(knightAppear)];
	[self loadTurnEvent:TurnType_Friend Turn:6 Action:@selector(knightAppear)];
	[self loadTurnEvent:TurnType_Friend Turn:7 Action:@selector(knightAppear)];
	
	[self loadTurnEvent:TurnType_Friend Turn:9 Action:@selector(bossStart)];
	
	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	[self loadDyingEvent:199 Action:@selector(showBossDyingMessage)];
	
	knightId = 200;
	
	NSLog(@"Chapter8 events loaded.");
}

-(void) round1
{
	NSLog(@"round1 event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(15, 38)];
	[self settleFriend:2 At:CGPointMake(14, 39)];
	[self settleFriend:3 At:CGPointMake(16, 39)];
	[self settleFriend:4 At:CGPointMake(13, 40)];
	[self settleFriend:5 At:CGPointMake(15, 40)];
	[self settleFriend:6 At:CGPointMake(16, 37)];
	[self settleFriend:7 At:CGPointMake(17, 38)];
	[self settleFriend:8 At:CGPointMake(13, 38)];
	[self settleFriend:9 At:CGPointMake(14, 37)];
	[self settleFriend:10 At:CGPointMake(17, 40)];
	
	[field addFriend:[[[FDFriend alloc] initWithDefinition:11 Id:11] autorelease] Position:CGPointMake(15, 32)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50803 Id:101] autorelease] Position:CGPointMake(13, 26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50803 Id:102] autorelease] Position:CGPointMake(17, 26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50804 Id:103 DropItem:105] autorelease] Position:CGPointMake(13, 22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50804 Id:104] autorelease] Position:CGPointMake(17, 22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50804 Id:105 DropItem:105] autorelease] Position:CGPointMake( 6, 20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50804 Id:106 DropItem:105] autorelease] Position:CGPointMake(24, 20)];

	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50806 Id:107] autorelease] Position:CGPointMake( 9, 19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50806 Id:108] autorelease] Position:CGPointMake(21, 19)];

	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50802 Id:109] autorelease] Position:CGPointMake(15, 25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50802 Id:110 DropItem:102] autorelease] Position:CGPointMake(14, 20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50802 Id:111] autorelease] Position:CGPointMake(16, 20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50802 Id:112 DropItem:204] autorelease] Position:CGPointMake(12, 15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50802 Id:113] autorelease] Position:CGPointMake(18, 15)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50805 Id:114] autorelease] Position:CGPointMake(14, 24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50805 Id:115 DropItem:101] autorelease] Position:CGPointMake(16, 24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50805 Id:116] autorelease] Position:CGPointMake(13, 18)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50805 Id:117] autorelease] Position:CGPointMake(17, 18)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50801 Id:199 DropItem:306] autorelease] Position:CGPointMake(15, 13)];
	
	[self setAiOfId:199 withType:AIType_StandBy];
	
	[field setCursorTo:CGPointMake(21, 43)];
	
	for (int i = 1; i <= 17; i++) {
		[self showTalkMessage:8 conversation:1 sequence:i];
	}
	
}

-(void) knightAppear
{
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50807 Id:++knightId] autorelease] Position:CGPointMake(14, 8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50807 Id:++knightId] autorelease] Position:CGPointMake(16, 8)];
}

-(void) bossStart
{
	[self setAiOfId:199 withType:AIType_Aggressive];
}

-(void) enemyClear
{
	[layers gameCleared];
    
    for (int i = 2; i <= 9; i++) {
		[self showTalkMessage:8 conversation:2 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

-(void) showBossDyingMessage
{
	[self showTalkMessage:8 conversation:2 sequence:1];
}

@end
