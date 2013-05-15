//
//  EventChapter12.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter12.h"
#import "FDEmptyActivity.h"

@implementation EventChapter12

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
	[self loadTurnEvent:TurnType_Friend Turn:1 Action:@selector(reinforcement)];

	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadDieEvent:15 Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	[self loadDyingEvent:199 Action:@selector(bossDyingMessage)];
	
	CCLOG(@"Chapter12 events loaded.");
}

-(void) initialBattle
{
	CCLOG(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(16, 45)];
	[self settleFriend:2 At:CGPointMake(16, 49)];
	[self settleFriend:3 At:CGPointMake(18, 49)];
	[self settleFriend:4 At:CGPointMake(17, 48)];
	[self settleFriend:5 At:CGPointMake(19, 48)];
	[self settleFriend:6 At:CGPointMake(15, 48)];
	[self settleFriend:7 At:CGPointMake(20, 47)];
	[self settleFriend:8 At:CGPointMake(18, 47)];
	[self settleFriend:9 At:CGPointMake(16, 47)];
	[self settleFriend:10 At:CGPointMake(20, 45)];
	[self settleFriend:11 At:CGPointMake(21, 46)];
	[self settleFriend:12 At:CGPointMake(19, 46)];
	[self settleFriend:13 At:CGPointMake(17, 46)];
	[self settleFriend:14 At:CGPointMake(18, 45)];
	
	// Add Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51202 Id:101] autorelease] Position:CGPointMake(10,1 )];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51202 Id:102 DropItem:103] autorelease] Position:CGPointMake(12,1 )];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51202 Id:103] autorelease] Position:CGPointMake(9 ,2 )];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51202 Id:104] autorelease] Position:CGPointMake(11,2 )];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51202 Id:105] autorelease] Position:CGPointMake(13,2 )];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51202 Id:106 DropItem:103] autorelease] Position:CGPointMake(10,3 )];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51202 Id:107] autorelease] Position:CGPointMake(12,3 )];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51202 Id:108] autorelease] Position:CGPointMake(9 ,4 )];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51202 Id:109] autorelease] Position:CGPointMake(13,4 )];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51201 Id:199 DropItem:217] autorelease] Position:CGPointMake(11,4 )];
	
	// Add Npc
	FDNpc *npc = [[[FDNpc alloc] initWithDefinition:15 Id:15] autorelease];
	[field addNpc:npc Position:CGPointMake(11, 8)];
	[self setAiOfId:15 EscapeTo:CGPointMake(16, 45)];
	
	// Talk
	for (int i = 1; i <= 11; i++) {
		[self showTalkMessage:12 conversation:1 sequence:i];
	}
}

-(void) reinforcement
{
	FDEnemy *enemy1 = [[[FDEnemy alloc] initWithDefinition:51202 Id:201] autorelease];
	[field addEnemy:enemy1 Position:CGPointMake(26,39)];
	
	FDEnemy *enemy2 = [[[FDEnemy alloc] initWithDefinition:51202 Id:202] autorelease];
	[field addEnemy:enemy2 Position:CGPointMake(26,39)];
	
	FDEnemy *enemy3 = [[[FDEnemy alloc] initWithDefinition:51203 Id:203] autorelease];
	[field addEnemy:enemy3 Position:CGPointMake(26,39)];
	
	FDEnemy *enemy4 = [[[FDEnemy alloc] initWithDefinition:51204 Id:204 DropItem:105] autorelease];
	[field addEnemy:enemy4 Position:CGPointMake(26,39)];
	
    [layers moveCreatureId:201 To:CGPointMake(25, 39) showMenu:FALSE];
	
	[layers appendToCurrentActivityMethod:@selector(reinforcement_2) Param1:nil Param2:nil Obj:self];
	// Add branch activities
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreatureId:202 To:CGPointMake(26, 40) showMenu:FALSE];
    
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy3 To:CGPointMake(27, 39) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy4 To:CGPointMake(24, 40) showMenu:FALSE];
}

-(void) reinforcement_2
{
	FDEnemy *enemy1 = [[[FDEnemy alloc] initWithDefinition:51202 Id:205] autorelease];
	[field addEnemy:enemy1 Position:CGPointMake(2,31)];
	
	FDEnemy *enemy2 = [[[FDEnemy alloc] initWithDefinition:51202 Id:206 DropItem:901] autorelease];
	[field addEnemy:enemy2 Position:CGPointMake(2,31)];
	
	FDEnemy *enemy3 = [[[FDEnemy alloc] initWithDefinition:51203 Id:207] autorelease];
	[field addEnemy:enemy3 Position:CGPointMake(2,31)];
	
	FDEnemy *enemy4 = [[[FDEnemy alloc] initWithDefinition:51204 Id:208] autorelease];
	[field addEnemy:enemy4 Position:CGPointMake(2,31)];
	
	[layers moveCreature:enemy1 To:CGPointMake(3,31) showMenu:FALSE];
	
	[layers appendToCurrentActivityMethod:@selector(reinforcement_3) Param1:nil Param2:nil Obj:self];
	
	// Add branch activities
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy2 To:CGPointMake(2, 32) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy3 To:CGPointMake(1, 31) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy4 To:CGPointMake(4, 32) showMenu:FALSE];
}

-(void) reinforcement_3
{
	FDEnemy *enemy1 = [[[FDEnemy alloc] initWithDefinition:51202 Id:201] autorelease];
	[field addEnemy:enemy1 Position:CGPointMake(21,10)];
	
	FDEnemy *enemy2 = [[[FDEnemy alloc] initWithDefinition:51202 Id:202] autorelease];
	[field addEnemy:enemy2 Position:CGPointMake(21,10)];
	
	FDEnemy *enemy3 = [[[FDEnemy alloc] initWithDefinition:51203 Id:203 DropItem:901] autorelease];
	[field addEnemy:enemy3 Position:CGPointMake(21,10)];
	
	FDEnemy *enemy4 = [[[FDEnemy alloc] initWithDefinition:51204 Id:204] autorelease];
	[field addEnemy:enemy4 Position:CGPointMake(21,10)];
	
	
	[layers moveCreature:enemy1 To:CGPointMake(20, 11) showMenu:FALSE];
	
	// Add branch activities
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy2 To:CGPointMake(21, 12) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy3 To:CGPointMake(22, 11) showMenu:FALSE];
	
	[layers appendNewActivity:[[[FDEmptyActivity alloc] init] autorelease]];
	[layers moveCreature:enemy4 To:CGPointMake(19, 12) showMenu:FALSE];
}

-(void) bossDyingMessage
{
	[self showTalkMessage:12 conversation:2 sequence:1];
	[layers appendToCurrentActivityMethod:@selector(reinforcement) Param1:nil Param2:nil Obj:self];
}

-(void) enemyClear
{
	[layers gameCleared];
    
    FDFriend *mia = [[FDFriend alloc] initWithDefinition:15 Id:15];
	[[field getFriendList] addObject:mia];
	
	for (int i = 2; i <= 10; i++) {
		[self showTalkMessage:12 conversation:2 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end
