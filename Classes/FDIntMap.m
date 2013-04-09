//
//  FDIntMap.m
//  FlameDragon
//
//  Created by sui toney on 11-11-9.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDIntMap.h"


@implementation FDIntMap


-(id) initWidth:(int)w Height:(int)h
{
	self = [super init];
	
	width = w;
	height = h;
	map = (int *)malloc(sizeof(int) * w * h);
	//memset(map, 0, sizeof(map));
	
	for (int i = 0; i < width * height; i++) {
		map[i] = 0;
	}
	
	return self;
}

-(void) setX:(int)x Y:(int)y Value:(int)val
{
	if (x > width || x <= 0 || y > height || y <= 0) {
		return;
	}
	map[(x-1)*height+y-1] = val;
}

-(int) getX:(int)x Y:(int)y
{
	if (x > width || x <= 0 || y > height || y <= 0) {
		return 0;
	}
	return map[(x-1)*height+y-1];
}

-(int *) getMap {
    return map;
}

-(FDIntMap *) clone {
    
    FDIntMap *another = [[FDIntMap alloc] initWidth:width Height:height];
    
    memcpy([another getMap], map, width * height * sizeof(int));
    return [another autorelease];
}

-(void) dealloc
{
	free(map);
	[super dealloc];
}

@end
