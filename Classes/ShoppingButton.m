//
//  ShoppingButton.m
//  FlameDragon
//
//  Created by sui toney on 12-5-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "ShoppingButton.h"


@implementation ShoppingButton

-(id) initWithSprite:(FDSprite *)img
{
	self = [super init];
	
	image = [img retain];
	
	cbObj = nil;
	cbMethod = nil;
	
	return self;	
}

-(id) initWithSprite:(FDSprite *)img Location:(CGPoint)loc
{
	self = [self initWithSprite:img];
	
	[self setLocation:loc];
	return self;
}

-(void) setLocation:(CGPoint)loc
{
	
	location = loc;
	[image setLocation:location];
	
}

-(void) setCallback:(id)obj Method:(SEL)m
{
	cbObj = obj;
	cbMethod = m;
}

-(FDSprite *) getSprite
{
	return image;
}

-(void) onClick
{
	if (cbObj != nil) {
		[cbObj performSelector:cbMethod];
	}
}

-(BOOL) isClicked:(CGPoint)loc
{
	return
	(loc.x > location.x - [image size].width/2) && (loc.x < location.x + [image size].width/2)
	&&  (loc.y > location.y - [image size].height/2) && (loc.y < location.y + [image size].height/2);
}

-(void) dealloc
{
	[image release];
	
	[super dealloc];
}

@end
