//
//  FDEvent.m
//  FlameDragon
//
//  Created by sui toney on 11-12-11.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDEvent.h"


@implementation FDEvent

@synthesize eventId;

-(id) initWithCondition:(FDEventCondition *)c Delegate:(id)o Method:(SEL)m
{
	self = [super init];
	
	condition = [c retain];
	object = o;
	method = m;
	
	return self;
}

-(BOOL) isTriggered:(ActionLayers *)layers
{
	return [condition isMatch:layers];
}

-(void) doAction
{
	[object performSelector:method];
}

-(void) dealloc
{
	[condition release];
	
	[super dealloc];
}

@end
