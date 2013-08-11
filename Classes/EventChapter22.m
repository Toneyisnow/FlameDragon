//
//  EventChapter22.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter22.h"


@implementation EventChapter22

-(void) loadEvents
{
  [self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
	[self loadTurnEvent:TurnType_Friend Turn:3 Action:@selector(reinforcement)];
	[self loadTurnEvent:TurnType_Friend Turn:5 Action:@selector(salaAppear)];
	[self loadTurnEvent:TurnType_Friend Turn:7 Action:@selector(reinforcement2)];
	
	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadDieEvent:25 Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	[self loadDyingEvent:199 Action:@selector(bossDyingMessage)];
	
	NSLog(@"Chapter22 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(23,28)];
	[self settleFriend:2 At:CGPointMake(22,29)];
	[self settleFriend:3 At:CGPointMake(24,29)];
	[self settleFriend:4 At:CGPointMake(23,29)];
	[self settleFriend:5 At:CGPointMake(22,30)];
	[self settleFriend:6 At:CGPointMake(24,30)];
	[self settleFriend:7 At:CGPointMake(23,30)];
	[self settleFriend:8 At:CGPointMake(22,31)];
	[self settleFriend:9 At:CGPointMake(24,31)];
	[self settleFriend:10 At:CGPointMake(23,31)];
	[self settleFriend:11 At:CGPointMake(22,32)];
	[self settleFriend:12 At:CGPointMake(24,32)];
	[self settleFriend:13 At:CGPointMake(23,32)];
	[self settleFriend:14 At:CGPointMake(21,31)];
	[self settleFriend:15 At:CGPointMake(25,31)];
	[self settleFriend:16 At:CGPointMake(23,33)];
	
	// Add Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52202 Id:101] autorelease] Position:CGPointMake(12,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52202 Id:102 DropItem:106] autorelease] Position:CGPointMake(34,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52202 Id:103] autorelease] Position:CGPointMake(16,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52202 Id:104] autorelease] Position:CGPointMake(30,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52203 Id:105] autorelease] Position:CGPointMake(21,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52203 Id:106 DropItem:106] autorelease] Position:CGPointMake(25,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52203 Id:107] autorelease] Position:CGPointMake(18,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52203 Id:108] autorelease] Position:CGPointMake(28,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52204 Id:109] autorelease] Position:CGPointMake(9,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52204 Id:110] autorelease] Position:CGPointMake(9,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52204 Id:111 DropItem:103] autorelease] Position:CGPointMake(9,27)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52204 Id:112] autorelease] Position:CGPointMake(37,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52204 Id:113] autorelease] Position:CGPointMake(37,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52204 Id:114 DropItem:902] autorelease] Position:CGPointMake(37,27)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52204 Id:115] autorelease] Position:CGPointMake(22,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52204 Id:116] autorelease] Position:CGPointMake(23,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52204 Id:117] autorelease] Position:CGPointMake(24,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52204 Id:118] autorelease] Position:CGPointMake(22,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52204 Id:119 DropItem:902] autorelease] Position:CGPointMake(23,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52204 Id:120] autorelease] Position:CGPointMake(24,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52205 Id:120] autorelease] Position:CGPointMake(15,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52205 Id:121] autorelease] Position:CGPointMake(31,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52205 Id:122] autorelease] Position:CGPointMake(22,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52205 Id:123] autorelease] Position:CGPointMake(24,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52205 Id:124] autorelease] Position:CGPointMake(20,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52205 Id:125 DropItem:903] autorelease] Position:CGPointMake(26,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52206 Id:126] autorelease] Position:CGPointMake(14,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52206 Id:127] autorelease] Position:CGPointMake(14,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52206 Id:128] autorelease] Position:CGPointMake(15,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52206 Id:129] autorelease] Position:CGPointMake(32,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52206 Id:130] autorelease] Position:CGPointMake(32,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52206 Id:131 DropItem:103] autorelease] Position:CGPointMake(31,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52206 Id:132] autorelease] Position:CGPointMake(22,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52206 Id:133] autorelease] Position:CGPointMake(23,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52206 Id:134 DropItem:903] autorelease] Position:CGPointMake(24,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52207 Id:135] autorelease] Position:CGPointMake(13,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52207 Id:136] autorelease] Position:CGPointMake(14,27)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52207 Id:137] autorelease] Position:CGPointMake(15,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52207 Id:138] autorelease] Position:CGPointMake(16,27)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52207 Id:139] autorelease] Position:CGPointMake(30,27)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52207 Id:140] autorelease] Position:CGPointMake(31,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52207 Id:141 DropItem:102] autorelease] Position:CGPointMake(32,27)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52207 Id:142] autorelease] Position:CGPointMake(33,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52208 Id:143] autorelease] Position:CGPointMake(18,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52208 Id:144] autorelease] Position:CGPointMake(28,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52208 Id:145 DropItem:103] autorelease] Position:CGPointMake(12,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52208 Id:146] autorelease] Position:CGPointMake(35,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52208 Id:147] autorelease] Position:CGPointMake(21,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52208 Id:148] autorelease] Position:CGPointMake(25,10)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52201 Id:199 DropItem:344] autorelease] Position:CGPointMake(23,17)];
	
    for (int i = 105; i <= 108; i++) {
        [self setAiOfId:i withType:AIType_Guard];
    }
    for (int i = 118; i <= 120; i++) {
        [self setAiOfId:i withType:AIType_Guard];
    }
    for (int i = 126; i <= 134; i++) {
        [self setAiOfId:i withType:AIType_Guard];
    }
    for (int i = 143; i <= 148; i++) {
        [self setAiOfId:i withType:AIType_Guard];
    }
    [self setAiOfId:199 withType:AIType_Guard];
    
	// Talk
	for (int i = 1; i <= 11; i++) {
		[self showTalkMessage:22 conversation:1 sequence:i];
	}
}

-(void) reinforcement
{
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52209 Id:201] autorelease] Position:CGPointMake(2,42)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52209 Id:202] autorelease] Position:CGPointMake(3,41)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52209 Id:203] autorelease] Position:CGPointMake(4,42)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52209 Id:204] autorelease] Position:CGPointMake(42,42)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52209 Id:205] autorelease] Position:CGPointMake(43,41)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52209 Id:206] autorelease] Position:CGPointMake(44,42)];
    
    // Talk
	for (int i = 1; i <= 3; i++) {
		[self showTalkMessage:22 conversation:2 sequence:i];
	}
}

