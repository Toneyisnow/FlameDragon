//
//  DispatcherState.h
//  FlameDragon
//
//  Created by sui toney on 11-11-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "IField.h"
#import "IFieldActionable.h"
#import "ActionLayers.h"

@interface DispatcherState : NSObject {
	
	ActionLayers *layers;
	id<IField, IFieldActionable> field;
	
	
	BOOL shouldDispose;
	BOOL isFinished;

	DispatcherState *nextState;
}

-(id) initWithLayers:(ActionLayers *)ls;

//-(id) initWithField:(id<IField,IFieldActionable>) fi;

-(void) clickedOn:(CGPoint)location;
-(void) pressLeft;
-(void) pressRight;
-(void) pressUp;
-(void) pressDown;
-(void) pressOk;
-(void) pressCancel;

-(BOOL) shouldDispose;
-(DispatcherState *) getNextState;
-(void) clearNextState;

-(void) preSetMapLocation:(CGPoint)loc;
-(BOOL) allowMoveScreen;

-(id) returnedValue;
-(void) consume:(id)value;

-(void) resumeState;
//-(void) finishState;
//-(void) cancelState;

@end
