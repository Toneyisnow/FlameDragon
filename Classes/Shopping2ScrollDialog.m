//
//  Shopping2ScrollDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-16.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2ScrollDialog.h"
#import "Shopping2Layer.h"

@implementation Shopping2ScrollDialog


-(void) show:(CCLayer *)layer
{
	[super show:layer];
	[(Shopping2Layer *)parentLayer setScrollEnabled:TRUE];
}

-(void) onExit:(id)returnedObject
{
	[(Shopping2Layer *)parentLayer setScrollEnabled:FALSE];
	[super onExit:returnedObject];
}

@end
