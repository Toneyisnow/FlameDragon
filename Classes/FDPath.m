//
//  FDPath.m
//  FlameDragon
//
//  Created by sui toney on 11-11-7.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDPath.h"


@implementation FDPath

-(id) init
{
	self = [super init];
	
	pointList = [[NSMutableArray alloc] init];
	
	return self;
}

-(id) initWithPos1:(CGPoint)pos1 Pos2:(CGPoint)pos2
{
	self = [super init];
	
	pointList = [[NSMutableArray alloc] init];
	
	//[pointList addObject:pos1];
	//[pointList addObject:pos2];
	
	position1 = pos1;
	position2 = pos2;
	
	return self;
}

+(id) pathWithPos1:(CGPoint)pos1 Pos2:(CGPoint)pos2
{
	return [[[self alloc] initWithPos1:pos1 Pos2:pos2] autorelease];
}


-(CGPoint) getPos:(int)i
{
	/*
	if (i == 1) {
		return position1;
	}
	if (i == 2) {
		return position2;
	}
	
	return position1;
	*/
	
	
	FDPosition *pos = [pointList objectAtIndex:i];
	
	return [pos posValue];
}


-(CGPoint) getTargetPos
{
	return [self getPos:([pointList count]-1)];
}

-(void) addPoint:(CGPoint)pos
{
	[self addPos:[FDPosition positionX:pos.x Y:pos.y]];
}

-(void) addPos:(FDPosition *)pos
{
	[pointList addObject:pos];
}

-(int) getPosCount
{
	return [pointList count];
}

-(FDPath *) fillPathWithAllPoints
{
	// For a given path, return the path that contains all of the points on the path
	FDPath *newPath = [[FDPath alloc] init];
	
	if ([pointList count] == 0) {
		return [newPath autorelease];
	}
	
	FDPosition *current = [pointList objectAtIndex:0];
	//[newPath addPos:current];
	for (int i = 1; i < [pointList count]; i++) {
		FDPosition *pos = [pointList objectAtIndex:i];
		
		while (![pos isEqualToPos:current]) {
			
			[newPath addPos:current];
			
			current = [FDPosition positionX:[current x] Y:[current y]];
			if ([current x] < [pos x]) {
				[current updateX:1];
			}
			if ([current x] > [pos x]) {
				[current updateX:-1];
			}
			if ([current y] < [pos y]) {
				[current updateY:1];
			}
			if ([current y] > [pos y]) {
				[current updateY:-1];
			}
		}
					   
		[newPath addPos:current];
	}
	
	return [newPath autorelease];
}

-(void) dealloc
{
	[pointList release];
	
	[super dealloc];
}

@end
