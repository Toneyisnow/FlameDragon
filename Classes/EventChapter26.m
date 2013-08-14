
//
//  EventChapter26.m
//  FlameDragon
//
//  Created by sui toney on 13-4-11.
//
//

#import "EventChapter26.h"

@implementation EventChapter26

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
    [self loadTurnEvent:TurnType_Friend Turn:2 Action:@selector(turn2)];
    [self loadTurnEvent:TurnType_Friend Turn:4 Action:@selector(turn4)];
    [self loadTurnEvent:TurnType_Friend Turn:6 Action:@selector(turn6)];
    [self loadTurnEvent:TurnType_Friend Turn:8 Action:@selector(turn8)];
    [self loadTurnEvent:TurnType_Friend Turn:10 Action:@selector(turn10)];
    [self loadTurnEvent:TurnType_Friend Turn:12 Action:@selector(turn12)];
    [self loadTurnEvent:TurnType_Friend Turn:15 Action:@selector(turn15)];
    [self loadTurnEvent:TurnType_Friend Turn:16 Action:@selector(turn16)];
    [self loadTurnEvent:TurnType_Friend Turn:17 Action:@selector(turn17)];
    [self loadTurnEvent:TurnType_Friend Turn:19 Action:@selector(turn19)];
    
	[self loadDieEvent:1 Action:@selector(gameOver)];
	[self loadDieEvent:2 Action:@selector(gameOver)];
	[self loadDieEvent:31 Action:@selector(gameOver)];
	[self loadDyingEvent:139 Action:@selector(bossDead)];
	
    eventWode = [self loadPositionEvent:0 AtPosition:CGPointMake(2,47) Action:@selector(onWode)];
	
    [self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
	
	NSLog(@"Chapter26 events loaded.");
}

-(void) initialBattle
{
	NSLog(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(16,45)];
	[self settleFriend:2 At:CGPointMake(15,45)];
	[self settleFriend:3 At:CGPointMake(17,45)];
	[self settleFriend:4 At:CGPointMake(14,45)];
	[self settleFriend:5 At:CGPointMake(18,45)];
	[self settleFriend:6 At:CGPointMake(16,46)];
	[self settleFriend:7 At:CGPointMake(15,46)];
	[self settleFriend:8 At:CGPointMake(17,46)];
	[self settleFriend:9 At:CGPointMake(14,46)];
	[self settleFriend:10 At:CGPointMake(18,46)];
	[self settleFriend:11 At:CGPointMake(16,47)];
	[self settleFriend:12 At:CGPointMake(15,47)];
	[self settleFriend:13 At:CGPointMake(17,47)];
	[self settleFriend:14 At:CGPointMake(14,47)];
	[self settleFriend:15 At:CGPointMake(18,47)];
	[self settleFriend:16 At:CGPointMake(19,47)];
	
	// Add Enemies Batch 1
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52602 Id:101] autorelease] Position:CGPointMake(16,26)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52605 Id:102] autorelease] Position:CGPointMake(14,44)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52605 Id:103] autorelease] Position:CGPointMake(18,44)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52605 Id:104] autorelease] Position:CGPointMake(16,32)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52605 Id:105] autorelease] Position:CGPointMake(15,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52605 Id:106] autorelease] Position:CGPointMake(17,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52605 Id:107] autorelease] Position:CGPointMake(7,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52605 Id:108] autorelease] Position:CGPointMake(25,31)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52605 Id:109] autorelease] Position:CGPointMake(8,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52605 Id:110] autorelease] Position:CGPointMake(24,30)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52605 Id:111] autorelease] Position:CGPointMake(1,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52605 Id:112] autorelease] Position:CGPointMake(31,34)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52611 Id:113] autorelease] Position:CGPointMake(9,36)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52611 Id:114] autorelease] Position:CGPointMake(8,35)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52611 Id:115] autorelease] Position:CGPointMake(10,35)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52611 Id:116] autorelease] Position:CGPointMake(9,34)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52611 Id:117] autorelease] Position:CGPointMake(23,37)];
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52611 Id:118] autorelease] Position:CGPointMake(22,36)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52611 Id:119] autorelease] Position:CGPointMake(24,36)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52611 Id:120] autorelease] Position:CGPointMake(23,35)];
	
    // Add enemy Batch 2
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52602 Id:121] autorelease] Position:CGPointMake(11,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52602 Id:122] autorelease] Position:CGPointMake(21,13)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52602 Id:123] autorelease] Position:CGPointMake(1,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52602 Id:124] autorelease] Position:CGPointMake(31,20)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52605 Id:125] autorelease] Position:CGPointMake(22,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52605 Id:126] autorelease] Position:CGPointMake(24,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52605 Id:127] autorelease] Position:CGPointMake(10,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52605 Id:128] autorelease] Position:CGPointMake(8,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52610 Id:129] autorelease] Position:CGPointMake(3,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52610 Id:130] autorelease] Position:CGPointMake(4,18)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52610 Id:131] autorelease] Position:CGPointMake(2,18)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52610 Id:132] autorelease] Position:CGPointMake(3,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52610 Id:133] autorelease] Position:CGPointMake(29,19)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52610 Id:134] autorelease] Position:CGPointMake(28,18)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52610 Id:135] autorelease] Position:CGPointMake(30,18)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52610 Id:136] autorelease] Position:CGPointMake(29,17)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52609 Id:137] autorelease] Position:CGPointMake(30,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52609 Id:138] autorelease] Position:CGPointMake(2,10)];

    // Add enemy batch 3
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52601 Id:139] autorelease] Position:CGPointMake(16,11)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52608 Id:140] autorelease] Position:CGPointMake(15,10)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52608 Id:141] autorelease] Position:CGPointMake(17,10)];
	
    for (int i = 121; i <= 141; i++) {
        [self setAiOfId:i withType:AIType_Guard];
    }
    
	// Talk
	for (int i = 1; i <= 9; i++) {
		[self showTalkMessage:26 conversation:1 sequence:i];
	}
}

