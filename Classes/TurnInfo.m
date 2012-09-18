//
//  TurnInfo.m
//  FlameDragon
//
//  Created by sui toney on 11-12-7.
//  Copyright 2011 ms. All rights reserved.
//

#import "TurnInfo.h"
#import "MessageLayer.h"
#import "FDSpriteStore.h"
#import "Constants.h"

@implementation TurnInfo

-(id) initWithNo:(int)t
{
	self = [super init];
	
	turnNo = t;
	
	baseSprite = [[FDSpriteStore instance] sprite:@"TurnInfo.png"];
	[baseSprite retain];
	
	NSString *numberStr = [NSString stringWithFormat:@"%03d", turnNo];
	FDSprite *numberSprite = [[FDSprite alloc] initWithString:numberStr Size:10];
	[baseSprite addSprite:numberSprite zOrder:1];
	[numberSprite setLocation:CGPointMake([baseSprite size].width/2 + 15, [baseSprite size].height/2)];
	[numberSprite release];
	
	[baseSprite setScaleX:0.1 Y:0.1];
	
	stayTicks = 0;
	
	return self;
}

-(void) show:(CCLayer *)l
{
	layer = (MessageLayer *)l;
	
	[baseSprite setLocation:[layer getScreenCenterLoc]];
	
	[super show:layer];
}

-(void) close
{
	[super close];
	[layer clearMessage];
}

-(void) takeTick:(int)synchronizedTick
{
	CGPoint scale = [baseSprite getScale];
	CGPoint location = [baseSprite location];
	
	if (scale.x < [Constants battleMapScale])
	{
		[baseSprite setScaleX:scale.x + 0.06 Y:scale.y];
		return;
	}
	else if (scale.y < [Constants battleMapScale]) {
		[baseSprite setScaleX:[Constants battleMapScale] Y:scale.y + 0.06];
	}
	else if (stayTicks < 30) {
		stayTicks ++;
	}

	else if (location.y > 0) {
		[baseSprite setLocation:CGPointMake(location.x, location.y - 8)];
	}
	else {
		[self close];
	}
}


@end
