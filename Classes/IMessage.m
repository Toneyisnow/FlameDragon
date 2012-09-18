//
//  IMessage.m
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "IMessage.h"
#import "MessageLayer.h"
#import "FDLayer.h"

@implementation IMessage

-(void) show:(CCLayer *)l
{
	layer = (FDLayer *)l;
	[baseSprite setLocation:[layer getScreenCenterLoc]];
	[baseSprite addToLayer:layer];
	
	[layer setMessageTo:self];
}


-(void) setCallback:(id)o Method:(SEL)m
{
	object = [o retain];
	method = m;
}


-(void) close
{
	[baseSprite removeFromLayer];
	[layer clearMessage];
	
	if (object != nil && method != nil) {
		[object performSelector:method withObject:returnValue];
	}
		
	
	
}

@end
