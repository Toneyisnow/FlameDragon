//
//  EventChapter21.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter21.h"


@implementation EventChapter21

-(void) loadEvents
{
    [self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
	[self loadTurnEvent:TurnType_Friend Turn:2 Action:@selector(round2)];
	[self loadTurnEvent:TurnType_Friend Turn:4 Action:@selector(round4)];
	[self loadTurnEvent:TurnType_Friend Turn:6 Action:@selector(round6)];
	[self loadTurnEvent:TurnType_Friend Turn:8 Action:@selector(round8)];
	
	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadDieEvent:25 Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	[self loadDyingEvent:199 Action:@selector(bossDyingMessage)];
	
	NSLog(@"Chapter21 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(38,18)];
	[self settleFriend:2 At:CGPointMake(4,19)];
	[self settleFriend:3 At:CGPointMake(39,19)];
	[self settleFriend:4 At:CGPointMake(40,20)];
	[self settleFriend:5 At:CGPointMake(40,18)];
	[self settleFriend:6 At:CGPointMake(40,16)];
	[self settleFriend:7 At:CGPointMake(41,17)];
	[self settleFriend:8 At:CGPointMake(41,19)];
	[self settleFriend:9 At:CGPointMake(39,17)];
	[self settleFriend:10 At:CGPointMake(3,18)];
	[self settleFriend:11 At:CGPointMake(3,20)];
	[self settleFriend:12 At:CGPointMake(2,17)];
	[self settleFriend:13 At:CGPointMake(2,19)];
	[self settleFriend:14 At:CGPointMake(2,21)];
	[self settleFriend:15 At:CGPointMake(1,18)];
	[self settleFriend:16 At:CGPointMake(1,20)];
	
	// Add Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52102 Id:101] autorelease] Position:CGPointMake(20,27)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52102 Id:102] autorelease] Position:CGPointMake(22,27)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52102 Id:103] autorelease] Position:CGPointMake(14,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52102 Id:104] autorelease] Position:CGPointMake(28,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52102 Id:105] autorelease] Position:CGPointMake(8,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52102 Id:106] autorelease] Position:CGPointMake(34,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52103 Id:107] autorelease] Position:CGPointMake(20,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52103 Id:108] autorelease] Position:CGPointMake(22,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52103 Id:109] autorelease] Position:CGPointMake(20,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52103 Id:110] autorelease] Position:CGPointMake(22,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52105 Id:111] autorelease] Position:CGPointMake(15,35)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52105 Id:112] autorelease] Position:CGPointMake(16,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52105 Id:113] autorelease] Position:CGPointMake(17,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52105 Id:114] autorelease] Position:CGPointMake(18,35)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52105 Id:115] autorelease] Position:CGPointMake(24,35)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52105 Id:116] autorelease] Position:CGPointMake(25,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52105 Id:117] autorelease] Position:CGPointMake(26,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52105 Id:118] autorelease] Position:CGPointMake(27,35)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52105 Id:119] autorelease] Position:CGPointMake(12,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52105 Id:120] autorelease] Position:CGPointMake(13,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52105 Id:121] autorelease] Position:CGPointMake(14,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52105 Id:122] autorelease] Position:CGPointMake(13,29)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52105 Id:123] autorelease] Position:CGPointMake(28,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52105 Id:124] autorelease] Position:CGPointMake(30,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52105 Id:125] autorelease] Position:CGPointMake(29,29)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52105 Id:126] autorelease] Position:CGPointMake(29,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52106 Id:127] autorelease] Position:CGPointMake(19,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52106 Id:128] autorelease] Position:CGPointMake(19,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52106 Id:129] autorelease] Position:CGPointMake(23,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52106 Id:130] autorelease] Position:CGPointMake(23,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52107 Id:131] autorelease] Position:CGPointMake(19,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52107 Id:132] autorelease] Position:CGPointMake(21,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52107 Id:133] autorelease] Position:CGPointMake(23,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52107 Id:134] autorelease] Position:CGPointMake(19,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52107 Id:135] autorelease] Position:CGPointMake(21,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52107 Id:136] autorelease] Position:CGPointMake(23,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52108 Id:137] autorelease] Position:CGPointMake(19,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52108 Id:138] autorelease] Position:CGPointMake(21,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52108 Id:139] autorelease] Position:CGPointMake(23,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52108 Id:140] autorelease] Position:CGPointMake(19,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52108 Id:141] autorelease] Position:CGPointMake(21,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52108 Id:142] autorelease] Position:CGPointMake(23,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52109 Id:143] autorelease] Position:CGPointMake(20,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52109 Id:144] autorelease] Position:CGPointMake(22,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52109 Id:145] autorelease] Position:CGPointMake(11,29)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52109 Id:146] autorelease] Position:CGPointMake(12,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52109 Id:147] autorelease] Position:CGPointMake(30,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52109 Id:148] autorelease] Position:CGPointMake(31,29)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52101 Id:199] autorelease] Position:CGPointMake(21,33)];
	
	// Add NPC
	[field addFriend:[[[FDFriend alloc] initWithDefinition:25 Id:25] autorelease] Position:CGPointMake(20,13)];
	[field addFriend:[[[FDFriend alloc] initWithDefinition:26 Id:26] autorelease] Position:CGPointMake(22,13)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52110 Id:201] autorelease] Position:CGPointMake(19,13)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52110 Id:202] autorelease] Position:CGPointMake(20,12)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52110 Id:203] autorelease] Position:CGPointMake(20,14)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52110 Id:204] autorelease] Position:CGPointMake(21,12)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52110 Id:205] autorelease] Position:CGPointMake(21,14)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52110 Id:206] autorelease] Position:CGPointMake(22,12)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52110 Id:207] autorelease] Position:CGPointMake(22,14)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52110 Id:208] autorelease] Position:CGPointMake(23,13)];
	
	// Talk
	for (int i = 1; i <= 17; i++) {
		[self showTalkMessage:21 conversation:1 sequence:i];
	}
}

