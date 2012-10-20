//
//  FDSlideAnimation.m
//  FlameDragon
//
//  Created by sui toney on 11-11-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDSlideAnimation.h"


@implementation FDSlideAnimation

-(id) initWithDefinition:(AnimationDefinition *)def Sprite:(FDSprite *)c
{
	return [super initWithDefinition:def Sprite:c];
}

-(void) takeTick:(int)synchronizeTick
{
	NSMutableArray *frameArray = [definition getFrameArray];
	
	if ([frameArray count] <= 0) {
		return;
	}
	
	if(currentFrameIndex >= [frameArray count])
	{
		if ([definition isRepeatable]) {
			currentFrameIndex = 0;
		}
		else {
			currentFrameIndex = [frameArray count] - 1;
			finished = TRUE;
			return;
		}
		
	}
	
	FDFrameDefinition *currentframe = [frameArray objectAtIndex:currentFrameIndex];
	if (currentTick == 0) {
		
		// Render the next frame
		[currentframe renderFrame:sprite];
		
		if (object != nil && [object respondsToSelector:callback]) {
			[object performSelector:callback withObject:currentframe withObject:[NSNumber numberWithInt:tagIndex]];
		}
	}
	
	currentTick ++;
	
	if (currentTick >= currentframe.tickCount) {
		currentFrameIndex ++;
		currentTick = 0;
	}
}

-(void) onRenderFrame:(SEL)method Id:(id)obj
{
	object = obj;
	callback = method;
}

-(void) reset
{
	currentTick = 0;
	currentFrameIndex = 0;
}


@end
