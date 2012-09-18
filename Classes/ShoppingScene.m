//
//  VillageScene.m
//  FlameDragon
//
//  Created by sui toney on 12-4-27.
//  Copyright 2012 ms. All rights reserved.
//

#import "ShoppingScene.h"


@implementation ShoppingScene

-(id) init
{
	self = [super init];
	
	mainLayer = [Shopping2Layer node];
	mainLayer.isTouchEnabled = TRUE;
	
	[self addChild:mainLayer];
	
	return self;
}

-(void) loadWithRecord:(ChapterRecord *) record Type:(Shopping2Type)type
{
	[mainLayer loadWithRecord:record Type:type];
	[self schedule: @selector(step:)];
}

-(void) step: (ccTime) delta
{
	//NSLog(@"step");
	[mainLayer takeTick];
}


@end
