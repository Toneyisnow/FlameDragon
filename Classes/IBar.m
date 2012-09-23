//
//  IBar.m
//  FlameDragon
//
//  Created by sui toney on 11-12-4.
//  Copyright 2011 ms. All rights reserved.
//

#import "IBar.h"
#import "Constants.h"

@implementation IBar


-(void) show:(CCLayer *)layer
{
	[baseSprite addToLayer:layer];
}

-(void) close
{
	[baseSprite removeFromLayer];
}

-(void) hide
{
	[baseSprite getSprite].visible = FALSE;
}

-(void) appear
{
	[baseSprite getSprite].visible = TRUE;
}


-(void) takeTick:(int)synchronizedTick
{
}

-(void) clickedOn:(CGPoint)location
{
}

-(void) setLocation:(CGPoint)location
{
	[baseSprite setLocation:location];
}

-(CGPoint) getInnerLocation:(CGPoint)loc
{
	float locX = (loc.x + [baseSprite size].width / 2 - [baseSprite location].x) / [baseSprite getScale].x;
	float locY = (loc.y + [baseSprite size].height / 2 - [baseSprite location].y) / [baseSprite getScale].y;
		
	return CGPointMake(locX, locY);	
}

-(BOOL) isClicked:(CGPoint)loc
{
	CGPoint location = [baseSprite location];
	
	return
	(loc.x > location.x - [baseSprite size].width/2) && (loc.x < location.x + [baseSprite size].width/2)
	&&  (loc.y > location.y - [baseSprite size].height/2) && (loc.y < location.y + [baseSprite size].height/2);
}

-(void) dealloc
{
	if (baseSprite != nil) {
		[baseSprite release];
	}
	[super dealloc];
}

@end
