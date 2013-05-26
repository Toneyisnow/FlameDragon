//
//  FDFreezeAnimation.m
//  FlameDragon
//
//  Created by sui toney on 12-10-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "FDFreezeAnimation.h"


@implementation FDFreezeAnimation

-(id) initWithTickCount:(int)t Sprite:(FDSprite *)c
{
	self = [super initWithSprite:c];
	
	freezeTick = t;
	currentTick = 0;
    
	return self;
}

-(void) takeTick:(int)synchronizeTick
{
	currentTick ++;
	
	if (currentTick >= freezeTick) {
		finished = TRUE;
		return;
	}
	
	return;
}


-(void) reset
{
	currentTick = 0;
}

@end
