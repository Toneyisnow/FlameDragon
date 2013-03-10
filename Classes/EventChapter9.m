//
//  EventChapter9.m
//  FlameDragon
//
//  Created by sui toney on 13-1-20.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter9.h"


@implementation EventChapter9

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
	[self loadTurnEvent:TurnType_Friend Turn:7 Action:@selector(batch2)];
	
	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	[self loadDyingEvent:199 Action:@selector(laitingDead)];
	
	NSLog(@"Chapter9 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(10, 34)];
	[self settleFriend:2 At:CGPointMake(12, 34)];
	[self settleFriend:3 At:CGPointMake(14, 34)];
	[self settleFriend:4 At:CGPointMake(16, 34)];
	[self settleFriend:5 At:CGPointMake(15, 35)];
	[self settleFriend:6 At:CGPointMake(13, 35)];
	[self settleFriend:7 At:CGPointMake(11, 35)];
	[self settleFriend:8 At:CGPointMake(10, 36)];
	[self settleFriend:9 At:CGPointMake(12, 36)];
	[self settleFriend:10 At:CGPointMake(14, 36)];
	[self settleFriend:11 At:CGPointMake(16, 36)];
	
	// Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50908 Id:101] autorelease] Position:CGPointMake(14, 22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50908 Id:102] autorelease] Position:CGPointMake(12, 22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50908 Id:103 DropItem:116] autorelease] Position:CGPointMake(8, 19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50908 Id:104] autorelease] Position:CGPointMake(18, 19)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50903 Id:105] autorelease] Position:CGPointMake(12, 19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50903 Id:106] autorelease] Position:CGPointMake(14, 19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50903 Id:107] autorelease] Position:CGPointMake(10, 21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50903 Id:108] autorelease] Position:CGPointMake(16, 21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50903 Id:109] autorelease] Position:CGPointMake(12, 24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50903 Id:110] autorelease] Position:CGPointMake(14, 24)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50908 Id:111] autorelease] Position:CGPointMake(12, 22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50908 Id:112] autorelease] Position:CGPointMake(14, 22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50908 Id:113] autorelease] Position:CGPointMake( 8, 19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50908 Id:114] autorelease] Position:CGPointMake(18, 19)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50905 Id:115] autorelease] Position:CGPointMake(11, 23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50905 Id:116] autorelease] Position:CGPointMake(15, 23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50905 Id:117] autorelease] Position:CGPointMake( 7, 21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50905 Id:118] autorelease] Position:CGPointMake(19, 21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50906 Id:119] autorelease] Position:CGPointMake(11, 17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50906 Id:120] autorelease] Position:CGPointMake(15, 17)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50907 Id:121] autorelease] Position:CGPointMake(18, 23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50907 Id:122] autorelease] Position:CGPointMake( 8, 23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50907 Id:123] autorelease] Position:CGPointMake(12, 18)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50907 Id:124] autorelease] Position:CGPointMake(14, 18)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50901 Id:125] autorelease] Position:CGPointMake(12, 16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50901 Id:126] autorelease] Position:CGPointMake(14, 16)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50910 Id:199] autorelease] Position:CGPointMake(13, 16)];
	
	[self setAiOfId:103 withType:AIType_StandBy];
	[self setAiOfId:104 withType:AIType_StandBy];
	[self setAiOfId:113 withType:AIType_StandBy];
	[self setAiOfId:114 withType:AIType_StandBy];
	[self setAiOfId:119 withType:AIType_StandBy];
	[self setAiOfId:120 withType:AIType_StandBy];
	[self setAiOfId:125 withType:AIType_StandBy];
	[self setAiOfId:126 withType:AIType_StandBy];
	[self setAiOfId:199 withType:AIType_StandBy];
	
	[field setCursorTo:CGPointMake(16, 40)];
	
	for (int i = 1; i <= 7; i++) {
		[self showTalkMessage:9 conversation:1 sequence:i];
	}
}

-(void) batch2
{
	[self setAiOfId:103 withType:AIType_Aggressive];
	[self setAiOfId:104 withType:AIType_Aggressive];
	[self setAiOfId:113 withType:AIType_Aggressive];
	[self setAiOfId:114 withType:AIType_Aggressive];
	[self setAiOfId:119 withType:AIType_Aggressive];
	[self setAiOfId:120 withType:AIType_Aggressive];
	[self setAiOfId:125 withType:AIType_Aggressive];
	[self setAiOfId:126 withType:AIType_Aggressive];
	[self setAiOfId:199 withType:AIType_Aggressive];
}

-(void) laitingDead
{
	FDCreature *laiting = [field getCreatureById:199];
	FDFriend *friendLaiting = [[FDFriend alloc] initWithDefinition:13 Id:13];
	friendLaiting.data.hpCurrent = 1;
	[field addFriend:friendLaiting Position:[field getObjectPos:laiting]];
	[friendLaiting release];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50909 Id:201] autorelease] Position:CGPointMake( 2, 16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50909 Id:202] autorelease] Position:CGPointMake(24, 16)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50904 Id:203] autorelease] Position:CGPointMake( 1,  6)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50904 Id:204] autorelease] Position:CGPointMake(25,  6)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50904 Id:205] autorelease] Position:CGPointMake( 1, 16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50904 Id:206] autorelease] Position:CGPointMake(25, 16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50904 Id:207] autorelease] Position:CGPointMake( 1, 24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50904 Id:208] autorelease] Position:CGPointMake(25, 24)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50902 Id:209] autorelease] Position:CGPointMake(13,  2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50911 Id:210] autorelease] Position:CGPointMake(12,  1)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50911 Id:211] autorelease] Position:CGPointMake(14,  1)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50911 Id:212] autorelease] Position:CGPointMake(12,  3)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:50911 Id:213] autorelease] Position:CGPointMake(14,  3)];
    
    for (int i = 1; i <= 21; i++) {
		[self showTalkMessage:9 conversation:2 sequence:i];
	}
}

-(void) enemyClear
{
	[layers gameCleared];
    
    [field addNpc:[[[FDNpc alloc] initWithDefinition:50911 Id:301] autorelease] Position:CGPointMake(13, 1)];
	
	for (int i = 1; i <= 5; i++) {
		[self showTalkMessage:9 conversation:3 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(removeLaiting) Param1:nil Param2:nil Obj:self];
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

-(void) removeLaiting
{
	NSArray *friends = [field getFriendList];
	
	for(FDCreature *c in friends)
	{
		if ([c getIdentifier] == 13) {
			[[field getFriendList] removeObject:c];
			break;
		}
	}
}


@end
