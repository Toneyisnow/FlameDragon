//
//  EventChapter15.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter15.h"


@implementation EventChapter15

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
	[self loadTurnEvent:TurnType_Friend Turn:4 Action:@selector(npcFightBack)];
	[self loadTurnEvent:TurnType_Friend Turn:7 Action:@selector(reinforcement)];
	[self loadTurnEvent:TurnType_Friend Turn:10 Action:@selector(batch2)];

	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadDieEvent:201 Action:@selector(gameOver)];
	[self loadDieEvent:151 Action:@selector(getStar)];
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	[self loadPositionEvent:151 AtPosition:CGPointMake(5,1) Action:@selector(onEscaped1)];
	[self loadPositionEvent:152 AtPosition:CGPointMake(5,1) Action:@selector(onEscaped2)];
	[self loadPositionEvent:153 AtPosition:CGPointMake(5,1) Action:@selector(onEscaped3)];
	[self loadPositionEvent:154 AtPosition:CGPointMake(5,1) Action:@selector(onEscaped4)];
	
	[self loadDyingEvent:199 Action:@selector(bossDyingMessage)];
	
	NSLog(@"Chapter15 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(39,46)];
	[self settleFriend:2 At:CGPointMake(38,45)];
	[self settleFriend:3 At:CGPointMake(42,45)];
	[self settleFriend:4 At:CGPointMake(43,47)];
	[self settleFriend:5 At:CGPointMake(37,46)];
	[self settleFriend:6 At:CGPointMake(39,48)];
	[self settleFriend:7 At:CGPointMake(42,49)];
	[self settleFriend:8 At:CGPointMake(40,49)];
	[self settleFriend:9 At:CGPointMake(36,49)];
	[self settleFriend:10 At:CGPointMake(37,48)];
	[self settleFriend:11 At:CGPointMake(35,47)];
	[self settleFriend:12 At:CGPointMake(44,48)];
	[self settleFriend:13 At:CGPointMake(44,46)];
	[self settleFriend:14 At:CGPointMake(41,47)];
	[self settleFriend:15 At:CGPointMake(40,44)];
	[self settleFriend:16 At:CGPointMake(36,44)];
	
	// Add Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51502 Id:101] autorelease] Position:CGPointMake(42,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51502 Id:102] autorelease] Position:CGPointMake(44,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51503 Id:103] autorelease] Position:CGPointMake(40,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51503 Id:104] autorelease] Position:CGPointMake(46,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:105] autorelease] Position:CGPointMake(39,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:106] autorelease] Position:CGPointMake(41,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:107] autorelease] Position:CGPointMake(45,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:108 DropItem:902] autorelease] Position:CGPointMake(47,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:109] autorelease] Position:CGPointMake(35,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:110] autorelease] Position:CGPointMake(37,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:111] autorelease] Position:CGPointMake(35,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:112] autorelease] Position:CGPointMake(37,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:113] autorelease] Position:CGPointMake(34,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:114] autorelease] Position:CGPointMake(36,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:115] autorelease] Position:CGPointMake(34,18)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:116] autorelease] Position:CGPointMake(36,18)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:117 DropItem:103] autorelease] Position:CGPointMake(38,18)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:118] autorelease] Position:CGPointMake(40,18)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:119] autorelease] Position:CGPointMake(38,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:120] autorelease] Position:CGPointMake(40,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51507 Id:121] autorelease] Position:CGPointMake(42,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51507 Id:122] autorelease] Position:CGPointMake(44,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51507 Id:123] autorelease] Position:CGPointMake(36,27)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51507 Id:124] autorelease] Position:CGPointMake(35,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51507 Id:125 DropItem:902] autorelease] Position:CGPointMake(39,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51504 Id:126] autorelease] Position:CGPointMake(38,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51504 Id:127] autorelease] Position:CGPointMake(49,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51505 Id:128 DropItem:103] autorelease] Position:CGPointMake(40,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51505 Id:129] autorelease] Position:CGPointMake(47,30)];
	
	// Batch 2
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51502 Id:130] autorelease] Position:CGPointMake(29,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51502 Id:131 DropItem:105] autorelease] Position:CGPointMake(35,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51503 Id:132 DropItem:103] autorelease] Position:CGPointMake(31,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51503 Id:133] autorelease] Position:CGPointMake(33,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51503 Id:134] autorelease] Position:CGPointMake(30,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51503 Id:135] autorelease] Position:CGPointMake(34,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51503 Id:136] autorelease] Position:CGPointMake(31,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51503 Id:137] autorelease] Position:CGPointMake(33,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:138 DropItem:901] autorelease] Position:CGPointMake(32,15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:139] autorelease] Position:CGPointMake(31,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:140] autorelease] Position:CGPointMake(33,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:141] autorelease] Position:CGPointMake(30,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:142 DropItem:103] autorelease] Position:CGPointMake(32,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51506 Id:143] autorelease] Position:CGPointMake(34,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51504 Id:144 DropItem:803] autorelease] Position:CGPointMake(29,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51504 Id:145] autorelease] Position:CGPointMake(35,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51505 Id:146] autorelease] Position:CGPointMake(30,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51505 Id:147] autorelease] Position:CGPointMake(34,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51501 Id:199 DropItem:229] autorelease] Position:CGPointMake(32,10)];
	
	for (int i = 130; i <= 147; i++) {
		[self setAiOfId:i withType:AIType_StandBy];
	}
	[self setAiOfId:199 withType:AIType_StandBy];
	
	// Add NPC
	[field addNpc:[[[FDNpc alloc] initWithDefinition:17 Id:201] autorelease] Position:CGPointMake(31,22)];
	
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51508 Id:202] autorelease] Position:CGPointMake(31,20)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51508 Id:203] autorelease] Position:CGPointMake(30,21)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51508 Id:204] autorelease] Position:CGPointMake(29,22)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51508 Id:205] autorelease] Position:CGPointMake(30,23)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51508 Id:206] autorelease] Position:CGPointMake(31,24)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51508 Id:207] autorelease] Position:CGPointMake(29,20)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51508 Id:208] autorelease] Position:CGPointMake(28,21)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51508 Id:209] autorelease] Position:CGPointMake(28,23)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51508 Id:210] autorelease] Position:CGPointMake(29,24)];
	for (int i = 201; i <= 210; i++) {
		[self setAiOfId:i EscapeTo:CGPointMake(16,22)];	
	}
	
	// Talk
	if ([field getCreatureById:10] != nil) {
		for (int i = 1; i <= 10; i++) {
			[self showTalkMessage:15 conversation:1 sequence:i];
		}
	} else {
		for (int i = 1; i <= 8; i++) {
			[self showTalkMessage:15 conversation:2 sequence:i];
		}
	}
	
}

