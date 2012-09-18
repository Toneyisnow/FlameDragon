//
//  FDFriend.m
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDFriend.h"


@implementation FDFriend

-(id) initWithDefinition:(int)identity Id:(int)i
{
	return [self initWithDefinition:identity Id:i Data:nil];
}

-(id) initWithDefinition:(int)identity Id:(int)i Data:(CreatureData*)dat
{
	self = [super initWithDefinition:identity Id:i Data:dat];
	creatureType = CreatureType_Friend;
	return self;
}

-(id) initWithSavedState:(int)record
{
	self = [super init];
	return self;
}

-(void) preMove:(CGPoint)pos
{
	lastPosition = pos;
}

-(void) postMove:(CGPoint)pos
{
}

-(CGPoint) getLastPosition
{
	return lastPosition;
}

@end
