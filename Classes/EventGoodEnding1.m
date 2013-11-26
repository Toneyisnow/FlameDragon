//
//  EventGoodEnding1.m
//  FlameDragon
//
//  Created by sui toney on 13-11-2.
//
//

#import "EventGoodEnding1.h"

@implementation EventGoodEnding1

-(void) loadEvents
{
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(initialBattle)];
	
	CCLOG(@"GoodEnding1 events loaded.");
    
}
-(void) initialBattle
{
	CCLOG(@"initialBattle event triggered.");
	
	// Creatures
	[self settleFriend:1 At:CGPointMake(16,59)];
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

    // Talk
	for (int i = 1; i <= 20; i++) {
		[self showTalkMessage:31 conversation:1 sequence:i];
	}
    
    [layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];

}



@end
