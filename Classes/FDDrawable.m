//
//  FDDrawable.m
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDDrawable.h"


@implementation FDDrawable

-(id) initWithSprite:(FDSprite *)s
{
	self = [super init];
	
	sprite = [s retain];
	
	return self;
}

-(void) setSprite:(FDSprite *)sp
{
	if (sprite != nil) {
		[sprite release];
		sprite = nil;
	}
	
	sprite = [sp retain];
}

-(FDSprite *) getSprite
{
	return sprite;
}

-(void) dealloc
{
	[sprite release];
	[super dealloc];
}


@end
