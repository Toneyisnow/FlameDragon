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
	[self loadTurnEvent:TurnType_Friend Turn:0 Action:@selector(round1)];
	
	NSLog(@"GoodEnding1 events loaded.");
    
}

-(void) round1
{
	
}


@end
