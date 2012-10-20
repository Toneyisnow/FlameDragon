//
//  FDCombinedAnimation.m
//  FlameDragon
//
//  Created by sui toney on 11-11-27.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDCombinedAnimation.h"


@implementation FDCombinedAnimation


-(id) init
{
	self = [super init];
	
	animationList = [[NSMutableArray alloc] init];
	aniIndex = 0;
	
	return self;
}

-(void) addAnimation:(FDAnimation *)ani
{
	[animationList addObject:ani];
}

-(void) takeTick:(int)synchronizeTick
{
	
	if ([animationList count] <= 0) {
		return;
	}
	
	if(aniIndex >= [animationList count])
	{
		aniIndex = [animationList count] - 1;
		finished = TRUE;
		return;
	}
	
	FDAnimation *currentAni = [animationList objectAtIndex:aniIndex];
	
	[currentAni takeTick:synchronizeTick];
	
	if ([currentAni hasFinished]) {
		aniIndex ++;
	}

}

-(int) getDuration
{
	int total = 0;
	for (FDAnimation *ani in animationList) {
		total += [ani getDuration];
	}
	return total;
}

-(void) dealloc
{
	
	
	[super dealloc];
}


@end
