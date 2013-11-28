//
//  EventChapter27.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter27.h"


@implementation EventChapter27

-(void) loadEvents
{
  [self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
	[self loadTurnEvent:TurnType_Friend Turn:3 Action:@selector(round2)];
	[self loadTurnEvent:TurnType_Friend Turn:10 Action:@selector(round3)];
	[self loadTurnEvent:TurnType_Friend Turn:13 Action:@selector(round4)];
	
	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadDieEvent:2 Action:@selector(gameOver)];
	[self loadDyingEvent:2 Action:@selector(youniDead)];
        // [self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	[self loadDyingEvent:201 Action:@selector(bossDyingMessage)];
	[self loadDyingEvent:202 Action:@selector(bossDyingMessage)];
	[self loadDyingEvent:203 Action:@selector(bossDyingMessage)];
	
	[self loadDieEvent:201 Action:@selector(bossDeadCheck)];
	[self loadDieEvent:202 Action:@selector(bossDeadCheck)];
	[self loadDieEvent:203 Action:@selector(bossDeadCheck)];

	NSLog(@"Chapter27 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(16,54)];
	[self settleFriend:2 At:CGPointMake(14,55)];
	[self settleFriend:3 At:CGPointMake(15,55)];
	[self settleFriend:4 At:CGPointMake(16,55)];
	[self settleFriend:5 At:CGPointMake(17, 55)];
	[self settleFriend:6 At:CGPointMake(18, 55)];
	[self settleFriend:7 At:CGPointMake(14, 56)];
	[self settleFriend:8 At:CGPointMake(15, 56)];
	[self settleFriend:9 At:CGPointMake(16, 56)];
	[self settleFriend:10 At:CGPointMake(17, 56)];
	[self settleFriend:11 At:CGPointMake(18, 56)];
	[self settleFriend:12 At:CGPointMake(14, 57)];
	[self settleFriend:13 At:CGPointMake(15, 57)];
	[self settleFriend:14 At:CGPointMake(16, 57)];
	[self settleFriend:15 At:CGPointMake(17, 57)];
	[self settleFriend:16 At:CGPointMake(18, 57)];
	
	// Add Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52701 Id:101] autorelease] Position:CGPointMake(15,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52701 Id:102] autorelease] Position:CGPointMake(17,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52701 Id:103] autorelease] Position:CGPointMake(13,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52701 Id:104] autorelease] Position:CGPointMake(19,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52701 Id:105] autorelease] Position:CGPointMake(3 ,36)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52701 Id:106] autorelease] Position:CGPointMake(29,35)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52701 Id:107] autorelease] Position:CGPointMake(9 ,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52701 Id:108] autorelease] Position:CGPointMake(23,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52701 Id:109] autorelease] Position:CGPointMake(15,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52701 Id:110] autorelease] Position:CGPointMake(17,19)];
	
	// Round 1
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:111] autorelease] Position:CGPointMake(15,47)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:112] autorelease] Position:CGPointMake(17,47)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:113] autorelease] Position:CGPointMake(15,48)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:114] autorelease] Position:CGPointMake(16,48)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:115] autorelease] Position:CGPointMake(17,48)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:116] autorelease] Position:CGPointMake(15,49)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:117] autorelease] Position:CGPointMake(17,49)];
	
	// Round 2
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:118] autorelease] Position:CGPointMake(15,38)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:119] autorelease] Position:CGPointMake(16,38)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:120] autorelease] Position:CGPointMake(17,38)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:121] autorelease] Position:CGPointMake(14,37)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:122] autorelease] Position:CGPointMake(18,38)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:123] autorelease] Position:CGPointMake(13,36)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:124] autorelease] Position:CGPointMake(19,36)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:125] autorelease] Position:CGPointMake(10,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:126] autorelease] Position:CGPointMake(11,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:127] autorelease] Position:CGPointMake(22,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:128] autorelease] Position:CGPointMake(21,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52705 Id:129] autorelease] Position:CGPointMake(14,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52705 Id:130] autorelease] Position:CGPointMake(15,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52705 Id:131] autorelease] Position:CGPointMake(18,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52705 Id:132] autorelease] Position:CGPointMake(17,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52705 Id:133] autorelease] Position:CGPointMake(9,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52705 Id:134] autorelease] Position:CGPointMake(10,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52705 Id:135] autorelease] Position:CGPointMake(22,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52705 Id:136] autorelease] Position:CGPointMake(23,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:137] autorelease] Position:CGPointMake(15,36)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:138] autorelease] Position:CGPointMake(17,36)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:139] autorelease] Position:CGPointMake(14,35)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:140] autorelease] Position:CGPointMake(18,35)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:141] autorelease] Position:CGPointMake(8,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:142] autorelease] Position:CGPointMake(9,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:143] autorelease] Position:CGPointMake(24,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:144] autorelease] Position:CGPointMake(23,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52706 Id:145] autorelease] Position:CGPointMake(12,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52706 Id:146] autorelease] Position:CGPointMake(20,30)];
	
	// Round 3
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:147] autorelease] Position:CGPointMake(12,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:148] autorelease] Position:CGPointMake(13,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:149] autorelease] Position:CGPointMake(14,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:150] autorelease] Position:CGPointMake(18,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:151] autorelease] Position:CGPointMake(19,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:152] autorelease] Position:CGPointMake(20,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52705 Id:153] autorelease] Position:CGPointMake(12,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52705 Id:154] autorelease] Position:CGPointMake(13,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52705 Id:155] autorelease] Position:CGPointMake(19,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52705 Id:156] autorelease] Position:CGPointMake(20,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:157] autorelease] Position:CGPointMake(14,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:158] autorelease] Position:CGPointMake(15,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:159] autorelease] Position:CGPointMake(16,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:160] autorelease] Position:CGPointMake(17,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52704 Id:161] autorelease] Position:CGPointMake(18,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52706 Id:162] autorelease] Position:CGPointMake(14,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52706 Id:163] autorelease] Position:CGPointMake(18,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52702 Id:201] autorelease] Position:CGPointMake(16,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52702 Id:202] autorelease] Position:CGPointMake(15,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52702 Id:203] autorelease] Position:CGPointMake(17,23)];
	
	// Round 4
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:166] autorelease] Position:CGPointMake(5,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:167] autorelease] Position:CGPointMake(6,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:168] autorelease] Position:CGPointMake(7,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:169] autorelease] Position:CGPointMake(5,15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:170] autorelease] Position:CGPointMake(7,15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:171] autorelease] Position:CGPointMake(25,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:172] autorelease] Position:CGPointMake(26,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:173] autorelease] Position:CGPointMake(27,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:174] autorelease] Position:CGPointMake(25,15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52703 Id:175] autorelease] Position:CGPointMake(27,15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52705 Id:176] autorelease] Position:CGPointMake(5,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52705 Id:177] autorelease] Position:CGPointMake(7,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52705 Id:178] autorelease] Position:CGPointMake(25,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52705 Id:179] autorelease] Position:CGPointMake(27,14)];
	
	
	for (int i = 118; i <= 179; i++) {
		[self setAiOfId:i withType:AIType_StandBy];
	}
	[self setAiOfId:201 withType:AIType_StandBy];
	[self setAiOfId:202 withType:AIType_StandBy];
	[self setAiOfId:203 withType:AIType_StandBy];
	
	// Talk
	for (int i = 1; i <= 19; i++) {
		[self showTalkMessage:27 conversation:1 sequence:i];
	}
}

