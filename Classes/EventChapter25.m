//
//  EventChapter25.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter25.h"
#import "FDDurationActivity.h"

@implementation EventChapter25

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
    [self loadTurnEvent:TurnType_Friend Turn:5 Action:@selector(batch2)];
    [self loadTurnEvent:TurnType_Friend Turn:6 Action:@selector(reinforcement)];
    [self loadTurnEvent:TurnType_Friend Turn:10 Action:@selector(batch3)];
    
	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadDieEvent:30 Action:@selector(gameOver)];
	[self loadDieEvent:199 Action:@selector(bossDead)];
	
    [self loadPositionEvent:1 AtPosition:CGPointMake(11,2) Action:@selector(onSword)];
	
    [self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	NSLog(@"Chapter25 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(8,44)];
	[self settleFriend:2 At:CGPointMake(10,44)];
	[self settleFriend:3 At:CGPointMake(12,45)];
	[self settleFriend:4 At:CGPointMake(14,44)];
	[self settleFriend:5 At:CGPointMake(17,44)];
	[self settleFriend:6 At:CGPointMake(18,46)];
	[self settleFriend:7 At:CGPointMake(16,46)];
	[self settleFriend:8 At:CGPointMake(14,46)];
	[self settleFriend:9 At:CGPointMake(15,48)];
	[self settleFriend:10 At:CGPointMake(17,48)];
	[self settleFriend:11 At:CGPointMake(12,48)];
	[self settleFriend:12 At:CGPointMake(10,46)];
	[self settleFriend:13 At:CGPointMake(9,48)];
	[self settleFriend:14 At:CGPointMake(7,49)];
	[self settleFriend:15 At:CGPointMake(7,46)];
	[self settleFriend:16 At:CGPointMake(20,48)];
	
	// Add Enemies Batch 1
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52502 Id:101] autorelease] Position:CGPointMake(9,35)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52502 Id:102] autorelease] Position:CGPointMake(18,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52504 Id:103] autorelease] Position:CGPointMake(22,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52504 Id:104] autorelease] Position:CGPointMake(23,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52504 Id:105] autorelease] Position:CGPointMake(25,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52504 Id:106] autorelease] Position:CGPointMake(2,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52504 Id:107] autorelease] Position:CGPointMake(3,27)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52504 Id:108] autorelease] Position:CGPointMake(1,27)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52505 Id:109] autorelease] Position:CGPointMake(24,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52505 Id:110] autorelease] Position:CGPointMake(2,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52506 Id:111 DropItem:104] autorelease] Position:CGPointMake(9,37)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52506 Id:112] autorelease] Position:CGPointMake(8,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52506 Id:113] autorelease] Position:CGPointMake(10,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52506 Id:114 DropItem:903] autorelease] Position:CGPointMake(17,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52506 Id:115] autorelease] Position:CGPointMake(19,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52506 Id:116] autorelease] Position:CGPointMake(19,21)];
	
    // Add enemy Batch 2
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52502 Id:117] autorelease] Position:CGPointMake(10,17)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52502 Id:118] autorelease] Position:CGPointMake(7,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52503 Id:119] autorelease] Position:CGPointMake(24,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52503 Id:120] autorelease] Position:CGPointMake(23,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52503 Id:121 DropItem:104] autorelease] Position:CGPointMake(1,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52503 Id:122] autorelease] Position:CGPointMake(2,7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52504 Id:123] autorelease] Position:CGPointMake(11,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52506 Id:124] autorelease] Position:CGPointMake(7,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52506 Id:125] autorelease] Position:CGPointMake(6,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52506 Id:126] autorelease] Position:CGPointMake(8,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52506 Id:127 DropItem:104] autorelease] Position:CGPointMake(3,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52506 Id:128] autorelease] Position:CGPointMake(1,6)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52506 Id:129] autorelease] Position:CGPointMake(24,7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52506 Id:130] autorelease] Position:CGPointMake(25,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52506 Id:131] autorelease] Position:CGPointMake(7,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52506 Id:132] autorelease] Position:CGPointMake(6,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52506 Id:133 DropItem:104] autorelease] Position:CGPointMake(8,10)];
	
    // Add enemy batch 3
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52507 Id:134] autorelease] Position:CGPointMake(13,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52507 Id:135] autorelease] Position:CGPointMake(12,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52507 Id:136 DropItem:804] autorelease] Position:CGPointMake(10,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52507 Id:137] autorelease] Position:CGPointMake(9,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52501 Id:199] autorelease] Position:CGPointMake(11,8)];
	
    for (int i = 117; i <= 137; i++) {
        [self setAiOfId:i withType:AIType_StandBy];
    }
    [self setAiOfId:199 withType:AIType_StandBy];
    
    // Add Npc
    [field addFriend:[[[FDFriend alloc] initWithDefinition:30 Id:30] autorelease] Position:CGPointMake(12,28)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52508 Id:201] autorelease] Position:CGPointMake(13,29)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52508 Id:201] autorelease] Position:CGPointMake(11,29)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52508 Id:201] autorelease] Position:CGPointMake(10,28)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52508 Id:201] autorelease] Position:CGPointMake(14,28)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52508 Id:201] autorelease] Position:CGPointMake(11,27)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52508 Id:201] autorelease] Position:CGPointMake(13,27)];
    
	// Talk
	for (int i = 1; i <= 23; i++) {
		[self showTalkMessage:25 conversation:1 sequence:i];
	}
}

-(void) reinforcement {
    
    [field addNpc:[[[FDNpc alloc] initWithDefinition:52508 Id:211] autorelease] Position:CGPointMake(13,50)];
    [field addNpc:[[[FDNpc alloc] initWithDefinition:52508 Id:212] autorelease] Position:CGPointMake(12,51)];
    [field addNpc:[[[FDNpc alloc] initWithDefinition:52508 Id:213] autorelease] Position:CGPointMake(14,51)];
    [field addNpc:[[[FDNpc alloc] initWithDefinition:52508 Id:214] autorelease] Position:CGPointMake(11,52)];
    [field addNpc:[[[FDNpc alloc] initWithDefinition:52508 Id:215] autorelease] Position:CGPointMake(13,52)];
    [field addNpc:[[[FDNpc alloc] initWithDefinition:52508 Id:216] autorelease] Position:CGPointMake(15,52)];
    [field addNpc:[[[FDNpc alloc] initWithDefinition:52508 Id:217] autorelease] Position:CGPointMake(12,53)];
    [field addNpc:[[[FDNpc alloc] initWithDefinition:52508 Id:218] autorelease] Position:CGPointMake(14,53)];
    
    // Talk
	for (int i = 1; i <= 2; i++) {
		[self showTalkMessage:25 conversation:2 sequence:i];
	}

}

-(void) batch2
{
    for (int i = 117; i <= 133; i++) {
        [self setAiOfId:i withType:AIType_Aggressive];
    }
}

-(void) batch3
{
    for (int i = 134; i <= 137; i++) {
        [self setAiOfId:i withType:AIType_Aggressive];
    }
    [self setAiOfId:199 withType:AIType_Aggressive];
}

-(void) bossDead
{
    [self showTalkMessage:25 conversation:3 sequence:1];
}

-(void) onSword
{
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52509 Id:301 DropItem:297] autorelease] Position:CGPointMake(11,1)];
}

-(void) enemyClear
{
    [layers gameCleared];
    
    [field addFriend:[[[FDFriend alloc] initWithDefinition:31 Id:31] autorelease] Position:CGPointMake(1,34)];
    
	for (int i = 1; i <= 18; i++) {
		[self showTalkMessage:25 conversation:4 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end
