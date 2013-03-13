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
        blockType = type;
	attackPoint = ap;
	defencePoint = dp;
	
	return self;
}


+(id) blockWithType:(GroundBlockType) blockType
{
	switch (blockType) {
		case GroundBlockTypeGround:
			return [[[self alloc] initWithType:GroundBlockTypeGround AP:5 DP:0] autorelease];
		case GroundBlockTypeForest:
			return [[[self alloc] initWithType:GroundBlockTypeForest AP:-5 DP:10] autorelease];
		case GroundBlockTypeChasm:
			return [[[self alloc] initWithType:GroundBlockTypeChasm AP:0 DP:0] autorelease];
		case GroundBlockTypeGap:
			return [[[self alloc] initWithType:GroundBlockTypeGap AP:0 DP:0] autorelease];
		case GroundBlockTypeMarsh:
			return [[[self alloc] initWithType:GroundBlockTypeMarsh AP:-5 DP:-5] autorelease];
		case GroundBlockTypeBlackForest:
			return [[[self alloc] initWithType:GroundBlockTypeBlackForest AP:-5 DP:-5] autorelease];
		default:
           		return [[[self alloc] initWithType:GroundBlockTypeGround AP:5 DP:0] autorelease];
	}
	
	return nil;
}

-(GroundBlockAccessType) getAccessType
{
	return accessType;
}

-(GroundBlockType) getBlockType
{
	return blockType;
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
