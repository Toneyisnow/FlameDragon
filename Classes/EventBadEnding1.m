//
//  EventBadEnding1.m
//  FlameDragon
//
//  Created by sui toney on 13-11-2.
//
//

#import "EventBadEnding1.h"
#import "FDDurationActivity.h"

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
    
    [self settleFriend:2  At:CGPointMake(16,10)];
	
	[self settleFriend:1  At:CGPointMake(16,12)];
	[self settleFriend:3  At:CGPointMake(17,12)];
	[self settleFriend:4  At:CGPointMake(18,12)];
	[self settleFriend:5  At:CGPointMake(15,12)];
	[self settleFriend:6  At:CGPointMake(14,12)];
	[self settleFriend:7  At:CGPointMake(16,13)];
	[self settleFriend:8  At:CGPointMake(17,13)];
	[self settleFriend:9  At:CGPointMake(18,13)];
	[self settleFriend:10 At:CGPointMake(15,13)];
	[self settleFriend:11 At:CGPointMake(14,13)];
	[self settleFriend:12 At:CGPointMake(16,14)];
	[self settleFriend:13 At:CGPointMake(17,14)];
    [self settleFriend:14 At:CGPointMake(18,14)];
	[self settleFriend:15 At:CGPointMake(15,14)];
	[self settleFriend:16 At:CGPointMake(14,14)];
    
    [layers appendToCurrentActivity:[[[FDDurationActivity alloc] initWithDuration:0.5] autorelease]];

    // Talk
	for (int i = 1; i <= 15; i++) {
		[self showTalkMessage:27 conversation:5 sequence:i];
	}
    
    [layers appendToCurrentActivityMethod:@selector(gameBadEnding) Param1:nil Param2:nil];
    
}

@end
