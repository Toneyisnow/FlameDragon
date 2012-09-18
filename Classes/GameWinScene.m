//
//  GameWinScene.m
//  FlameDragon
//
//  Created by sui toney on 12-1-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "GameWinScene.h"


@implementation GameWinScene

-(id) init
{
	self = [super init];
	
	layer = [GameWinLayer node];
	layer.isTouchEnabled = TRUE;
	
	[self addChild:layer];

	return self;
}

@end
