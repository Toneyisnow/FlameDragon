//
//  EventChapter19.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter19.h"


@implementation EventChapter19

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
	[self loadTurnEvent:TurnType_Friend Turn:4 Action:@selector(batch2)];
	[self loadTurnEvent:TurnType_Friend Turn:8 Action:@selector(batch3)];

    [self loadPositionEvent:151 AtPosition:CGPointMake(25,5) Action:@selector(onEscaped1)];
	[self loadPositionEvent:152 AtPosition:CGPointMake(25,4) Action:@selector(onEscaped2)];
	[self loadPositionEvent:153 AtPosition:CGPointMake(6,2) Action:@selector(onEscaped3)];
	
	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	[self loadDyingEvent:199 Action:@selector(bossDyingMessage)];
	
	NSLog(@"Chapter19 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(11,37)];
	[self settleFriend:2 At:CGPointMake(13,37)];
	[self settleFriend:3 At:CGPointMake(15,37)];
	[self settleFriend:4 At:CGPointMake(12,38)];
	[self settleFriend:5 At:CGPointMake(14,38)];
	[self settleFriend:6 At:CGPointMake(16,38)];
	[self settleFriend:7 At:CGPointMake(10,38)];
	[self settleFriend:8 At:CGPointMake(11,39)];
	[self settleFriend:9 At:CGPointMake(13,39)];
	[self settleFriend:10 At:CGPointMake(15,39)];
	[self settleFriend:11 At:CGPointMake(14,40)];
	[self settleFriend:12 At:CGPointMake(12,40)];
	[self settleFriend:13 At:CGPointMake(10,40)];
	[self settleFriend:14 At:CGPointMake(16,40)];
	[self settleFriend:15 At:CGPointMake(17,39)];
	[self settleFriend:16 At:CGPointMake(9,39)];
	
	[field addFriend:[[[FDFriend alloc] initWithDefinition:22 Id:22] autorelease] Position:CGPointMake(4,40)];
	
	
	// Add Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51902 Id:101] autorelease] Position:CGPointMake(11,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51902 Id:102] autorelease] Position:CGPointMake(20,29)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51908 Id:103] autorelease] Position:CGPointMake(9,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51908 Id:104] autorelease] Position:CGPointMake(22,29)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51903 Id:105] autorelease] Position:CGPointMake(8,29)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51903 Id:106] autorelease] Position:CGPointMake(23,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51904 Id:107] autorelease] Position:CGPointMake(10,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51904 Id:108] autorelease] Position:CGPointMake(21,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51905 Id:109] autorelease] Position:CGPointMake(9,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51905 Id:110] autorelease] Position:CGPointMake(10,29)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51905 Id:111] autorelease] Position:CGPointMake(11,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51905 Id:112] autorelease] Position:CGPointMake(20,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51905 Id:113] autorelease] Position:CGPointMake(21,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51905 Id:114] autorelease] Position:CGPointMake(22,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51907 Id:115] autorelease] Position:CGPointMake(11,29)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51907 Id:116] autorelease] Position:CGPointMake(19,30)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51902 Id:117] autorelease] Position:CGPointMake(5,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51902 Id:118] autorelease] Position:CGPointMake(14,15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51908 Id:119] autorelease] Position:CGPointMake(21,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51904 Id:119] autorelease] Position:CGPointMake(4,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51904 Id:120] autorelease] Position:CGPointMake(5,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51904 Id:121] autorelease] Position:CGPointMake(6,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51904 Id:122] autorelease] Position:CGPointMake(20,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51904 Id:123] autorelease] Position:CGPointMake(21,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51904 Id:124] autorelease] Position:CGPointMake(22,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51905 Id:125] autorelease] Position:CGPointMake(13,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51905 Id:126] autorelease] Position:CGPointMake(14,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51905 Id:127] autorelease] Position:CGPointMake(15,14)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51902 Id:128] autorelease] Position:CGPointMake(19,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51902 Id:129] autorelease] Position:CGPointMake(17,6)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51908 Id:130] autorelease] Position:CGPointMake(6,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51908 Id:131] autorelease] Position:CGPointMake(24,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51908 Id:132] autorelease] Position:CGPointMake(24,5)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51903 Id:133] autorelease] Position:CGPointMake(20,7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51903 Id:134] autorelease] Position:CGPointMake(22,7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51903 Id:135] autorelease] Position:CGPointMake(20,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51903 Id:136] autorelease] Position:CGPointMake(22,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51905 Id:137] autorelease] Position:CGPointMake(5,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51905 Id:138] autorelease] Position:CGPointMake(6,7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51905 Id:139] autorelease] Position:CGPointMake(7,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51905 Id:140] autorelease] Position:CGPointMake(21,5)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51905 Id:141] autorelease] Position:CGPointMake(21,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51907 Id:142] autorelease] Position:CGPointMake(18,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51907 Id:143] autorelease] Position:CGPointMake(24,8)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51901 Id:199] autorelease] Position:CGPointMake(21,8)];
	
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51906 Id:151] autorelease] Position:CGPointMake(10,18)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51906 Id:152] autorelease] Position:CGPointMake(11,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51906 Id:153] autorelease] Position:CGPointMake(12,18)];
	
    for (int i = 117; i <= 143; i++) {
		[self setAiOfId:i withType:AIType_Guard];
	}
	[self setAiOfId:199 withType:AIType_Guard];
	[self setAiOfId:151 withType:AIType_Guard];
    [self setAiOfId:152 withType:AIType_Guard];
    [self setAiOfId:153 withType:AIType_Guard];
    
	// Talk
	for (int i = 1; i <= 13; i++) {
		[self showTalkMessage:19 conversation:1 sequence:i];
	}
}

-(void) batch2 {

    [self setAiOfId:151 getTreasure:CGPointMake(22,24) EscapeTo:CGPointMake(25, 5)];
    [self setAiOfId:152 getTreasure:CGPointMake(14, 2) EscapeTo:CGPointMake(25, 4)];
    [self setAiOfId:153 getTreasure:CGPointMake( 1,12) EscapeTo:CGPointMake( 6, 2)];
    
	for (int i = 117; i <= 127; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
}

-(void) batch3 {

	for (int i = 128; i <= 143; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
	[self setAiOfId:199 withType:AIType_Aggressive];
}

-(void) onEscaped1
{
    [self removeCreature:151];
}

-(void) onEscaped2
{
    [self removeCreature:152];
}

-(void) onEscaped3
{
    [self removeCreature:153];
}

-(void) bossDyingMessage
{
	[self showTalkMessage:19 conversation:2 sequence:1];
}

-(void) enemyClear
{
	for (int i = 1; i <= 10; i++) {
		[self showTalkMessage:19 conversation:3 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end
