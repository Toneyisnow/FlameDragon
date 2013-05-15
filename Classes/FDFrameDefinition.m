//
//  FDFrame.m
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDFrameDefinition.h"
#import "Constants.h"

@implementation FDFrameDefinition

@synthesize tickCount;

-(id) initWithTime:(int) t
{
	self = [super init];
	
	if (t <= 0)
	{
		CCLOG(@"Cannot init FDFrameDefinition: Time should be greater than 0.");
	}
	
	tickCount = t / [Constants tickLength];
	return self;
}

-(void) renderFrame:(FDSprite *)sprite
{
	return;
}

@end
