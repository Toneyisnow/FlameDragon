//
//  EventChapter30.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter30.h"
#import "EndTurnEventCondition.h"

@implementation EventChapter30

-(void) loadEvents
{
  [self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];

	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadDieEvent:2 Action:@selector(gameOver)];
    [self loadDyingEvent:2 Action:@selector(youniDead)];
    
    int e11 = [self loadDieEvent:101 Action:@selector(noAction)];
	int e12 = [self loadDieEvent:102 Action:@selector(noAction)];
	int e13 = [self loadDieEvent:103 Action:@selector(noAction)];
	int e14 = [self loadDieEvent:104 Action:@selector(noAction)];
	int e15 = [self loadDieEvent:105 Action:@selector(noAction)];
	int e16 = [self loadDieTurnEventAction:@selector(noAction)];
    int e17 = [self loadDieTurnEventAction:@selector(boss1Comingout)];
    [eventHandler setEvent:e16 dependentOn:e11];
    [eventHandler setEvent:e16 dependentOn:e12];
    [eventHandler setEvent:e16 dependentOn:e13];
    [eventHandler setEvent:e16 dependentOn:e14];
    [eventHandler setEvent:e16 dependentOn:e15];
    [eventHandler setEvent:e17 dependentOn:e16];
    
    int e21 = [self loadDieEvent:201 Action:@selector(noAction)];
	int e22 = [self loadDieEvent:111 Action:@selector(noAction)];
	int e23 = [self loadDieEvent:112 Action:@selector(noAction)];
	int e24 = [self loadDieEvent:113 Action:@selector(noAction)];
	int e25 = [self loadDieEvent:114 Action:@selector(noAction)];
	int e26 = [self loadDieTurnEventAction:@selector(noAction)];
    int e27 = [self loadDieTurnEventAction:@selector(boss2Comingout)];
    [eventHandler setEvent:e26 dependentOn:e21];
    [eventHandler setEvent:e26 dependentOn:e22];
    [eventHandler setEvent:e26 dependentOn:e23];
    [eventHandler setEvent:e26 dependentOn:e24];
    [eventHandler setEvent:e26 dependentOn:e25];
    [eventHandler setEvent:e27 dependentOn:e26];
    
    int e31 = [self loadDieEvent:202 Action:@selector(noAction)];
	int e32 = [self loadDieEvent:121 Action:@selector(noAction)];
	int e33 = [self loadDieEvent:122 Action:@selector(noAction)];
	int e34 = [self loadDieEvent:123 Action:@selector(noAction)];
	int e35 = [self loadDieEvent:124 Action:@selector(noAction)];
	int e36 = [self loadDieTurnEventAction:@selector(noAction)];
    int e37 = [self loadDieTurnEventAction:@selector(boss3Comingout)];
    [eventHandler setEvent:e36 dependentOn:e31];
    [eventHandler setEvent:e36 dependentOn:e32];
    [eventHandler setEvent:e36 dependentOn:e33];
    [eventHandler setEvent:e36 dependentOn:e34];
    [eventHandler setEvent:e36 dependentOn:e35];
    [eventHandler setEvent:e37 dependentOn:e36];
    
    int e41 = [self loadDieEvent:203 Action:@selector(noAction)];
	int e42 = [self loadDieEvent:131 Action:@selector(noAction)];
	int e43 = [self loadDieEvent:132 Action:@selector(noAction)];
	int e44 = [self loadDieEvent:133 Action:@selector(noAction)];
	int e45 = [self loadDieEvent:134 Action:@selector(noAction)];
	int e46 = [self loadDieTurnEventAction:@selector(noAction)];
    int e47 = [self loadDieTurnEventAction:@selector(boss4Comingout)];
    [eventHandler setEvent:e46 dependentOn:e41];
    [eventHandler setEvent:e46 dependentOn:e42];
    [eventHandler setEvent:e46 dependentOn:e43];
    [eventHandler setEvent:e46 dependentOn:e44];
    [eventHandler setEvent:e46 dependentOn:e45];
    [eventHandler setEvent:e47 dependentOn:e46];
    
    int e51 = [self loadDieEvent:204 Action:@selector(noAction)];
	int e52 = [self loadDieEvent:141 Action:@selector(noAction)];
	int e53 = [self loadDieEvent:142 Action:@selector(noAction)];
	int e54 = [self loadDieEvent:143 Action:@selector(noAction)];
	int e55 = [self loadDieEvent:144 Action:@selector(noAction)];
	int e56 = [self loadDieTurnEventAction:@selector(noAction)];
    int e57 = [self loadDieTurnEventAction:@selector(bossFinalComingout)];
    [eventHandler setEvent:e56 dependentOn:e51];
    [eventHandler setEvent:e56 dependentOn:e52];
    [eventHandler setEvent:e56 dependentOn:e53];
    [eventHandler setEvent:e56 dependentOn:e54];
    [eventHandler setEvent:e56 dependentOn:e55];
    [eventHandler setEvent:e57 dependentOn:e56];
    
	[self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	[self loadDyingEvent:999 Action:@selector(bossDyingMessage)];
	
	CCLOG(@"Chapter30 events loaded.");
}

