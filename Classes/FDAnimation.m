//
//  FDAnimation.m
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDAnimation.h"
#import "Constants.h"

@implementation FDAnimation

-(id) init
{
	self = [super init];
	
	[self reset];
	
	return self;
}

-(id) initWithDefinition:(AnimationDefinition *)def Sprite:(FDSprite *)c
{
	if (def == nil) {
		return nil;
	}
	
	self = [super init];
	
	definition = [def retain];
	sprite = c;
	finished = FALSE;
	
	[self reset];
	
	return self;
}

-(id) initWithSprite:(FDSprite *)c
{
	self = [super init];
	
    definition = nil;
	sprite = c;
	finished = FALSE;
	
	[self reset];
	
	return self;
}

-(void) takeTick:(int)synchronizeTick
{
}


-(void) setTagIndex:(int)t
{
	tagIndex = t;
}

-(BOOL) hasFinished
{
	return finished;
}

-(int) getDuration
{
	return [definition getTickCount];
}

-(void) reset
{
    finished = NO;
}

-(void) dealloc
{
	if (definition != nil) {
        [definition release];
	}
        
	[super dealloc];
}


@end
