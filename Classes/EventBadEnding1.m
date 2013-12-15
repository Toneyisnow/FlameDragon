//
//  EventBadEnding1.m
//  FlameDragon
//
//  Created by sui toney on 13-11-2.
//
//

#import "EventBadEnding1.h"

@implementation EventBadEnding1


-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
	
	CCLOG(@"BadEnding1 events loaded.");
    
}
-(void) initialBattle
{
	CCLOG(@"initialBattle event triggered.");
	
    /*
    for(FDCreature * c in [field getDeadCreatureList])
    {
        [[field getUnsettledCreatureList] addObject:c];
    }
    */
    
	[self settleFriend:1  At:CGPointMake(17,8)];
	[self settleFriend:3  At:CGPointMake(16,9)];
	[self settleFriend:4  At:CGPointMake(17,9)];
	[self settleFriend:5  At:CGPointMake(18,9)];
	[self settleFriend:6  At:CGPointMake(19,9)];
	[self settleFriend:7  At:CGPointMake(20,9)];
	[self settleFriend:8  At:CGPointMake(15,10)];
	[self settleFriend:9  At:CGPointMake(16,10)];
	[self settleFriend:10 At:CGPointMake(17,10)];
	[self settleFriend:11 At:CGPointMake(18,10)];
	[self settleFriend:12 At:CGPointMake(19,10)];
	[self settleFriend:12 At:CGPointMake(20,10)];
    [self settleFriend:13 At:CGPointMake(21,10)];
	[self settleFriend:14 At:CGPointMake(15,11)];
	[self settleFriend:15 At:CGPointMake(16,11)];
	[self settleFriend:16 At:CGPointMake(17,11)];
	[self settleFriend:17 At:CGPointMake(18,11)];
	[self settleFriend:18 At:CGPointMake(19,11)];
	[self settleFriend:19 At:CGPointMake(20,11)];
	[self settleFriend:20 At:CGPointMake(21,11)];
	[self settleFriend:21 At:CGPointMake(15,12)];
	[self settleFriend:22 At:CGPointMake(16,12)];
	[self settleFriend:23 At:CGPointMake(17,12)];
	[self settleFriend:24 At:CGPointMake(18,12)];
	[self settleFriend:25 At:CGPointMake(19,12)];
	[self settleFriend:26 At:CGPointMake(20,12)];
	[self settleFriend:27 At:CGPointMake(21,12)];
	[self settleFriend:28 At:CGPointMake(16,13)];
	[self settleFriend:29 At:CGPointMake(17,13)];
	[self settleFriend:30 At:CGPointMake(18,13)];
	[self settleFriend:31 At:CGPointMake(19,13)];
	[self settleFriend:26 At:CGPointMake(20,13)];
	
    
    // Talk
	for (int i = 1; i <= 15; i++) {
		[self showTalkMessage:27 conversation:5 sequence:i];
	}
    
    [layers appendToCurrentActivityMethod:@selector(gameGoodEnding) Param1:nil Param2:nil];
    
}

@end
