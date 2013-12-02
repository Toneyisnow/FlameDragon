//
//  EventChapter29.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter29.h"
#import "FDDurationActivity.h"
#import "ArrivePositionTurnCondition.h"

@implementation EventChapter29

-(void) loadEvents
{
    [self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
	[self loadTurnEvent:TurnType_Friend Turn:5 Action:@selector(round2)];
	[self loadTurnEvent:TurnType_Friend Turn:10 Action:@selector(round3)];
	[self loadTurnEvent:TurnType_Friend Turn:13 Action:@selector(round4)];

	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadDieEvent:2 Action:@selector(gameOver)];
	[self loadDyingEvent:2 Action:@selector(youniDead)];
    
	//int e1 = [self loadPositionEvent:2 AtPosition:CGPointMake(16,22) Action:@selector(onTriggerDragon)];
	[self loadPositionEvent:2 AtPosition:CGPointMake(16,22) Action:@selector(onTriggerDragon)];
    
    int e1 = [self loadPositionTurnEvent:2 AtPosition:CGPointMake(16,22) Action:@selector(onTriggerDragonTurn1)];
    int e2 = [self loadPositionTurnEvent:2 AtPosition:CGPointMake(16,22) Action:@selector(onTriggerDragonTurn2)];
    int e3 = [self loadPositionTurnEvent:2 AtPosition:CGPointMake(16,22) Action:@selector(onTriggerDragonTurn3)];
    int e4 = [self loadPositionTurnEvent:2 AtPosition:CGPointMake(16,22) Action:@selector(onTriggerDragonTurn4)];
    int e5 = [self loadPositionTurnEvent:2 AtPosition:CGPointMake(16,22) Action:@selector(dragonAppear)];
    

	int final = [self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
    [eventHandler setEvent:e2 dependentOn:e1];
    [eventHandler setEvent:e3 dependentOn:e2];
    [eventHandler setEvent:e4 dependentOn:e3];
    [eventHandler setEvent:e5 dependentOn:e4];
    [eventHandler setEvent:final dependentOn:e5];
    
	CCLOG(@"Chapter29 events loaded.");
}

-(void) initialBattle
{
	CCLOG(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(16,59)];
	[self settleFriend:2 At:CGPointMake(16,60)];
	[self settleFriend:3 At:CGPointMake(15,61)];
	[self settleFriend:4 At:CGPointMake(16,61)];
	[self settleFriend:5 At:CGPointMake(17,61)];
	[self settleFriend:6 At:CGPointMake(15,62)];
	[self settleFriend:7 At:CGPointMake(16,62)];
	[self settleFriend:8 At:CGPointMake(17,62)];
	[self settleFriend:9 At:CGPointMake(15,63)];
	[self settleFriend:10 At:CGPointMake(16,63)];
	[self settleFriend:11 At:CGPointMake(17,63)];
	[self settleFriend:12 At:CGPointMake(15,64)];
	[self settleFriend:13 At:CGPointMake(16,64)];
	[self settleFriend:14 At:CGPointMake(17,64)];
	[self settleFriend:15 At:CGPointMake(14,63)];
	[self settleFriend:16 At:CGPointMake(14,64)];
	[self settleFriend:17 At:CGPointMake(13,64)];
	[self settleFriend:18 At:CGPointMake(18,63)];
	[self settleFriend:19 At:CGPointMake(18,64)];
	[self settleFriend:20 At:CGPointMake(19,64)];

	
	// Add Enemies
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52905 Id:101] autorelease] Position:CGPointMake(16,39)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52905 Id:102] autorelease] Position:CGPointMake(2,38)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52905 Id:103] autorelease] Position:CGPointMake(30,39)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52905 Id:104] autorelease] Position:CGPointMake(4,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52905 Id:105] autorelease] Position:CGPointMake(30,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52905 Id:106] autorelease] Position:CGPointMake(16,24)];
	
	// Round 1
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:107] autorelease] Position:CGPointMake(2,57)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:108] autorelease] Position:CGPointMake(3,57)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:109] autorelease] Position:CGPointMake(2,58)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:110] autorelease] Position:CGPointMake(3,58)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:111] autorelease] Position:CGPointMake(29,57)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:112] autorelease] Position:CGPointMake(30,57)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:113] autorelease] Position:CGPointMake(29,58)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:114] autorelease] Position:CGPointMake(30,58)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:115] autorelease] Position:CGPointMake(15,50)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:116] autorelease] Position:CGPointMake(17,50)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:117] autorelease] Position:CGPointMake(14,49)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:118] autorelease] Position:CGPointMake(18,49)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52909 Id:119] autorelease] Position:CGPointMake(14,47)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52909 Id:120] autorelease] Position:CGPointMake(18,47)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:121] autorelease] Position:CGPointMake(2,54)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:122] autorelease] Position:CGPointMake(3,54)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:123] autorelease] Position:CGPointMake(29,54)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:124] autorelease] Position:CGPointMake(30,54)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:125] autorelease] Position:CGPointMake(14,51)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:126] autorelease] Position:CGPointMake(18,51)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:127] autorelease] Position:CGPointMake(16,48)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52910 Id:128] autorelease] Position:CGPointMake(15,46)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52910 Id:129] autorelease] Position:CGPointMake(17,46)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52906 Id:130] autorelease] Position:CGPointMake(16,45)];
	
	// Round 2
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:131] autorelease] Position:CGPointMake(15,41)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:132] autorelease] Position:CGPointMake(17,41)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:133] autorelease] Position:CGPointMake(15,38)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:134] autorelease] Position:CGPointMake(17,38)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:135] autorelease] Position:CGPointMake(15,35)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:136] autorelease] Position:CGPointMake(17,35)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:137] autorelease] Position:CGPointMake(13,44)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:138] autorelease] Position:CGPointMake(19,44)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:139] autorelease] Position:CGPointMake(10,39)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:140] autorelease] Position:CGPointMake(11,39)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:141] autorelease] Position:CGPointMake(12,39)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:142] autorelease] Position:CGPointMake(20,39)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:143] autorelease] Position:CGPointMake(21,39)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:144] autorelease] Position:CGPointMake(22,39)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52906 Id:145] autorelease] Position:CGPointMake(15,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52906 Id:146] autorelease] Position:CGPointMake(17,33)];
	
	// Round 3
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:147] autorelease] Position:CGPointMake(15,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:148] autorelease] Position:CGPointMake(17,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52909 Id:149] autorelease] Position:CGPointMake(14,27)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52909 Id:150] autorelease] Position:CGPointMake(18,27)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:151] autorelease] Position:CGPointMake(15,29)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:152] autorelease] Position:CGPointMake(17,29)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52906 Id:153] autorelease] Position:CGPointMake(16,28)];
	
	// Round 4
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:154] autorelease] Position:CGPointMake(15,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:155] autorelease] Position:CGPointMake(16,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:156] autorelease] Position:CGPointMake(17,25)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52909 Id:157] autorelease] Position:CGPointMake(14,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52909 Id:158] autorelease] Position:CGPointMake(18,21)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:159] autorelease] Position:CGPointMake(15,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:160] autorelease] Position:CGPointMake(17,24)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52910 Id:161] autorelease] Position:CGPointMake(14,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52910 Id:162] autorelease] Position:CGPointMake(18,23)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52906 Id:163] autorelease] Position:CGPointMake(16,22)];
	
	for (int i = 131; i <= 163; i++) {
		[self setAiOfId:i withType:AIType_StandBy];
	}
	
	// Talk
	for (int i = 1; i <= 14; i++) {
		[self showTalkMessage:29 conversation:1 sequence:i];
	}
}

