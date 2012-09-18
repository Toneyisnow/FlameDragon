//
//  TitleScene.m
//  FlameDragon
//
//  Created by sui toney on 11-12-27.
//  Copyright 2011 ms. All rights reserved.
//

#import "TitleScene.h"
#import "MainGameScene.h"
#import "FDSpriteStore.h"
#import "FDWindow.h"
#import "TitleLayer.h"

@implementation TitleScene

-(id) init
{
	self = [super init];
	
	mainLayer = [TitleLayer node];
	mainLayer.isTouchEnabled = TRUE;
	//[self initLayer];
	
	[self addChild:mainLayer];
	
	return self;
}

@end