-(void) round2
{
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52104 Id:201] autorelease] Position:CGPointMake(2,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52104 Id:202] autorelease] Position:CGPointMake(40,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52104 Id:203] autorelease] Position:CGPointMake(2,39)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52104 Id:204] autorelease] Position:CGPointMake(40,39)];
	
}

-(void) round4
{
    [self setAiOfId:25 withType:AIType_Aggressive];
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52104 Id:205] autorelease] Position:CGPointMake(2,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52104 Id:206] autorelease] Position:CGPointMake(40,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52104 Id:207] autorelease] Position:CGPointMake(2,39)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52104 Id:208] autorelease] Position:CGPointMake(40,39)];
	
}

-(void) round6
{
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52104 Id:209] autorelease] Position:CGPointMake(2,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52104 Id:210] autorelease] Position:CGPointMake(40,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52104 Id:211] autorelease] Position:CGPointMake(2,39)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52104 Id:212] autorelease] Position:CGPointMake(40,39)];
}

-(void) round8
{
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52104 Id:213] autorelease] Position:CGPointMake(2,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52104 Id:214] autorelease] Position:CGPointMake(40,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52104 Id:215] autorelease] Position:CGPointMake(2,39)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52104 Id:216] autorelease] Position:CGPointMake(40,39)];
}

-(void) bossDyingMessage
{
	for (int i = 1; i <= 4; i++) {
		[self showTalkMessage:21 conversation:3 sequence:i];
	}
}

-(void) enemyClear
{
	for (int i = 5; i <= 14; i++) {
		[self showTalkMessage:21 conversation:3 sequence:i];
	}
	
    if ([self teamHasItem:117]
        && [self teamHasItem:118]
        && [self teamHasItem:119]
        && [self teamHasItem:120]
        && [self teamHasItem:121]
        && [self teamHasItem:805]
        )
    {
        [self teamConsumeItem:117];
        [self teamConsumeItem:118];
        [self teamConsumeItem:119];
        [self teamConsumeItem:120];
        [self teamConsumeItem:121];
        [self teamConsumeItem:805];
        
        [self addItemToTeam:814];
        
        for (int i = 15; i <= 26; i++) {
            [self showTalkMessage:21 conversation:3 sequence:i];
        }
    }
    
    for (int i = 27; i <= 29; i++) {
        [self showTalkMessage:21 conversation:3 sequence:i];
    }
    
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end
