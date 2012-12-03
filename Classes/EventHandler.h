//
//  EventHandler.h
//  FlameDragon
//
//  Created by sui toney on 11-12-11.
//  Copyright 2011 ms. All rights reserved.
//

#import "IListener.h"
#import "FDEvent.h"
#import "ActionLayers.h"

@interface EventHandler : IListener {

	int eventIdIndex;
	NSMutableArray *events;
	ActionLayers *layers;
	
	FDEvent *initialEvent;
}

-(id) initWithLayers:(ActionLayers *)l;

-(void) addEvent:(FDEvent *)event;

-(void) deactivateEvent:(int)eventId;

-(void) setInitialEvent:(FDEvent *)event;

-(void) setEvent:(int)eventId dependentTo:(int)depId;

										   
//-(void) doInitialEvent;

-(NSMutableArray *) saveState;
-(void) loadState:(NSMutableArray *)activeEventIds;

@end
