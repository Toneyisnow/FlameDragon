//
//  EventChapter28.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter28.h"


@implementation EventChapter28

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
	[self loadTurnEvent:TurnType_Friend Turn:1 Action:@selector(round1)];
	[self loadTurnEvent:TurnType_Friend Turn:4 Action:@selector(round2)];
	[self loadTurnEvent:TurnType_Friend Turn:5 Action:@selector(round3)];
	[self loadTurnEvent:TurnType_Friend Turn:6 Action:@selector(round4)];
	
	[self loadDieEvent:2 Action:@selector(gameOver)];
	[self loadDyingEvent:2 Action:@selector(youniDead)];
    [self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	[self loadDyingEvent:114 Action:@selector(bossDyingMessage)];
	[self loadDyingEvent:201 Action:@selector(bossDyingMessage)];
	[self loadDyingEvent:202 Action:@selector(bossDyingMessage)];
	[self loadDieEvent:201 Action:@selector(bossDeadCheck)];
	[self loadDieEvent:202 Action:@selector(bossDeadCheck)];

	NSLog(@"Chapter28 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(33,22)];
	[self settleFriend:2 At:CGPointMake(34,22)];
	[self settleFriend:3 At:CGPointMake(38,22)];
	[self settleFriend:4 At:CGPointMake(39,22)];
	[self settleFriend:5 At:CGPointMake(39,21)];
	[self settleFriend:6 At:CGPointMake(38,21)];
	[self settleFriend:7 At:CGPointMake(37,21)];
	[self settleFriend:8 At:CGPointMake(36,21)];
	[self settleFriend:9 At:CGPointMake(35,21)];
	[self settleFriend:10 At:CGPointMake(34,21)];
	[self settleFriend:11 At:CGPointMake(33,21)];
	[self settleFriend:12 At:CGPointMake(33,20)];
	[self settleFriend:13 At:CGPointMake(34,20)];
	[self settleFriend:14 At:CGPointMake(35,20)];
	[self settleFriend:15 At:CGPointMake(36,20)];
	[self settleFriend:16 At:CGPointMake(37,20)];
	[self settleFriend:17 At:CGPointMake(38,20)];
	[self settleFriend:18 At:CGPointMake(39,20)];
	[self settleFriend:19 At:CGPointMake(39,19)];
	[self settleFriend:20 At:CGPointMake(33,19)];
	
	// Add Enemies
	
	
	// Round 2
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52805 Id:101] autorelease] Position:CGPointMake(13,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52805 Id:102] autorelease] Position:CGPointMake(13,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52803 Id:103] autorelease] Position:CGPointMake(14,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52803 Id:104] autorelease] Position:CGPointMake(14,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52803 Id:105] autorelease] Position:CGPointMake(14,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52803 Id:106] autorelease] Position:CGPointMake(14,22)];

	// Round 3
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52801 Id:107] autorelease] Position:CGPointMake(5,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52801 Id:108] autorelease] Position:CGPointMake(5,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52803 Id:109] autorelease] Position:CGPointMake(5,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52803 Id:110] autorelease] Position:CGPointMake(5,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52806 Id:111] autorelease] Position:CGPointMake(3,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52806 Id:112] autorelease] Position:CGPointMake(3,21)];

	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52802 Id:201] autorelease] Position:CGPointMake(4,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52802 Id:202] autorelease] Position:CGPointMake(4,21)];
	
	
	for (int i = 109; i <= 112; i++) {
		[self setAiOfId:i withType:AIType_StandBy];
	}
	[self setAiOfId:201 withType:AIType_StandBy];
	[self setAiOfId:202 withType:AIType_StandBy];
	
	// Talk
	for (int i = 1; i <= 08; i++) {
		[self showTalkMessage:28 conversation:1 sequence:i];
	}
}

-(void) round1
{
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52802 Id:114] autorelease] Position:CGPointMake(23,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52803 Id:115] autorelease] Position:CGPointMake(24,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52803 Id:116] autorelease] Position:CGPointMake(24,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52803 Id:117] autorelease] Position:CGPointMake(24,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52805 Id:118] autorelease] Position:CGPointMake(23,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52805 Id:119] autorelease] Position:CGPointMake(23,23)];
	[self showTalkMessage:28 conversation:1 sequence:9];
	[self showTalkMessage:28 conversation:1 sequence:10];
}

-(void) round2
{
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52803 Id:120] autorelease] Position:CGPointMake(20,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52803 Id:121] autorelease] Position:CGPointMake(21,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52803 Id:122] autorelease] Position:CGPointMake(22,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52804 Id:123] autorelease] Position:CGPointMake(22,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52801 Id:124] autorelease] Position:CGPointMake(21,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52804 Id:125] autorelease] Position:CGPointMake(20,11)];
	[self showTalkMessage:28 conversation:1 sequence:11];
	[self showTalkMessage:28 conversation:1 sequence:12];
}

-(void) round3
{
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52803 Id:121] autorelease] Position:CGPointMake(14,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52803 Id:122] autorelease] Position:CGPointMake(15,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52803 Id:123] autorelease] Position:CGPointMake(16,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52805 Id:129] autorelease] Position:CGPointMake(14,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52805 Id:120] autorelease] Position:CGPointMake(15,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52805 Id:131] autorelease] Position:CGPointMake(16,11)];
	[self showTalkMessage:28 conversation:1 sequence:13];
	[self showTalkMessage:28 conversation:1 sequence:14];
}

-(void) round4
{
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52803 Id:124] autorelease] Position:CGPointMake(8,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52803 Id:125] autorelease] Position:CGPointMake(9,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52803 Id:126] autorelease] Position:CGPointMake(10,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52804 Id:132] autorelease] Position:CGPointMake(8,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52801 Id:102] autorelease] Position:CGPointMake(9, 11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52804 Id:133] autorelease] Position:CGPointMake(10,11)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52805 Id:136] autorelease] Position:CGPointMake(2,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52805 Id:137] autorelease] Position:CGPointMake(3,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52805 Id:138] autorelease] Position:CGPointMake(4,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52804 Id:139] autorelease] Position:CGPointMake(2,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52804 Id:130] autorelease] Position:CGPointMake(4,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52801 Id:103] autorelease] Position:CGPointMake(3, 11)];
	[self showTalkMessage:28 conversation:1 sequence:15];
	[self showTalkMessage:28 conversation:1 sequence:16];

}
-(void) round2
{
	for (int i = 117; i <= 133; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
}
-(void) round3
{
	for (int i = 134; i <= 142; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
	[self setAiOfId:201 withType:AIType_Aggressive];
	[self setAiOfId:202 withType:AIType_Aggressive];
}

-(void) bossDyingMessage
{
	[self showTalkMessage:28 conversation:3 sequence:1];
}

-(void) bossDeadCheck
{
	if ([field getCreatureById:201] != nil || [field getCreatureById:202] != nil) {
                return;
        }
 	
 	[self enemyClear];
}

-(void) enemyClear
{
	for (int i = 1; i <= 5; i++) {
		[self showTalkMessage:28 conversation:5 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

-(void) youniDead
{
    [self showTalkMessage:28 conversation:6 sequence:1];
}

@end
