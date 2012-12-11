//
//  EventHandler.m
//  FlameDragon
//
//  Created by sui toney on 11-12-11.
//  Copyright 2011 ms. All rights reserved.
//

#import "EventHandler.h"


@implementation EventHandler

-(id) initWithLayers:(ActionLayers *)l
{
	self = [super init];
	
	layers = l;
	events = [[NSMutableArray alloc] init];
	initialEvent = nil;
	eventIdIndex = 0;
	return self;
}


-(void) addEvent:(FDEvent *)event
{
	// Assign an Id for that event
	//event.eventId = ++eventIdIndex;
	
	[events addObject:event];
}

-(void) deactivateEvent:(int)eventId
{
	for (FDEvent *event in events) {
		if (event.eventId == eventId) {
			[event deactivate];
		}
	}
}

-(void) setEvent:(int)eventId dependentOn:(int)depId
{
	FDEvent *target = nil;
	FDEvent *dependent = nil;
	
	for (FDEvent *event in events) {
		if (event.eventId == eventId) {
			target = event;
		}
		if (event.eventId == depId) {
			dependent = event;
		}
	}
	
	if (target == nil || dependent == nil) {
		return;
	}
	
	[target setDependentEvent:dependent];
}

-(void) setInitialEvent:(FDEvent *)event
{
	initialEvent = event;
}

-(void) isNotified
{
	// check all events
	for (int i = [events count]-1; i >= 0;i--) {
		
		FDEvent *event = [events objectAtIndex:i];
		if ([event isTriggered:layers]) {
			
			NSLog(@"Event is triggered.");
			[event doAction];
			// [events removeObject:event];
		}
	}
}

-(NSMutableArray *) saveState
{
	NSMutableArray *result = [[NSMutableArray alloc] init];
	for (FDEvent *event in events) {
		if ([event isActiveEvent]) {
			[result addObject:[NSNumber numberWithInt:event.eventId]];
		}
	}
	
	return [result autorelease];
}

-(void) loadState:(NSMutableArray *)activeEventIds
{
	NSLog(@"Loading Active Events.");
	
	for (int i = [events count]-1; i >= 0;i--) {
		
		FDEvent *event = [events objectAtIndex:i];
		BOOL isActive = FALSE;
		for (NSNumber *activeId in activeEventIds) {
			if ([activeId intValue] == event.eventId) {
				isActive = TRUE;
				break;
			}
		}
		
		if (!isActive) {
			[event deactivate];
		}
	}	
}

-(void) dealloc
{
	[events release];
	[super dealloc];
}


@end
