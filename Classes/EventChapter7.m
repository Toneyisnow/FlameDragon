//
//  EventChapter7.m
//  FlameDragon
//
//  Created by sui toney on 12-12-15.
//  Copyright 2012 ms. All rights reserved.
//

#import "EventChapter7.h"
#import "FDDurationActivity.h"
#import "FDEmptyActivity.h"

@implementation EventChapter7

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(round1)];
	[self loadTurnEvent:TurnType_Friend Turn:2 Action:@selector(batch1)];
	[self loadTurnEvent:TurnType_Friend Turn:5 Action:@selector(batch2)];
	[self loadTurnEvent:TurnType_Friend Turn:9 Action:@selector(batch3)];
	[self loadTurnEvent:TurnType_Friend Turn:10 Action:@selector(kailiAppear)];
	
	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	[self loadDyingEvent:121 Action:@selector(showBossDyingMessage)];
	
	NSLog(@"Chapter7 events loaded.");
}

-(void) round1
{
	NSLog(@"round1 event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(11, 33)];
	[self settleFriend:2 At:CGPointMake(16, 31)];
	[self settleFriend:3 At:CGPointMake(13, 32)];
	[self settleFriend:4 At:CGPointMake(14, 30)];
	[self settleFriend:5 At:CGPointMake(11, 31)];
	[self settleFriend:6 At:CGPointMake(12, 29)];
	[self settleFriend:7 At:CGPointMake(10, 30)];
	[self settleFriend:8 At:CGPointMake( 8, 32)];
	[self settleFriend:9 At:CGPointMake(15, 33)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50702 Id:101] autorelease] Position:CGPointMake(12, 8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50702 Id:102] autorelease] Position:CGPointMake(14, 8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50702 Id:111] autorelease] Position:CGPointMake(16, 8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50702 Id:112 DropItem:102] autorelease] Position:CGPointMake(18, 8)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50704 Id:113] autorelease] Position:CGPointMake(11, 3)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50704 Id:114] autorelease] Position:CGPointMake(17, 3)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50704 Id:103] autorelease] Position:CGPointMake(12, 4)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50704 Id:104 DropItem:102] autorelease] Position:CGPointMake(16, 4)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50701 Id:115] autorelease] Position:CGPointMake(14, 5)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50701 Id:105] autorelease] Position:CGPointMake(13, 6)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50701 Id:106] autorelease] Position:CGPointMake(15, 6)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50701 Id:116] autorelease] Position:CGPointMake(11, 6)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50701 Id:117 DropItem:801] autorelease] Position:CGPointMake(17, 6)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50701 Id:107] autorelease] Position:CGPointMake(12, 7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50701 Id:108 DropItem:901] autorelease] Position:CGPointMake(14, 7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50701 Id:118] autorelease] Position:CGPointMake(16, 7)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50703 Id:109] autorelease] Position:CGPointMake(13, 9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50703 Id:110] autorelease] Position:CGPointMake(15, 9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50703 Id:119] autorelease] Position:CGPointMake(17, 9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50703 Id:120 DropItem:101] autorelease] Position:CGPointMake(19, 9)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50705 Id:122] autorelease] Position:CGPointMake(13, 2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50705 Id:123] autorelease] Position:CGPointMake(15, 2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50705 Id:124] autorelease] Position:CGPointMake(13, 4)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50705 Id:125] autorelease] Position:CGPointMake(15, 4)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50706 Id:121 DropItem:317] autorelease] Position:CGPointMake(14, 3)];
	
	for (int i = 101; i <= 125; i++) {
		[self setAiOfId:i withType:AIType_StandBy];
	}
	
	for (int i = 1; i <= 8; i++) {
		[self showTalkMessage:7 conversation:1 sequence:i];
	}
}	

-(void) batch1
{
	for (int i = 101; i <= 110; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
}

-(void) batch2
{
	for (int i = 111; i <= 120; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
}

-(void) batch3
{
	for (int i = 121; i <= 125; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
}

-(void) kailiAppear
{
	// Check condition
	FDCreature *suoer = [field getCreatureById:1];
	if (suoer == nil) {
		return;
	}
	
	CGPoint pos = [field getObjectPos:suoer];
	if (pos.y > 15)
	{
		NSLog(@"Condition did't match, Kaili will not appear.");
		return;
	}
	
	[field addNpc:[[[FDNpc alloc] initWithDefinition:10 Id:10] autorelease] Position:CGPointMake(27, 13)];
	[field setCursorTo:CGPointMake(22, 13)];
	[layers moveCreatureId:10 To:CGPointMake(22, 13) showMenu:FALSE];
	
	
	[layers appendToCurrentActivityMethod:@selector(kailiAppear_2) Param1:nil Param2:nil Obj:self];	
}

-(void) kailiAppear_2
{
	for (int i=1; i<=8; i++) {
		[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50708 Id:(150+i)] autorelease] Position:CGPointMake(27, 14)];
	}
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50707 Id:159 DropItem:316] autorelease] Position:CGPointMake(27, 14)];
	
	[layers moveCreatureId:154 To:CGPointMake(25, 12) showMenu:FALSE];
	
	for (int i = 1; i <= 9; i++) {
		[self showTalkMessage:7 conversation:2 sequence:i];
	}
	
	// Add branch activities
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:152 To:CGPointMake(23, 14) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:153 To:CGPointMake(24, 13) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:159 To:CGPointMake(25, 14) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:155 To:CGPointMake(26, 13) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:156 To:CGPointMake(24, 15) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:157 To:CGPointMake(25, 16) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:158 To:CGPointMake(26, 15) showMenu:FALSE];
	
}

-(void) enemyClear
{
	if ([field getCreatureById:10] != nil) {
		// If KaiLi is saved
		for (int i = 1; i <= 8; i++) {
			[self showTalkMessage:7 conversation:4 sequence:i];
		}
	} else {
		// If KaiLi is dead or didn't appear
		for (int i = 1; i <= 4; i++) {
			[self showTalkMessage:7 conversation:5 sequence:i];
		}
	}
	
	[layers appendToCurrentActivityMethod:@selector(adjustFriends) Param1:nil Param2:nil Obj:self];
}

-(void) adjustFriends
{
	if ([field getCreatureById:10] != nil) {
		
		FDFriend *kaili = [[FDFriend alloc] initWithDefinition:10 Id:10];
		[[field getFriendList] addObject:kaili];
		[kaili release];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

-(void) showBossDyingMessage
{
	for (int i = 1; i <= 3; i++) {
		[self showTalkMessage:7 conversation:3 sequence:i];
	}
	
}

@end
