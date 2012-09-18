//
//  ControlLayer.h
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "ActionDispatcher.h"

@interface ControlLayer : CCLayer {

	ActionDispatcher *dispatcher;
	CGPoint originPos;
	CGPoint clickCenter;

	BOOL isTouchMoved;
	
	int controllerType;		// 0: touch control  1: trandition control
}

-(void) setDispatcher:(ActionDispatcher *)di;

@end
