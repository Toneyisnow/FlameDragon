//
//  ControlLayer.m
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//
#import "cocos2d.h"
#import "ControlLayer.h"


@implementation ControlLayer

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		self.isTouchEnabled = TRUE;
	}
	return self;
}

-(void) setDispatcher:(ActionDispatcher *)di
{
	dispatcher = [di retain];
}

- (void) ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	
	CCLOG(@"Clicked");
	
    UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView: [touch view]];
	clickCenter = [[CCDirector sharedDirector] convertToGL:location];
	
	originPos = [dispatcher getMapLocation];
	
	isTouchMoved = FALSE;
}

- (void) ccTouchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
	
	UITouch *touch = [touches anyObject];
	
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint nowPos = [[CCDirector sharedDirector] convertToGL:location];
	
	double locX = originPos.x + (nowPos.x - clickCenter.x);
	double locY = originPos.y + (nowPos.y - clickCenter.y);
	
	[dispatcher setMapLocation:CGPointMake(locX, locY)];
	
	//[[field getSprite] setLocation:CGPointMake(posX, posY)];
	
	isTouchMoved = TRUE;
	
}

- (void) ccTouchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
	
	if (isTouchMoved) {
		return;
	}
	
	UITouch *touch = [touches anyObject];
	
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
	
	[dispatcher clickedOn:convertedLocation];
}

-(void) dealloc
{
	[dispatcher release];
	
	[super dealloc];
}

@end
