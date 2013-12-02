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
	
    for(FDCreature * c in [field getDeadCreatureList])
    {
        [[field getUnsettledCreatureList] addObject:c];
    }
    
    
    for(FDCreature * c in [field getUnsettledCreatureList])
    {
        c.data.hpCurrent = c.data.hpMax;
    }
    
	// Creatures
    
	//[self settleFriend:1 At:CGPointMake(2,2)];
	[self settleFriend:3 At:CGPointMake(2,3)];
	[self settleFriend:4 At:CGPointMake(2,4)];
	[self settleFriend:5 At:CGPointMake(5,8)];
	[self settleFriend:6 At:CGPointMake(5,19)];
	[self settleFriend:7 At:CGPointMake(6,5)];
	[self settleFriend:8 At:CGPointMake(6,6)];
	[self settleFriend:9 At:CGPointMake(6,7)];
	[self settleFriend:10 At:CGPointMake(6,8)];
	[self settleFriend:11 At:CGPointMake(6,9)];
	[self settleFriend:12 At:CGPointMake(7,5)];
	[self settleFriend:13 At:CGPointMake(7,6)];
	[self settleFriend:14 At:CGPointMake(7,7)];
	[self settleFriend:15 At:CGPointMake(7,8)];
	[self settleFriend:16 At:CGPointMake(7,9)];
	[self settleFriend:17 At:CGPointMake(8,5)];
	[self settleFriend:18 At:CGPointMake(8,6)];
	[self settleFriend:19 At:CGPointMake(8,7)];
	[self settleFriend:20 At:CGPointMake(8,8)];

    // Talk
	for (int i = 1; i <= 16; i++) {
		[self showTalkMessage:31 conversation:1 sequence:i];
	}
    
    [layers appendToCurrentActivityMethod:@selector(gameWin) Param1:nil Param2:nil];

}



@end
