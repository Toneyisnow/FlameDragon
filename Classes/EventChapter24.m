//
//  EventChapter24.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter24.h"
#import "FDDurationActivity.h"

@implementation EventChapter24

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
    [self loadTurnEvent:TurnType_Friend Turn:2 Action:@selector(turn2)];
    [self loadTurnEvent:TurnType_Friend Turn:4 Action:@selector(turn4)];
    [self loadTurnEvent:TurnType_Friend Turn:7 Action:@selector(turn7)];
    [self loadTurnEvent:TurnType_Friend Turn:10 Action:@selector(turn10)];
    
	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	NSLog(@"Chapter24 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(21,20)];
	[self settleFriend:2 At:CGPointMake(22,20)];
	[self settleFriend:3 At:CGPointMake(20,20)];
	[self settleFriend:4 At:CGPointMake(23,19)];
	[self settleFriend:5 At:CGPointMake(23,18)];
	[self settleFriend:6 At:CGPointMake(23,17)];
	[self settleFriend:7 At:CGPointMake(22,17)];
	[self settleFriend:8 At:CGPointMake(22,16)];
	[self settleFriend:9 At:CGPointMake(21,16)];
	[self settleFriend:10 At:CGPointMake(20,16)];
	[self settleFriend:11 At:CGPointMake(20,17)];
	[self settleFriend:12 At:CGPointMake(19,17)];
	[self settleFriend:13 At:CGPointMake(19,18)];
	[self settleFriend:14 At:CGPointMake(19,19)];
	[self settleFriend:15 At:CGPointMake(20,19)];
	[self settleFriend:16 At:CGPointMake(22,19)];
	
	// Add Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52402 Id:101 DropItem:103] autorelease] Position:CGPointMake(8,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52402 Id:102 DropItem:104] autorelease] Position:CGPointMake(33,7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52402 Id:103 DropItem:103] autorelease] Position:CGPointMake(8,27)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52402 Id:104 DropItem:104] autorelease] Position:CGPointMake(33,29)];
	
	// Talk
	for (int i = 1; i <= 14; i++) {
		[self showTalkMessage:24 conversation:1 sequence:i];
	}
}

-(void) turn2 {
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52403 Id:105 DropItem:103] autorelease] Position:CGPointMake(8,10)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52403 Id:106 DropItem:103] autorelease] Position:CGPointMake(9,9)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52403 Id:107 DropItem:114] autorelease] Position:CGPointMake(32,7)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52403 Id:108 DropItem:901] autorelease] Position:CGPointMake(33,8)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52403 Id:109 DropItem:901] autorelease] Position:CGPointMake(8,26)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52403 Id:110 DropItem:106] autorelease] Position:CGPointMake(9,27)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52403 Id:111 DropItem:103] autorelease] Position:CGPointMake(32,29)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52403 Id:112 DropItem:103] autorelease] Position:CGPointMake(33,28)];
}

-(void) turn4 {
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:113 DropItem:901] autorelease] Position:CGPointMake(8,9)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:114 DropItem:901] autorelease] Position:CGPointMake(6,9)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:115 DropItem:241] autorelease] Position:CGPointMake(8,7)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:116 DropItem:103] autorelease] Position:CGPointMake(33,7)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:117 DropItem:902] autorelease] Position:CGPointMake(35,7)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:118 DropItem:113] autorelease] Position:CGPointMake(33,5)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:119 DropItem:325] autorelease] Position:CGPointMake(8,27)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:120 DropItem:106] autorelease] Position:CGPointMake(6,27)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:121 DropItem:116] autorelease] Position:CGPointMake(8,29)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:122 DropItem:901] autorelease] Position:CGPointMake(33,29)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:123 DropItem:332] autorelease] Position:CGPointMake(35,29)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:124 DropItem:901] autorelease] Position:CGPointMake(33,31)];
}

-(void) turn7 {
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:125 DropItem:103] autorelease] Position:CGPointMake(8,9)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:126 DropItem:901] autorelease] Position:CGPointMake(6,9)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:127 DropItem:104] autorelease] Position:CGPointMake(8,7)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52404 Id:128 DropItem:111] autorelease] Position:CGPointMake(6,7)];
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:129 DropItem:106] autorelease] Position:CGPointMake(33,7)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:130 DropItem:112] autorelease] Position:CGPointMake(35,7)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:131 DropItem:115] autorelease] Position:CGPointMake(33,5)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52404 Id:132 DropItem:103] autorelease] Position:CGPointMake(35,5)];
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:133 DropItem:103] autorelease] Position:CGPointMake(8,27)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:134 DropItem:106] autorelease] Position:CGPointMake(6,27)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:135 DropItem:104] autorelease] Position:CGPointMake(8,29)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52404 Id:136 DropItem:901] autorelease] Position:CGPointMake(6,29)];
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:137 DropItem:103] autorelease] Position:CGPointMake(33,29)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:138 DropItem:902] autorelease] Position:CGPointMake(35,29)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:139 DropItem:803] autorelease] Position:CGPointMake(33,31)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52404 Id:140 DropItem:111] autorelease] Position:CGPointMake(35,31)];
}

-(void) turn10 {
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52403 Id:141 DropItem:103] autorelease] Position:CGPointMake(8,9)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:142 DropItem:107] autorelease] Position:CGPointMake(6,9)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:143 DropItem:104] autorelease] Position:CGPointMake(8,7)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52403 Id:144 DropItem:103] autorelease] Position:CGPointMake(6,7)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52401 Id:145 DropItem:901] autorelease] Position:CGPointMake(7,8)];
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52403 Id:146 DropItem:803] autorelease] Position:CGPointMake(33,7)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:147 DropItem:112] autorelease] Position:CGPointMake(35,7)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:148 DropItem:902] autorelease] Position:CGPointMake(33,5)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52403 Id:149 DropItem:106] autorelease] Position:CGPointMake(35,5)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52401 Id:150 DropItem:103] autorelease] Position:CGPointMake(34,6)];
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52403 Id:151 DropItem:903] autorelease] Position:CGPointMake(8,27)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:152 DropItem:209] autorelease] Position:CGPointMake(6,27)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:153 DropItem:108] autorelease] Position:CGPointMake(8,29)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52403 Id:154 DropItem:804] autorelease] Position:CGPointMake(6,29)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52401 Id:155 DropItem:104] autorelease] Position:CGPointMake(7,28)];
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52403 Id:156 DropItem:107] autorelease] Position:CGPointMake(33,29)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:157 DropItem:103] autorelease] Position:CGPointMake(35,29)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52405 Id:158 DropItem:111] autorelease] Position:CGPointMake(33,31)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52403 Id:159 DropItem:103] autorelease] Position:CGPointMake(35,31)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52401 Id:160 DropItem:106] autorelease] Position:CGPointMake(34,30)];
}

-(void) enemyClear
{
	[layers gameCleared];
    
    for (int i = 1; i <= 11; i++) {
		[self showTalkMessage:24 conversation:2 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end
