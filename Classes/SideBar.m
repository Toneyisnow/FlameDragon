//
//  SideBar.m
//  FlameDragon
//
//  Created by sui toney on 11-12-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "SideBar.h"
#import "MessageLayer.h"
#import "FDSpriteStore.h"
#import "Constants.h"

@implementation SideBar

-(id) init
{
	self = [super init];
	
	baseSprite = [[FDSpriteStore instance] sprite:@"SideBar.png"];
	[baseSprite setScaleX:[Constants battleMapScale] Y:[Constants battleMapScale]];
	[baseSprite retain];
	
	return self;
}

-(void) show:(CCLayer *)layer
{
	
	[baseSprite setLocation:[self getPosRight]];
	[super show:layer];
}

-(CGPoint) getPosLeft
{
	return CGPointMake(10 + [baseSprite size].width/2, 10 + [baseSprite size].height/2);
}

-(CGPoint) getPosRight
{
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	
	CGPoint leftpos = [self getPosLeft];
	return CGPointMake(winSize.width - leftpos.x, leftpos.y);
}


@end
