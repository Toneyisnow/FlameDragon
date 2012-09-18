//
//  FDPointMap.m
//  FlameDragon
//
//  Created by sui toney on 11-11-11.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDPointMap.h"


@implementation FDPointMap

-(id) initWidth:(int)w Height:(int)h
{
	self = [super init];
	
	width = w;
	height = h;
	map = (CGPoint *)malloc(sizeof(CGPoint) * w * h);
	
	for (int i = 0; i < width * height; i++) {
		map[i] = CGPointMake(0, 0);
	}
	
	return self;
}

-(void) setX:(int)x Y:(int)y Value:(CGPoint)val
{
	if (x > width || x <= 0 || y > height || y <= 0) {
		return;
	}
	map[(x-1)*height+y-1] = val;
}

-(CGPoint) getX:(int)x Y:(int)y
{
	if (x > width || x <= 0 || y > height || y <= 0) {
		return CGPointMake(0, 0);
	}
	return map[(x-1)*height+y-1];
}

-(void) dealloc
{
	free(map);
	[super dealloc];
}


@end
