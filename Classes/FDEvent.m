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
	
	dependentEvent = nil;
	isActivated = TRUE;
	
	return self;
}

-(BOOL) isTriggered:(ActionLayers *)layers
{
    return (dependentEvent == nil || ![dependentEvent isActiveEvent])
			&& isActivated
			&& [condition isMatch:layers];
}

-(void) doAction
{
	isActivated = FALSE;
	[object performSelector:method];
}

-(BOOL) isActiveEvent
{
	return isActivated;
}

-(void) deactivate
{
	isActivated = FALSE;
}

-(void) reactivate
{
	isActivated = TRUE;
}

-(void) setDependentEvent:(FDEvent *)event
{
	dependentEvent = event;
}

-(FDEvent *) getDependentEvent
{
    return dependentEvent;
}

-(void) dealloc
{
	[condition release];
	
	[super dealloc];
}

@end