-(void) round2
{
	for (int i = 118; i <= 146; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
}
-(void) round3
{
	for (int i = 147; i <= 163; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
	[self setAiOfId:201 withType:AIType_Aggressive];
	[self setAiOfId:202 withType:AIType_Aggressive];
	[self setAiOfId:203 withType:AIType_Aggressive];
}
-(void) round4
{
	for (int i = 166; i <= 179; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
}

-(void) bossDyingMessage
{
	int bossLeft = 0;
	
	if ([field getCreatureById:201] != nil) {
		bossLeft ++;
	}
	if ([field getCreatureById:202] != nil) {
		bossLeft ++;
	}
	if ([field getCreatureById:203] != nil) {
		bossLeft ++;
	}
	
	if (bossLeft > 1) {
		[self showTalkMessage:27 conversation:2 sequence:1];
	} else {
		[self showTalkMessage:27 conversation:3 sequence:1];
	}
}

-(void) bossDeadCheck
{
	int bossLeft = 0;
	
	if ([field getCreatureById:201] == nil && [field getCreatureById:202] == nil && [field getCreatureById:203] == nil) {
		[self enemyClear];
	}
}

-(void) youniDead
{
    [self showTalkMessage:27 conversation:7 sequence:1];
}

-(void) enemyClear
{
	if ([self teamHasItem:814]) {
		for (int i = 1; i <= 23; i++) {
			[self showTalkMessage:27 conversation:4 sequence:i];
		}
	
	} else {
		for (int i = 1; i <= 15; i++) {
			[self showTalkMessage:27 conversation:5 sequence:i];
		}
	}
    
    [layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end
