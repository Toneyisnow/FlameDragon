//
//  VillageScene.m
//  FlameDragon
//
//  Created by sui toney on 12-4-27.
//  Copyright 2012 ms. All rights reserved.
//

#import "VillageScene.h"


@implementation VillageScene

@synthesize mainLayer;

-(id) init
{
	self = [super init];
	
	mainLayer = [VillageLayer node];
	mainLayer.isTouchEnabled = TRUE;
	//[self initLayer];
	
	[self addChild:mainLayer];
	
	return self;
}

-(void) setChapter:(int)chapter
{
	[mainLayer setChapter:chapter];	
}

-(void) loadWithRecord:(ChapterRecord *) record
{
	[mainLayer loadWithRecord:record];
	[self schedule: @selector(step:)];
}

-(void) step: (ccTime) delta
{
	//NSLog(@"step");
	[mainLayer takeTick];
}


@end
