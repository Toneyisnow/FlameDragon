//
//  EventChapter11.m
//  FlameDragon
//
//  Created by sui toney on 13-1-23.
//  Copyright 2013 ms. All rights reserved.
//

#import "EventChapter11.h"


@implementation EventChapter11

-(void) loadEvents
{
    [self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
    
      [self loadDieEvent:1 Action:@selector(gameOver)];
        [self loadTeamEvent:CreatureType_Enemy Action:@selector(enemyClear)];
          
            NSLog(@"Chapter11 events loaded.");
}

-(void) initialBattle
{
    NSLog(@"initialBattle event triggered.");
      
        // Creatures
          [self settleFriend:1 At:CGPointMake(19, 11)];
            [self settleFriend:2 At:CGPointMake( 7, 13)];
              [self settleFriend:3 At:CGPointMake(22,  9)];
                [self settleFriend:4 At:CGPointMake(14,  8)];
                  [self settleFriend:5 At:CGPointMake(13, 11)];
                    [self settleFriend:6 At:CGPointMake( 8,  6)];
                      [self settleFriend:7 At:CGPointMake( 7, 10)];
                        [self settleFriend:8 At:CGPointMake( 9, 16)];
                          [self settleFriend:9 At:CGPointMake(17, 14)];
                            [self settleFriend:10 At:CGPointMake(24, 12)];
                              [self settleFriend:11 At:CGPointMake(28, 15)];
                                [self settleFriend:12 At:CGPointMake( 3, 11)];
                                  [self settleFriend:13 At:CGPointMake(26, 17)];
                                    
                                      // Add Enemies
                                        [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:101] autorelease] Position:CGPointMake(16,26)];
                                          [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:102] autorelease] Position:CGPointMake(23,26)];
                                            [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:103] autorelease] Position:CGPointMake(8 ,27)];
                                              [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:104] autorelease] Position:CGPointMake(6 ,28)];
                                                [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:105] autorelease] Position:CGPointMake(18,28)];
                                                  [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:106] autorelease] Position:CGPointMake(21,29)];
                                                    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:107] autorelease] Position:CGPointMake(12,30)];
                                                      [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:108] autorelease] Position:CGPointMake(29,31)];
                                                        [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:109] autorelease] Position:CGPointMake(5 ,32)];
                                                          [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:110] autorelease] Position:CGPointMake(1 ,34)];
                                                            [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:111] autorelease] Position:CGPointMake(23,34)];
                                                              [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:112] autorelease] Position:CGPointMake(31,35)];
                                                                [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:113] autorelease] Position:CGPointMake(5 ,37)];
                                                                  [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:114] autorelease] Position:CGPointMake(1 ,39)];
                                                                    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:115] autorelease] Position:CGPointMake(35,39)];
                                                                      [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:116] autorelease] Position:CGPointMake(16,41)];
                                                                        [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:117] autorelease] Position:CGPointMake(30,41)];
                                                                          [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:118] autorelease] Position:CGPointMake(10,42)];
                                                                            [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:119] autorelease] Position:CGPointMake(7 ,44)];
                                                                              [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51101 Id:120] autorelease] Position:CGPointMake(20,45)];
                                                                                
                                                                                  [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51102 Id:121] autorelease] Position:CGPointMake(30,28)];
                                                                                    [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51102 Id:122] autorelease] Position:CGPointMake(12,39)];
                                                                                      [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51102 Id:123] autorelease] Position:CGPointMake(32,37)];
                                                                                        [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51102 Id:124] autorelease] Position:CGPointMake(14,44)];
                                                                                          [field addEnemy:[[[FDEnemy alloc] initWithDefinition:51102 Id:125] autorelease] Position:CGPointMake(28,42)];
                                                                                            
                                                                                              // Add NPC
                                                                                                [field addNpc:[[[FDNpc alloc] initWithDefinition:901 Id:901] autorelease] Position:CGPointMake(25, 9)];
                                                                                                  
                                                                                                    // Talk
                                                                                                      [layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:1.0] autorelease]];
                                                                                                        for (int i = 1; i <= 12; i++) {
                                                                                                            	[self showTalkMessage:11 conversation:1 sequence:i];
                                                                                                        }
                                                                                                          
                                                                                                            [layers appendToCurrentActivityMethod:@selector(initialBattle_2) Param1:nil Param2:nil Obj:self];
}

-(void) initialBattle_2
{
    [field addFriend:[[[FDFriend alloc] initWithDefinition:14 Id:14] autorelease] Position:CGPointMake(18,1)];
      
        [field setCursorTo:CGPointMake(18,6)];
          [layers moveCreatureId:14 To:CGPointMake(18,6) showMenu:FALSE];
            
              for (int i = 13; i <= 25; i++) {
                  	[self showTalkMessage:11 conversation:1 sequence:i];
              }
}

-(void) enemyClear
{
    for (int i = 1; i <= 35; i++) {
        	[self showTalkMessage:10 conversation:4 sequence:i];
    }
      
        [layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];
}

@end

}
}
}
