//
//  PickFriendScene.m
//  FlameDragon
//
//  Created by sui toney on 13-3-23.
//
//

#import "PickFriendScene.h"

@implementation PickFriendScene

@synthesize mainLayer;

-(id) init
{
	self = [super init];
	
	mainLayer = [PickFriendLayer node];
	mainLayer.isTouchEnabled = TRUE;
	
	[self addChild:mainLayer];
	
	return self;
}

-(void) loadWithRecord:(ChapterRecord *) record
{
	[mainLayer loadWithRecord:record];
}

@end
