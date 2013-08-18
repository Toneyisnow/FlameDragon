//
//  EventChapter20.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter20.h"
#import "FDDurationActivity.h"

@implementation EventChapter20

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];

	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadDieEvent:23 Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Npc Action:@selector(gameOver)];
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	NSLog(@"Chapter20 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(31,36)];
	[self settleFriend:2 At:CGPointMake(32,35)];
	[self settleFriend:3 At:CGPointMake(34,35)];
	[self settleFriend:4 At:CGPointMake(33,36)];
	[self settleFriend:5 At:CGPointMake(32,37)];
	[self settleFriend:6 At:CGPointMake(31,38)];
	[self settleFriend:7 At:CGPointMake(33,38)];
	[self settleFriend:8 At:CGPointMake(34,37)];
	[self settleFriend:9 At:CGPointMake(35,36)];
	[self settleFriend:10 At:CGPointMake(32,39)];
	[self settleFriend:11 At:CGPointMake(30,37)];
	[self settleFriend:12 At:CGPointMake(29,38)];
	[self settleFriend:13 At:CGPointMake(29,36)];
	[self settleFriend:14 At:CGPointMake(30,35)];
	[self settleFriend:15 At:CGPointMake(31,34)];
	[self settleFriend:16 At:CGPointMake(30,39)];
	
	// Add Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:51] autorelease] Position:CGPointMake(4,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:52] autorelease] Position:CGPointMake(5,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:53] autorelease] Position:CGPointMake(6,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:54] autorelease] Position:CGPointMake(7,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:55] autorelease] Position:CGPointMake(18,29)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:56] autorelease] Position:CGPointMake(20,29)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:57] autorelease] Position:CGPointMake(4,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:58] autorelease] Position:CGPointMake(4,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:59] autorelease] Position:CGPointMake(4,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:60 DropItem:804] autorelease] Position:CGPointMake(7,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:61] autorelease] Position:CGPointMake(11,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:62] autorelease] Position:CGPointMake(15,35)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:63] autorelease] Position:CGPointMake(31,28)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:64 DropItem:104] autorelease] Position:CGPointMake(36,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:65] autorelease] Position:CGPointMake(33,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:66] autorelease] Position:CGPointMake(35,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:67] autorelease] Position:CGPointMake(29,6)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:68 DropItem:104] autorelease] Position:CGPointMake(4,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:69] autorelease] Position:CGPointMake(6,6)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52001 Id:70] autorelease] Position:CGPointMake(11,5)];
	
    for (int i = 51; i <= 70; i++) {
		[self setAiOfId:i withType:AIType_Guard];
	}
	
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52002 Id:101] autorelease] Position:CGPointMake(11,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52002 Id:102] autorelease] Position:CGPointMake(16,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52008 Id:103] autorelease] Position:CGPointMake(13,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52008 Id:104 DropItem:107] autorelease] Position:CGPointMake(20,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52003 Id:105] autorelease] Position:CGPointMake(15,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52003 Id:106] autorelease] Position:CGPointMake(20,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52003 Id:107] autorelease] Position:CGPointMake(23,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52003 Id:108] autorelease] Position:CGPointMake(26,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52004 Id:109] autorelease] Position:CGPointMake(10,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52004 Id:110] autorelease] Position:CGPointMake(16,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52004 Id:111] autorelease] Position:CGPointMake(19,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52004 Id:112 DropItem:210] autorelease] Position:CGPointMake(31,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52005 Id:113] autorelease] Position:CGPointMake(18,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52005 Id:114] autorelease] Position:CGPointMake(23,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52005 Id:115] autorelease] Position:CGPointMake(26,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52005 Id:116 DropItem:113] autorelease] Position:CGPointMake(30,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52005 Id:117] autorelease] Position:CGPointMake(19,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52005 Id:118] autorelease] Position:CGPointMake(18,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52005 Id:119] autorelease] Position:CGPointMake(18,18)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52005 Id:120 DropItem:104] autorelease] Position:CGPointMake(17,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52005 Id:121] autorelease] Position:CGPointMake(12,15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52005 Id:122 DropItem:904] autorelease] Position:CGPointMake(13,14)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52005 Id:123] autorelease] Position:CGPointMake(13,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52005 Id:124] autorelease] Position:CGPointMake(14,15)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52006 Id:125] autorelease] Position:CGPointMake(17,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52006 Id:126] autorelease] Position:CGPointMake(12,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52006 Id:127] autorelease] Position:CGPointMake(10,22)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52006 Id:128] autorelease] Position:CGPointMake(7,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52006 Id:129] autorelease] Position:CGPointMake(14,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52006 Id:130] autorelease] Position:CGPointMake(14,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52006 Id:131] autorelease] Position:CGPointMake(15,12)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52006 Id:132] autorelease] Position:CGPointMake(15,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52006 Id:133] autorelease] Position:CGPointMake(24,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52006 Id:134] autorelease] Position:CGPointMake(24,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52006 Id:135 DropItem:904] autorelease] Position:CGPointMake(25,16)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52006 Id:136] autorelease] Position:CGPointMake(25,17)];
	[self setAiOfId:109 withType:AIType_StandBy];
	[self setAiOfId:112 withType:AIType_StandBy];
	[self setAiOfId:101 withType:AIType_Guard];
	
	// Add NPC
	[field addFriend:[[[FDFriend alloc] initWithDefinition:23 Id:23] autorelease] Position:CGPointMake(22,13)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52009 Id:201] autorelease] Position:CGPointMake(20,13)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52009 Id:202] autorelease] Position:CGPointMake(21,12)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52009 Id:203] autorelease] Position:CGPointMake(21,14)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52009 Id:204] autorelease] Position:CGPointMake(22,11)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52009 Id:205] autorelease] Position:CGPointMake(22,15)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52009 Id:206] autorelease] Position:CGPointMake(23,12)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52009 Id:207] autorelease] Position:CGPointMake(23,14)];
	[field addNpc:[[[FDNpc alloc] initWithDefinition:52009 Id:208] autorelease] Position:CGPointMake(24,13)];
	
	// Talk
	for (int i = 1; i <= 17; i++) {
		[self showTalkMessage:20 conversation:1 sequence:i];
	}
}

-(void) enemyClear
{
	[layers gameCleared];
    
    for (int i = 1; i <= 13; i++) {
		[self showTalkMessage:20 conversation:2 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(enemyClear2) Param1:nil Param2:nil Obj:self];
}

-(void) enemyClear2
{
	if ([layers getTurnNumber] <= 15)
    {
        // Dakesai Appear
        [field addFriend:[[[FDFriend alloc] initWithDefinition:24 Id:24] autorelease] Position:CGPointMake(26,40)];
        [layers moveCreatureId:24 To:CGPointMake(26,37) showMenu:FALSE];
        [layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:0.5] autorelease]];
        
        for (int i = 1; i <= 16; i++) {
            [self showTalkMessage:20 conversation:3 sequence:i];
        }
	}
    
    [layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end
