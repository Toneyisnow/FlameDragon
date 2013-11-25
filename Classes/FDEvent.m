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
	
	dependentEvents = [[NSMutableArray alloc] init];
	isActivated = TRUE;
	
	return self;
}

-(BOOL) isTriggered:(ActionLayers *)layers
{
    BOOL dependencyDone = TRUE;
    for (FDEvent *event in dependentEvents) {
        if (event != nil && [event isActiveEvent]) {
            dependencyDone = FALSE;
            break;
        }
    }
    
    return dependencyDone
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
	[dependentEvents addObject:event];
}

/*
 -(FDEvent *) getDependentEvent
{
    return dependentEvent;
}
*/

-(void) dealloc
{
	[condition release];
	[dependentEvents release];
    
	[super dealloc];
}

@end
