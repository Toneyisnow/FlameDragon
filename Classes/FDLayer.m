//
//  FDLayer.m
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDLayer.h"

@implementation FDLayer

-(id) init
{
	self = [super init];
	
	winSize = [[CCDirector sharedDirector] winSize];
	screenCenterLocation = CGPointMake(winSize.width / 2, winSize.height / 2);
	upCenterLocation = CGPointMake(winSize.width / 2, winSize.height / 1.3);
	downCenterLocation = CGPointMake(winSize.width / 2, winSize.height / 4);
	
	return self;
}

-(void) updateScreen:(int)synchronizeTick
{
	// Update all the children on the layer
	if (message != nil) {
		[message takeTick:synchronizeTick];
	}
	
}


-(CGSize) getWinSize
{
	return winSize;
}

-(CGPoint) getScreenCenterLoc
{
	return screenCenterLocation;
}

-(CGPoint) getDownCenterLoc
{
	return downCenterLocation;
}

-(CGPoint) getUpCenterLoc
{
	return upCenterLocation;
}

-(CGPoint) getUpLeftLoc
{
	return CGPointMake(winSize.width / 4, winSize.height / 1.3);
}

-(CGPoint) getUpRightLoc
{
	return CGPointMake(winSize.width / 1.3, winSize.height / 1.3);
}

-(void) setMessageTo:(IMessage *)msg
{
	if (message != nil) {
		[self clearMessage];
	}
	message = [msg retain];
}

-(void) clearMessage
{
	[message release];
	message = nil;
}

-(IMessage *) getMessage
{
	return message;
}

@end