-(void) initialBattle
{
	CCLOG(@"initialBattle event triggered.");
	
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
    
    
    [layers appendToCurrentActivityMethod:@selector(initialBattle_1) Param1:nil Param2:nil Obj:self];
}

-(void) initialBattle_1
{
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53002 Id:201] autorelease] Position:CGPointMake(25,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53003 Id:202] autorelease] Position:CGPointMake(24,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53004 Id:203] autorelease] Position:CGPointMake(22,8)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53005 Id:204] autorelease] Position:CGPointMake(21,8)];
	
    // Talk
	for (int i = 11; i <= 19; i++) {
		[self showTalkMessage:30 conversation:1 sequence:i];
	}
    
    [layers appendToCurrentActivityMethod:@selector(initialBattle_2) Param1:nil Param2:nil Obj:self];
}

-(void) initialBattle_2
{
    // Add Enemy
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:101] autorelease] Position:CGPointMake(23,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:102] autorelease] Position:CGPointMake(22,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:103] autorelease] Position:CGPointMake(24,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:104] autorelease] Position:CGPointMake(21,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:105] autorelease] Position:CGPointMake(25,20)];

}

-(void) boss1Comingout
{
    [self showTalkMessage:30 conversation:1 sequence:21];
	[self showTalkMessage:30 conversation:1 sequence:22];
    
    [layers appendToCurrentActivityMethod:@selector(bossComingout) Param1:[NSNumber numberWithInt:1] Param2:nil Obj:self];

}

-(void) boss2Comingout
{
    [self showTalkMessage:30 conversation:1 sequence:23];
	[self showTalkMessage:30 conversation:1 sequence:24];
    [layers appendToCurrentActivityMethod:@selector(bossComingout) Param1:[NSNumber numberWithInt:2] Param2:nil Obj:self];
}

-(void) boss3Comingout
{
    [self showTalkMessage:30 conversation:1 sequence:25];
	[self showTalkMessage:30 conversation:1 sequence:26];
    [layers appendToCurrentActivityMethod:@selector(bossComingout) Param1:[NSNumber numberWithInt:3] Param2:nil Obj:self];
}

-(void) boss4Comingout
{
    [self showTalkMessage:30 conversation:1 sequence:27];
	[self showTalkMessage:30 conversation:1 sequence:28];
    [layers appendToCurrentActivityMethod:@selector(bossComingout) Param1:[NSNumber numberWithInt:4] Param2:nil Obj:self];
}

-(void) bossFinalComingout
{
    FDCreature *boss = [field getCreatureById:999];
    [boss setLocation:[field convertPosToLoc:CGPointMake(23,20)]];
}

-(void) bossComingout:(NSNumber *)number
{
    int num = [number intValue];
    
    FDCreature *boss = [field getCreatureById:(200+num)];
	[boss setLocation:[field convertPosToLoc:CGPointMake(23,20)]];
    
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:(101+10*num)] autorelease] Position:CGPointMake(22,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:(102+10*num)] autorelease] Position:CGPointMake(24,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:(103+10*num)] autorelease] Position:CGPointMake(21,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:(104+10*num)] autorelease] Position:CGPointMake(25,20)];
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
	
	for (FDCreature *enemy in [field getEnemyList]) {
		CGPoint pos = [field getObjectPos:enemy];
		if (pos.y > 15) {
			return;
		}
	}
    
    FDCreature *boss = [field getCreatureById:999];
    [boss setLocation:CGPointMake(22,20)];
	
}

-(void) checkRound:(int)num {

	for (FDCreature *enemy in [field getEnemyList]) {
		CGPoint pos = [field getObjectPos:enemy];
		if (pos.y > 15) {
			return;
		}
	}
	
	FDCreature *boss = [field getCreatureById:(200+num)];
	[boss setLocation:[field convertPosToLoc:CGPointMake(23,20)]];
    
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:(101+10*num)] autorelease] Position:CGPointMake(22,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:(102+10*num)] autorelease] Position:CGPointMake(24,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:(103+10*num)] autorelease] Position:CGPointMake(21,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:53006 Id:(104+10*num)] autorelease] Position:CGPointMake(25,20)];

}

-(void) bossDyingMessage
{
	[self showTalkMessage:30 conversation:2 sequence:1];
}

-(void) youniDead
{
    [self showTalkMessage:30 conversation:3 sequence:1];
}

-(int) loadDieTurnEventAction:(SEL)action
{
	EndTurnEventCondition *condition = [[EndTurnEventCondition alloc] init];
	int eventId = [self loadSingleEvent:condition Action:action];
	[condition release];
	
	return eventId;
}

-(void) enemyClear
{
	for (int i = 2; i <= 26; i++) {
		[self showTalkMessage:30 conversation:2 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end
