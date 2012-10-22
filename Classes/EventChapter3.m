//
//  EventChapter3.m
//  FlameDragon
//
//  Created by sui toney on 12-10-10.
//  Copyright 2012 ms. All rights reserved.
//

#import "EventChapter3.h"
#import "FDEmptyActivity.h"
#import "FDDurationActivity.h"

@implementation EventChapter3

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(round1_1)];
	[self loadTurnEvent:TurnType_Enemy Turn:2 Action:@selector(round2)];
	
	[self loadDyingEvent:7 Action:@selector(tienuoDyingMessage)];
	[self loadDyingEvent:40 Action:@selector(showBossDyingMessage)];
	
	[self loadDieEvent:1 Action:@selector(gameOver)];
	
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	NSLog(@"Chapter3 events loaded.");
}

-(void) round1_1
{
	NSLog(@"round1 event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake( 8, 23)];
	[self settleFriend:2 At:CGPointMake(10, 23)];
	[self settleFriend:3 At:CGPointMake( 9, 24)];
	[self settleFriend:4 At:CGPointMake(11, 24)];
	[self settleFriend:5 At:CGPointMake(10, 25)];
	[self settleFriend:6 At:CGPointMake( 8, 25)];
	
	[layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:1.0] autorelease]];

	for (int i = 1; i <= 2; i++) {
		[self showTalkMessage:3 conversation:1 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(round1_2) Param1:nil Param2:nil Obj:self];
}

-(void) round1_2
{
	[field addNpc:[[[FDNpc alloc] initWithDefinition:7 Id:7] autorelease] Position:CGPointMake(9, 6)];
	
	[field setCursorTo:CGPointMake(15, 14)];
	
	[layers moveCreatureId:7 To:CGPointMake(9, 12) showMenu:FALSE];
	[self showTalkMessage:3 conversation:1 sequence:3];
	
	[layers appendToCurrentActivityMethod:@selector(round1_3) Param1:nil Param2:nil Obj:self];
}

-(void) round1_3
{
	CGPoint startPoints[8] = 
		{
			CGPointMake(9, 5),
			CGPointMake(10, 5),
			CGPointMake(8, 4),
			CGPointMake(11, 4),
			CGPointMake(9, 3),
			CGPointMake(10, 3),
			CGPointMake(7, 3),
			CGPointMake(12, 3)
	};
	
	for (int i = 0; i < 8; i++) {
		[field addEnemy:[[[FDEnemy alloc] initWithDefinition:704 Id:(21+i)] autorelease] Position:startPoints[i]];
	}
	
	[layers moveCreatureId:21 To:CGPointMake(startPoints[0].x, startPoints[0].y+6) showMenu:FALSE];
	
	for (int i = 4; i <= 14; i++) {
		[self showTalkMessage:3 conversation:1 sequence:i];
	}
		
	// Add branch activities
	for (int i = 1; i < 8; i++) {
		[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
		[layers moveCreatureId:(21+i) To:CGPointMake(startPoints[i].x, startPoints[i].y+6) showMenu:FALSE];
	}
}

-(void) round2
{
	NSLog(@"round2 event triggered.");

	if ([field getDeadCreatureById:7] != nil)
	{
		// If Tienuo dead, nothing will happen
		return;
	}
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:704 Id:29] autorelease] Position:CGPointMake(7, 1)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:704 Id:30] autorelease] Position:CGPointMake(9, 1)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:704 Id:31] autorelease] Position:CGPointMake(11, 1)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:704 Id:32] autorelease] Position:CGPointMake(8, 2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:704 Id:33] autorelease] Position:CGPointMake(10, 2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:704 Id:34] autorelease] Position:CGPointMake(9, 3)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:704 Id:35] autorelease] Position:CGPointMake(7, 26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:704 Id:36] autorelease] Position:CGPointMake(8, 25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:704 Id:37] autorelease] Position:CGPointMake(9, 24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:704 Id:38] autorelease] Position:CGPointMake(10, 25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:704 Id:39] autorelease] Position:CGPointMake(11, 26)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:743 Id:40] autorelease] Position:CGPointMake(9, 26)];

	for (int i = 1; i <= 7; i++) {
		[self showTalkMessage:3 conversation:2 sequence:i];
	}
}

-(void) enemyClear
{
	if ([field getDeadCreatureById:7] != nil) {
		// If Tienuo dead
		for (int i = 1; i <= 5; i++) {
			[self showTalkMessage:3 conversation:3 sequence:i];
		}
		return;
	} else {
		// If Tienuo is alive
		for (int i = 2; i <= 11; i++) {
			[self showTalkMessage:3 conversation:4 sequence:i];
		}
		return;
	}

	[layers appendToCurrentActivityMethod:@selector(adjustFriends) Param1:nil Param2:nil Obj:self];
}

-(void) adjustFriends
{
	if ([field getDeadCreatureById:7] == nil) {
		
		FDFriend *tienuo = [[FDFriend alloc] initWithDefinition:7 Id:7];
		[[field getFriendList] addObject:tienuo];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

-(void) tienuoDyingMessage
{
	[self showTalkMessage:3 conversation:99 sequence:1];
}

-(void) showBossDyingMessage
{
	[self showTalkMessage:3 conversation:4 sequence:1];
}

@end
