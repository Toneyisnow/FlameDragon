//
//  LoadingScene.m
//  FlameDragon
//
//  Created by sui toney on 12-10-2.
//  Copyright 2012 ms. All rights reserved.
//

#import "LoadingScene.h"


@implementation LoadingScene

-(id) init
{
	self = [super init];
	
	mainLayer = [LoadingLayer node];
	mainLayer.isTouchEnabled = TRUE;
	//[self initLayer];
	
	[self addChild:mainLayer];
	
	return self;
}


@end