-(void) turn2 {
    
    if ([field getCreatureById:139] == nil) {
        return;
    }
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52605 Id:201] autorelease] Position:CGPointMake(16,3)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52605 Id:202] autorelease] Position:CGPointMake(15,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52605 Id:203] autorelease] Position:CGPointMake(17,2)];
}

-(void) turn4 {
    
    if ([field getCreatureById:139] == nil) {
        return;
    }
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52606 Id:204] autorelease] Position:CGPointMake(16,3)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52607 Id:205] autorelease] Position:CGPointMake(15,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52607 Id:206] autorelease] Position:CGPointMake(17,2)];
}

-(void) turn6 {
    
    if ([field getCreatureById:139] == nil) {
        return;
    }
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52603 Id:207] autorelease] Position:CGPointMake(16,3)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52604 Id:208] autorelease] Position:CGPointMake(15,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52604 Id:209] autorelease] Position:CGPointMake(17,2)];
}

-(void) turn8 {
    
    if ([field getCreatureById:139] == nil) {
        return;
    }
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52610 Id:210] autorelease] Position:CGPointMake(16,3)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52610 Id:211] autorelease] Position:CGPointMake(15,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52610 Id:212] autorelease] Position:CGPointMake(17,2)];
}

-(void) turn10 {
    
    if ([field getCreatureById:139] == nil) {
        return;
    }
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52603 Id:213] autorelease] Position:CGPointMake(16,3)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52604 Id:214] autorelease] Position:CGPointMake(15,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52604 Id:215] autorelease] Position:CGPointMake(17,2)];
    
    for (int i = 121; i <= 138; i++) {
        [self setAiOfId:i withType:AIType_Aggressive];
    }
}

-(void) turn12 {
    
    if ([field getCreatureById:139] == nil) {
        return;
    }
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52610 Id:216] autorelease] Position:CGPointMake(16,3)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52610 Id:217] autorelease] Position:CGPointMake(15,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52610 Id:218] autorelease] Position:CGPointMake(17,2)];
}

-(void) turn15 {
    
    if ([field getCreatureById:139] == nil) {
        return;
    }
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52603 Id:219] autorelease] Position:CGPointMake(16,3)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52604 Id:220] autorelease] Position:CGPointMake(15,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52604 Id:221] autorelease] Position:CGPointMake(17,2)];
}

-(void) turn16 {
    
    if ([field getCreatureById:139] == nil) {
        return;
    }
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52610 Id:222] autorelease] Position:CGPointMake(16,3)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52610 Id:223] autorelease] Position:CGPointMake(15,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52610 Id:224] autorelease] Position:CGPointMake(17,2)];
}

-(void) turn17 {
    
    if ([field getCreatureById:139] == nil) {
        return;
    }
    
    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:52603 Id:225] autorelease] Position:CGPointMake(16,3)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52603 Id:226] autorelease] Position:CGPointMake(15,2)];
	[field addEnemy:[[[FDEnemy alloc] initWithDefinition:52603 Id:227] autorelease] Position:CGPointMake(17,2)];
}

-(void) turn19
{    
    if ([field getCreatureById:139] == nil) {
        return;
    }
    
    for (int i = 139; i <= 141; i++) {
        [self setAiOfId:i withType:AIType_Aggressive];
    }
}

-(void) onWode
{
    FDCreature *creature = [field getCreatureByPos:CGPointMake(2, 47)];
    
    if (creature == nil) {
        return;
    }
    
    if ([creature getIdentifier] == 2 && [creature.data hasItem:813]) {
        
        // Pick Wode
        [creature.data removeItem:813];
        [field addFriend:[[[FDFriend alloc] initWithDefinition:32 Id:32] autorelease] Position:CGPointMake(2,46)];
        
        for (int i = 10; i <= 20; i++) {
            [self showTalkMessage:26 conversation:1 sequence:i];
        }
    }
    else
    {
        NSString *talkMessage = [FDLocalString chapter:26 conversation:2 sequence:1];
        [self showTalkMessage:talkMessage creature:[creature getIdentifier]];
        
        if (eventWode != nil) {
            [eventWode reactivate];
        }
    }
}

-(void) bossDead
{
    [self showTalkMessage:26 conversation:3 sequence:1];
}

-(void) enemyClear
{
    [layers gameCleared];
    
    // If got Wode
    if ([field getCreatureById:32] != nil || [field getDeadCreatureById:32] != nil) {
        for (int i = 2; i <= 24; i++) {
            [self showTalkMessage:26 conversation:4 sequence:i];
        }
    }
    else
    {
        for (int i = 1; i <= 8; i++) {
            [self showTalkMessage:26 conversation:5 sequence:i];
        }
    }
    
    for (int i = 1; i <= 10; i++) {
		[self showTalkMessage:26 conversation:6 sequence:i];
	}
	
	[layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end