-(void) round2
{
	for (int i = 131; i <= 146; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
}

-(void) round3
{
	for (int i = 147; i <= 153; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
}
-(void) round4
{
	for (int i = 154; i <= 163; i++) {
		[self setAiOfId:i withType:AIType_Aggressive];
	}
}

-(void) onTriggerDragon
{
	for (int i = 1; i <= 5; i++) {
		[self showTalkMessage:29 conversation:2 sequence:i];
	}
    
    [layers setExtraInfo:[layers getTurnNumber]];
}

-(void) onTriggerDragonTurn1
{
    FDCreature * youni = [field getCreatureById:2];
    [youni endTurn];
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:201] autorelease] Position:CGPointMake(15,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52907 Id:202] autorelease] Position:CGPointMake(17,33)];
}

-(void) onTriggerDragonTurn2
{
    FDCreature * youni = [field getCreatureById:2];
    [youni endTurn];
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52909 Id:203] autorelease] Position:CGPointMake(15,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52909 Id:204] autorelease] Position:CGPointMake(17,33)];
}

-(void) onTriggerDragonTurn3
{
    FDCreature * youni = [field getCreatureById:2];
    [youni endTurn];
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:205] autorelease] Position:CGPointMake(15,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52908 Id:206] autorelease] Position:CGPointMake(17,33)];
}

-(void) onTriggerDragonTurn4
{
    FDCreature * youni = [field getCreatureById:2];
    [youni endTurn];
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52906 Id:207] autorelease] Position:CGPointMake(15,33)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52906 Id:208] autorelease] Position:CGPointMake(17,33)];
}

-(void) dragonAppear
{
    CCLOG(@"dragonAppear Event.");

	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52902 Id:301] autorelease] Position:CGPointMake(14,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52903 Id:302] autorelease] Position:CGPointMake(18,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52904 Id:303] autorelease] Position:CGPointMake(16,13)];
	
	for (int i = 1; i <= 11; i++) {
		[self showTalkMessage:29 conversation:3 sequence:i];
	}
}

-(int) loadPositionTurnEvent:(int)creatureId AtPosition:(CGPoint)pos Action:(SEL)action
{
	ArrivePositionTurnCondition *condition = [[ArrivePositionTurnCondition alloc] initWithCreatureId:creatureId Position:pos];
	int eventId = [super loadSingleEvent:condition Action:action];
	[condition release];
	
	return eventId;
}

-(void) enemyClear
{
	[layers gameCleared];
    
    for (int i = 1; i <= 4; i++) {
		[self showTalkMessage:29 conversation:4 sequence:i];
	}
	
	FDEnemy *boss = [[FDEnemy alloc] initWithDefinition:52901 Id:999];
	[field addEnemy:boss Position:CGPointMake(16,1)];
	[layers moveCreature:boss To:CGPointMake(16,5) showMenu:FALSE];
	[boss release];
	
	[layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:0.5] autorelease]];

	for (int i = 5; i <= 29; i++) {
		[self showTalkMessage:29 conversation:4 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

-(void) youniDead
{
    [self showTalkMessage:29 conversation:5 sequence:1];
}


@end
