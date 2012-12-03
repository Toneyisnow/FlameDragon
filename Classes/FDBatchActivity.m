//
//  FDBatchActivity.m
//  FlameDragon
//
//  Created by sui toney on 11-11-27.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDBatchActivity.h"


@implementation FDBatchActivity


-(id) init
{
	self = [super init];
	
	activities = [[NSMutableArray alloc] init];
	
	return self;
}

-(void) addActivity:(FDActivity *)act
{
	[activities addObject:act];
}

-(void) initialize
{
	for (FDActivity *activity in activities) {
		[activity initialize];
	}
}

-(void) mainTick:(int)synchronizeTick
{
	BOOL allFinished = TRUE;
	for (FDActivity *activity in activities) {
		[activity mainTick:synchronizeTick];
		if (![activity hasFinished]) {
			allFinished = FALSE;
		}
	}
	
	if (allFinished) {
		hasFinished = TRUE;
	}
}

-(void) dealloc
{
	[activities release];
	
	
	[super dealloc];
}

@end
