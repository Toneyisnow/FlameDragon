//
//  EventChapter13.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter13.h"


@implementation EventChapter13

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
	[self loadTurnEvent:TurnType_Friend Turn:4 Action:@selector(hawateAppear)];
	[self loadTurnEvent:TurnType_Friend Turn:9 Action:@selector(reinforcement)];

	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Npc Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
    [self loadPositionEvent:125 AtPosition:CGPointMake(25,1) Action:@selector(onEscaped)];
	
	[self loadPositionEvent:1 AtPosition:CGPointMake(25,6) Action:@selector(onHeroBadge)];
	
	NSLog(@"Chapter13 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(4, 16)];
	[self settleFriend:2 At:CGPointMake(5, 15)];
	[self settleFriend:3 At:CGPointMake(3, 17)];
	[self settleFriend:4 At:CGPointMake(5, 18)];
	[self settleFriend:5 At:CGPointMake(3, 19)];
	[self settleFriend:6 At:CGPointMake(2, 18)];
	[self settleFriend:7 At:CGPointMake(2, 16)];
	[self settleFriend:8 At:CGPointMake(2, 13)];
	[self settleFriend:9 At:CGPointMake(5, 20)];
	[self settleFriend:10 At:CGPointMake(4, 13)];
	[self settleFriend:11 At:CGPointMake(6, 13)];
	[self settleFriend:12 At:CGPointMake(3, 15)];
	[self settleFriend:13 At:CGPointMake(6, 17)];
	[self settleFriend:14 At:CGPointMake(1, 17)];
	[self settleFriend:15 At:CGPointMake(7, 19)];
	
	// Add Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51304 Id:101] autorelease] Position:CGPointMake(29,15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51304 Id:102 DropItem:903] autorelease] Position:CGPointMake(27,4)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51304 Id:103] autorelease] Position:CGPointMake(34,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51304 Id:104] autorelease] Position:CGPointMake(34,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51304 Id:105 DropItem:901] autorelease] Position:CGPointMake(33,3)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:106 DropItem:903] autorelease] Position:CGPointMake(25,6)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:107 DropItem:902] autorelease] Position:CGPointMake(27,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:108] autorelease] Position:CGPointMake(26,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:109] autorelease] Position:CGPointMake(23,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:110] autorelease] Position:CGPointMake(21,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:111] autorelease] Position:CGPointMake(29,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:112] autorelease] Position:CGPointMake(30,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:113 DropItem:116] autorelease] Position:CGPointMake(31,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:114 DropItem:102] autorelease] Position:CGPointMake(29,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:115] autorelease] Position:CGPointMake(27,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:116 DropItem:901] autorelease] Position:CGPointMake(31,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:117] autorelease] Position:CGPointMake(34,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:118] autorelease] Position:CGPointMake(33,7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:119] autorelease] Position:CGPointMake(34,1)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:120] autorelease] Position:CGPointMake(37,7)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:121] autorelease] Position:CGPointMake(37,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:122 DropItem:116] autorelease] Position:CGPointMake(36,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:123] autorelease] Position:CGPointMake(37,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:124 DropItem:102] autorelease] Position:CGPointMake(39,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:125 DropItem:803] autorelease] Position:CGPointMake(10,3)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:126 DropItem:102] autorelease] Position:CGPointMake(40,10)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51303 Id:127] autorelease] Position:CGPointMake(31,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51303 Id:128 DropItem:901] autorelease] Position:CGPointMake(31,1)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51303 Id:129] autorelease] Position:CGPointMake(34,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51303 Id:130] autorelease] Position:CGPointMake(28,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51303 Id:131 DropItem:903] autorelease] Position:CGPointMake(38,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51303 Id:132 DropItem:102] autorelease] Position:CGPointMake(39,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51303 Id:133] autorelease] Position:CGPointMake(34,25)];
	
    [self setAiOfId:125 getTreasure:CGPointMake(6,4) EscapeTo:CGPointMake(25,1)];
    
	
	// Add NPC
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51305 Id:51] autorelease] Position:CGPointMake(20,15)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51305 Id:52] autorelease] Position:CGPointMake(21,14)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51305 Id:53] autorelease] Position:CGPointMake(22,17)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51305 Id:54] autorelease] Position:CGPointMake(24,18)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51305 Id:55] autorelease] Position:CGPointMake(23,12)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51305 Id:56] autorelease] Position:CGPointMake(21,11)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51305 Id:57] autorelease] Position:CGPointMake(21,8)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51305 Id:58] autorelease] Position:CGPointMake(19,7)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51305 Id:59] autorelease] Position:CGPointMake(18,11)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51305 Id:60] autorelease] Position:CGPointMake(17,14)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51305 Id:61] autorelease] Position:CGPointMake(18,18)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:51305 Id:62] autorelease] Position:CGPointMake(20,20)];
	
	// Talk
	for (int i = 1; i <= 6; i++) {
		[self showTalkMessage:13 conversation:1 sequence:i];
	}
}

-(void) onHeroBadge
{
	// Talk
	FDNpc *npc = [[FDNpc alloc] initWithDefinition:718 Id:88];
	[[field getDeadCreatureList] addObject:npc];
	[npc release];
	
	for (int i = 1; i <= 3; i++) {
		[self showTalkMessage:13 conversation:5 sequence:i];
	}
	
	// Add Item
	FDCreature *suoer = [field getCreatureById:1];
	if (![suoer isItemListFull])
	{
		[suoer addItem:811];
	}
}

-(void) onEscaped
{
    [self removeCreature:125];
}

-(void) hawateAppear
{
	// [field addNpc:[[[FDNpc alloc] initWithDefinition:16 Id:16] autorelease] Position:CGPointMake(24,25)];
	[field addFriend:[[[FDFriend alloc] initWithDefinition:16 Id:16] autorelease] Position:CGPointMake(24,25)];
	
	// Talk
	for (int i = 1; i <= 7; i++) {
		[self showTalkMessage:13 conversation:2 sequence:i];
	}
}

-(void) reinforcement
{
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:151] autorelease] Around:CGPointMake(36,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:152] autorelease] Around:CGPointMake(37,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:153 DropItem:901] autorelease] Around:CGPointMake(37,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:154] autorelease] Around:CGPointMake(38,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:155] autorelease] Around:CGPointMake(38,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:156] autorelease] Around:CGPointMake(38,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:157] autorelease] Around:CGPointMake(39,9)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:158 DropItem:103] autorelease] Around:CGPointMake(39,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51302 Id:159] autorelease] Around:CGPointMake(40,10)];
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:51301 Id:199 DropItem:309] autorelease] Around:CGPointMake(35,9)];
	
	[self showTalkMessage:13 conversation:3 sequence:1];
}

-(void) enemyClear
{
	[layers gameCleared];
    
    /*
	FDFriend *hawate = [[FDFriend alloc] initWithDefinition:16 Id:16];
	[[field getFriendList] addObject:hawate];
	*/
	
	for (int i = 1; i <= 11; i++) {
		[self showTalkMessage:13 conversation:4 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end
