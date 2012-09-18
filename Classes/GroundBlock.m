//
//  GroundBlock.m
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "GroundBlock.h"


@implementation GroundBlock

-(id) init
{
	self = [super init];
	return self;
}

-(id) initWithType:(int)type AP:(int)ap DP:(int)dp
{
	self = [super init];
	
	accessType = type;
	attackPoint = ap;
	defencePoint = dp;
	
	return self;
}


+(id) blockWithType:(GroundBlockType) blockType
{
	switch (blockType) {
		case GroundBlockTypeGround:
			return [[[self alloc] initWithType:GroundBlockAccessTypeCanWalk AP:5 DP:0] autorelease];
			break;
		case GroundBlockTypeForest:
			return [[[self alloc] initWithType:GroundBlockAccessTypeCanWalk AP:-5 DP:10] autorelease];
			break;
		case GroundBlockTypeChasm:
			return [[[self alloc] initWithType:GroundBlockAccessTypeCanFly AP:0 DP:0] autorelease];
			break;
		case GroundBlockTypeGap:
			return [[[self alloc] initWithType:GroundBlockAccessTypeNone AP:0 DP:0] autorelease];
			break;
		default:
			break;
	}
	
	return nil;
}

-(GroundBlockAccessType) getAccessType
{
	return accessType;
}

-(int) attackPoint
{
	return attackPoint;
}

-(int) defencePoint
{
	return defencePoint;
}


@end
