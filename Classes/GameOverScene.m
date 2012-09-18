//
//  GameOverScene.m
//  FlameDragon
//
//  Created by sui toney on 12-1-13.
//  Copyright 2012 ms. All rights reserved.
//

#import "GameOverScene.h"
#import "TitleScene.h"
#import "FDSpriteStore.h"
#import "FDWindow.h"
#import "Constants.h"
#import "GameOverLayer.h"

@implementation GameOverScene

-(id) init
{
	self = [super init];
	
	GameOverLayer *layer = [GameOverLayer node];
	[self addChild:layer];
	
	[self schedule: @selector(step:)];
	tickCount = 0;	
	
	return self;
}

-(void) step: (ccTime) delta
{
	tickCount ++;
	if (tickCount >= [Constants FPS] * 3) {
		[self closeScene];
	}
	
}

-(void) closeScene
{
	CCScene *scene = [TitleScene node];
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.5 scene:scene]];	
}

@end