-(void) npcFightBack
{
	for (int i = 201; i <= 210; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
	
	[self showTalkMessage:15 conversation:2 sequence:9];
}

-(void) batch2
{
	for (int i = 130; i <= 147; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
	[self setAiOfId:199 withType:AIType_Aggressive];
	
	[self showTalkMessage:15 conversation:2 sequence:10];
}

-(void) reinforcement
{
	FDEnemy *enemy1 = [[[FDEnemy alloc] initWithDefinition:51506 Id:151 DropItem:118] autorelease];
	[enemy1.data addItem:118];
	[field addEnemy:enemy1 Position:CGPointMake(34,2)];
	
	FDEnemy *enemy2 = [[[FDEnemy alloc] initWithDefinition:51506 Id:152 DropItem:809] autorelease];
	[enemy2.data addItem:809];
	[field addEnemy:enemy2 Position:CGPointMake(35,1)];
	
	FDEnemy *enemy3 = [[[FDEnemy alloc] initWithDefinition:51506 Id:153 DropItem:113] autorelease];
	[enemy3.data addItem:113];
	[field addEnemy:enemy3 Position:CGPointMake(34,1)];
	
	FDEnemy *enemy4 = [[[FDEnemy alloc] initWithDefinition:51506 Id:154 DropItem:806] autorelease];
	[enemy4.data addItem:806];
	[field addEnemy:enemy4 Position:CGPointMake(33,1)];
	
	[self setAiOfId:151 EscapeTo:CGPointMake(5,1)];	
	[self setAiOfId:152 EscapeTo:CGPointMake(5,1)];	
	[self setAiOfId:153 EscapeTo:CGPointMake(5,1)];	
	[self setAiOfId:154 EscapeTo:CGPointMake(5,1)];
	
	// Talk
	for (int i = 1; i <= 8; i++) {
		[self showTalkMessage:15 conversation:3 sequence:i];
	}
}

-(void) onEscaped1
{
	FDCreature *c = [field getCreatureById:151];
	if (c != nil) {
		[field removeObject:c];
	}
}

-(void) onEscaped2
{
	FDCreature *c = [field getCreatureById:152];
	if (c != nil) {
		[field removeObject:c];
	}
}

-(void) onEscaped3
{
	FDCreature *c = [field getCreatureById:153];
	if (c != nil) {
		[field removeObject:c];
	}
}

-(void) onEscaped4
{
	FDCreature *c = [field getCreatureById:154];
	if (c != nil) {
		[field removeObject:c];
	}
}

-(void) getStar
{
	for (int i = 1; i <= 5; i++) {
		[self showTalkMessage:15 conversation:4 sequence:i];
	}
}

-(void) bossDyingMessage
{
	for (int i = 1; i <= 2; i++) {
		[self showTalkMessage:15 conversation:5 sequence:i];
	}
}

-(void) enemyClear
{
	[layers gameCleared];
    
    // Talk
	if ([field getCreatureById:10] != nil) {
		for (int i = 1; i <= 4; i++) {
			[self showTalkMessage:15 conversation:6 sequence:i];
		}
	} else {
		for (int i = 5; i <= 8; i++) {
			[self showTalkMessage:15 conversation:6 sequence:i];
		}
	}
	for (int i = 9; i <= 16; i++) {
		[self showTalkMessage:15 conversation:6 sequence:i];
	}
	
	FDFriend *saikebangle = [[FDFriend alloc] initWithDefinition:17 Id:17];
	[[field getFriendList] addObject:saikebangle];
	[saikebangle release];
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end
