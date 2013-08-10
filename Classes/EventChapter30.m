//
//  EventChapter30.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter30.h"


@implementation EventChapter30

-(void) loadEvents
{
  [self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];

	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadDieEvent:2 Action:@selector(gameOver)];

	[self loadDieEvent:101 Action:@selector(checkRound1)];
	[self loadDieEvent:102 Action:@selector(checkRound1)];
	[self loadDieEvent:103 Action:@selector(checkRound1)];
	[self loadDieEvent:104 Action:@selector(checkRound1)];
	[self loadDieEvent:105 Action:@selector(checkRound1)];
	
	[self loadDieEvent:201 Action:@selector(checkRound2)];
	[self loadDieEvent:111 Action:@selector(checkRound2)];
	[self loadDieEvent:112 Action:@selector(checkRound2)];
	[self loadDieEvent:113 Action:@selector(checkRound2)];
	[self loadDieEvent:114 Action:@selector(checkRound2)];
	
	[self loadDieEvent:202 Action:@selector(checkRound3)];
	[self loadDieEvent:121 Action:@selector(checkRound3)];
	[self loadDieEvent:122 Action:@selector(checkRound3)];
	[self loadDieEvent:123 Action:@selector(checkRound3)];
	[self loadDieEvent:124 Action:@selector(checkRound3)];
	
	[self loadDieEvent:293 Action:@selector(checkRound4)];
	[self loadDieEvent:131 Action:@selector(checkRound4)];
	[self loadDieEvent:132 Action:@selector(checkRound4)];
	[self loadDieEvent:133 Action:@selector(checkRound4)];
	[self loadDieEvent:134 Action:@selector(checkRound4)];
	
	[self loadDieEvent:204 Action:@selector(checkRound5)];
	[self loadDieEvent:141 Action:@selector(checkRound5)];
	[self loadDieEvent:142 Action:@selector(checkRound5)];
	[self loadDieEvent:143 Action:@selector(checkRound5)];
	[self loadDieEvent:144 Action:@selector(checkRound5)];
	
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	[self loadDyingEvent:999 Action:@selector(bossDyingMessage)];
	
	NSLog(@"Chapter30 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(23,24)];
	[self settleFriend:2 At:CGPointMake(21,24)];
	[self settleFriend:3 At:CGPointMake(22,26)];
	[self settleFriend:4 At:CGPointMake(25,25)];
	[self settleFriend:5 At:CGPointMake(26,27)];
	[self settleFriend:6 At:CGPointMake(27,29)];
	[self settleFriend:7 At:CGPointMake(22,32)];
	[self settleFriend:8 At:CGPointMake(24,31)];
	[self settleFriend:9 At:CGPointMake(18,28)];
	[self settleFriend:10 At:CGPointMake(23,28)];
	[self settleFriend:11 At:CGPointMake(20,23)];
	[self settleFriend:12 At:CGPointMake(26,23)];
	[self settleFriend:13 At:CGPointMake(26,31)];
	[self settleFriend:14 At:CGPointMake(22,30)];
	[self settleFriend:15 At:CGPointMake(20,27)];
	[self settleFriend:16 At:CGPointMake(20,30)];
	[self settleFriend:17 At:CGPointMake(25,29)];
	[self settleFriend:18 At:CGPointMake(28,27)];
	[self settleFriend:19 At:CGPointMake(24,26)];
	[self settleFriend:20 At:CGPointMake(21,28)];
	
	// Add Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53001 Id:999] autorelease] Position:CGPointMake(23,5)];
	
	[self setAiOfId:999 withType:AIType_StandBy];
	
	// Talk
	for (int i = 1; i <= 20; i++) {
		[self showTalkMessage:30 conversation:1 sequence:i];
	}
}

-(void) initialBattle_1
{
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53002 Id:201] autorelease] Position:CGPointMake(25,8)];
	
	[self showTalkMessage:30 conversation:1 sequence:21];
	[self showTalkMessage:30 conversation:1 sequence:22];
}

-(void) initialBattle_2
{
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53003 Id:202] autorelease] Position:CGPointMake(24,8)];
	
	[self showTalkMessage:30 conversation:1 sequence:23];
	[self showTalkMessage:30 conversation:1 sequence:24];
}

-(void) initialBattle_3
{
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53004 Id:203] autorelease] Position:CGPointMake(22,8)];
	
	[self showTalkMessage:30 conversation:1 sequence:25];
	[self showTalkMessage:30 conversation:1 sequence:26];
}

-(void) initialBattle_4
{
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53005 Id:204] autorelease] Position:CGPointMake(21,8)];
	
	[self showTalkMessage:30 conversation:1 sequence:27];
	[self showTalkMessage:30 conversation:1 sequence:28];
	
	// Add Enemy
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:101] autorelease] Position:CGPointMake(22,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:102] autorelease] Position:CGPointMake(21,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:103] autorelease] Position:CGPointMake(23,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:104] autorelease] Position:CGPointMake(20,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:105] autorelease] Position:CGPointMake(24,20)];
	
}

-(void) checkRound1 {
	[self checkRound:1];
}

-(void) checkRound2 {
	[self checkRound:2];
}

-(void) checkRound3 {
	[self checkRound:3];
}

-(void) checkRound4 {
	[self checkRound:4];
}

-(void) checkRound5 {
	
	if ([self currentRoundEnemyEliminated]) {
		
		FDCreature *boss = [field getCreatureById:999];
		[boss setPosition:CGPointMake(22,20)];
	}
}

-(void) checkRound:(int)num {

	foreach (FDCreature *enemy in [field getEnemyList]) {
		CGPoint pos = [field getObjectPos:enemy];
		if (pos.y > 15) {
			return;
		}
	}
	
	FDCreature *boss = [field getCreatureById:(200+num)];
	[boss setPosition:CGPointMake(22,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:(101+10*num)] autorelease] Position:CGPointMake(21,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:(102+10*num)] autorelease] Position:CGPointMake(23,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:(103+10*num)] autorelease] Position:CGPointMake(20,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:(104+10*num)] autorelease] Position:CGPointMake(24,20)];

}

-(void) bossDyingMessage
{
	[self showTalkMessage:30 conversation:2 sequence:1];
}

-(void) enemyClear
{
	for (int i = 2; i <= 26; i++) {
		[self showTalkMessage:30 conversation:2 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end
