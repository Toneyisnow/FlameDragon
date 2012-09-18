//
//  GameOverLayer.m
//  FlameDragon
//
//  Created by sui toney on 12-1-13.
//  Copyright 2012 ms. All rights reserved.
//

#import "GameOverLayer.h"
#import "FDSpriteStore.h"
#import "FDWindow.h"

@implementation GameOverLayer

-(id) init
{
	self = [super init];
	
	image = [[FDSpriteStore instance] sprite:@"GameOver.png"];
	[image setLocation:[FDWindow screenCenter]];
	
	[self addChild:[image getSprite]];
	// [image addToLayer:self];
	[image retain];
	
	
	return self;
}

-(void) dealloc
{
	[image release];
	
	[super dealloc];
}


@end
