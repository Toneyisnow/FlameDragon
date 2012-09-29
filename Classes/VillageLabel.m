//
//  VillageLabel.m
//  FlameDragon
//
//  Created by sui toney on 12-9-29.
//  Copyright 2012 ms. All rights reserved.
//

#import "VillageLabel.h"
#import "FDSpriteStore.h"
#import "FDLocalString.h"

@implementation VillageLabel

-(id) init
{
	self = [super init];
	
	baseSprite = [[FDSpriteStore instance] sprite:@"VillageLabel.png"];
	[baseSprite setScaleX:1.5 Y:1.5];
	[baseSprite retain];
	
	labelSprite = nil;
	
	return self;
}


-(void) setPositionIndex:(int)posIndex
{
	if (labelSprite != nil) {
		[labelSprite removeFromLayer];
		labelSprite = nil;
	}
	
	NSString *label = [FDLocalString villagePositionName:posIndex];
	labelSprite = [[FDSprite alloc] initWithString:label Size:18];
	
	[baseSprite addSprite:labelSprite zOrder:1];
	[labelSprite setLocation:CGPointMake(30, 10)];
}

-(void) dealloc
{
	if (labelSprite != nil) {
		[labelSprite removeFromLayer];
		labelSprite = nil;
	}
	
	[super dealloc];
}

@end
