//
//  FDSyncedAnimation.m
//  FlameDragon
//
//  Created by sui toney on 11-11-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDSyncedAnimation.h"

@implementation FDSyncedAnimation

-(id) initWithDefinition:(AnimationDefinition *)def Sprite:(FDSprite *)c
{
	return [super initWithDefinition:def Sprite:c];
}

-(void) takeTick:(int)synchronizeTick
{
	int tickIndex = synchronizeTick % totalTick;
	NSMutableArray *frameArray = [definition getFrameArray];
	for(FDFrameDefinition *currentframe in frameArray)
	{
		if (tickIndex < 0) {
			break;
		}
		if (tickIndex == 0) {
			[currentframe renderFrame:sprite];
		}
		
		tickIndex -= currentframe.tickCount;
	}
	
}

-(void) reset
{
	NSMutableArray *frameArray = [definition getFrameArray];
	
	if ([frameArray count] <= 0) {
		return;
	}
	
	totalTick = 0;
	for(FDFrameDefinition *currentframe in frameArray)
	{
		totalTick += currentframe.tickCount;
		
	}
}

@end
