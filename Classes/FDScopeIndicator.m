//
//  FDScopeIndicator.m
//  FlameDragon
//
//  Created by sui toney on 11-11-8.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDScopeIndicator.h"
#import "FDSpriteStore.h"
#import "FDTransparencyFrameDefinition.h"
#import "FDSlideAnimation.h"

@implementation FDScopeIndicator

-(id) init 
{
	self = [super init];
	
	zOrder = BattleObjectOrder_Indicator;
	
	[self setSprite: [[FDSpriteStore instance] sprite:@"WhiteBlock.png"]];
	
	animationDef = [[AnimationDefinition alloc] init];
	
	int interval = 500;
	[animationDef addFrame:[[[FDTransparencyFrameDefinition alloc] initWithOpacity:40 Time:interval] autorelease]];
	[animationDef addFrame:[[[FDTransparencyFrameDefinition alloc] initWithOpacity:60 Time:interval] autorelease]];
	[animationDef addFrame:[[[FDTransparencyFrameDefinition alloc] initWithOpacity:80 Time:interval] autorelease]];
	[animationDef addFrame:[[[FDTransparencyFrameDefinition alloc] initWithOpacity:100 Time:interval] autorelease]];
	[animationDef addFrame:[[[FDTransparencyFrameDefinition alloc] initWithOpacity:120 Time:interval] autorelease]];
	[animationDef addFrame:[[[FDTransparencyFrameDefinition alloc] initWithOpacity:100 Time:interval] autorelease]];
	[animationDef addFrame:[[[FDTransparencyFrameDefinition alloc] initWithOpacity:80 Time:interval] autorelease]];
	[animationDef addFrame:[[[FDTransparencyFrameDefinition alloc] initWithOpacity:60 Time:interval] autorelease]];
	
	animation = [[FDSlideAnimation alloc] initWithDefinition:animationDef Sprite:sprite];
	return self;
}

-(void) takeTick:(int)synchronizedTick
{
	[animation takeTick:synchronizedTick];
}

-(void) dealloc
{
	[animation release];
	[animationDef release];
	
	[super dealloc];
}


@end