-(void) reinforcement2
{
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52209 Id:207] autorelease] Position:CGPointMake(2,42)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52209 Id:208] autorelease] Position:CGPointMake(3,41)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52209 Id:209] autorelease] Position:CGPointMake(4,42)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52209 Id:200] autorelease] Position:CGPointMake(42,42)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52209 Id:211] autorelease] Position:CGPointMake(43,41)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52209 Id:212] autorelease] Position:CGPointMake(44,42)];
}

-(void) salaAppear
{
	[field addFriend:[[[FDFriend alloc] initWithDefinition:27 Id:27] autorelease] Position:CGPointMake(22,49)];
	[layers moveCreatureId:27 To:CGPointMake(22, 37) showMenu:FALSE];
	
	// Talk
	for (int i = 1; i <= 9; i++) {
		[self showTalkMessage:22 conversation:3 sequence:i];
	}
}

-(void) bossDyingMessage
{
	[self showTalkMessage:22 conversation:4 sequence:1];
}

-(void) enemyClear
{
	[layers gameCleared];
    
    // Add transfer gun to xierfa
    FDCreature *xierfa = [field getCreatureById:25];
    if (xierfa != nil) {
        [xierfa.data addItem:263];
    }
    
    for (int i = 2; i <= 14; i++) {
		[self showTalkMessage:22 conversation:4 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end

