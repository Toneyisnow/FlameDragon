//
//  FDDurationActivity.m
//  FlameDragon
//
//  Created by sui toney on 11-11-27.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDDurationActivity.h"
#import "Constants.h"

@implementation FDDurationActivity

-(id) initWithDuration:(float)sec
{
	self = [super init];
	
	duration = sec;
	
	return self;
}

-(void) initialize
{
	waitTick = 0;
}

-(void) mainTick:(int)synchronizeTick
{
	if (waitTick ++ > duration * [Constants FPS]) {
		hasFinished = TRUE;
	}
}

@end
