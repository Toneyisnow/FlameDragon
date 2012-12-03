//
//  FDEvent.h
//  FlameDragon
//
//  Created by sui toney on 11-12-11.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDEventCondition.h"

@interface FDEvent : NSObject {

	int eventId;
	bool isActivated;
	
	FDEventCondition *condition;
	
	id object;
	SEL method;
	
	FDEvent *dependentEvent;
}

@property (assign) int eventId;

-(id) initWithCondition:(FDEventCondition *)c Delegate:(id)o Method:(SEL)m;

-(BOOL) isTriggered:(ActionLayers *)layers;

-(void) doAction;

-(void) deactivate;
-(BOOL) isActiveEvent;

-(void) setDependentEvent:(FDEvent *)event;

@end
