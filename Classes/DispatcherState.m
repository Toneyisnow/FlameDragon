//
//  DispatcherState.m
//  FlameDragon
//
//  Created by sui toney on 11-11-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "DispatcherState.h"


@implementation DispatcherState


-(id) initWithLayers:(ActionLayers *)ls
//-(id) initWithField:(id<IField, IFieldActionable>) fi
{
	self = [super init];
	
	layers = ls;
	field = [[layers getFieldLayer] getField];
	
	isFinished = FALSE;
	shouldDispose = FALSE;
	nextState = nil;
	
	return self;
}

-(void) clickedOn:(CGPoint)location
{
}

-(void) pressLeft
{
}

-(void) pressRight
{
}

-(void) pressUp
{
}

-(void) pressDown
{
}

-(void) pressOk
{
}

-(void) pressCancel
{
}

-(void) preSetMapLocation:(CGPoint)loc
{
	
}

-(id) returnedValue
{
	if (!isFinished)
	{
		return nil;
	}
	else {
		return [[NSNull alloc] init];
	}	
}

-(void) consume:(id)value
{
	
}

-(void) resumeState
{
	
}

-(BOOL) shouldDispose
{
	return shouldDispose;
}

-(DispatcherState *) getNextState
{
	return nextState;
}

-(void) clearNextState
{
	[nextState release];
	nextState = nil;
}

-(BOOL) allowMoveScreen
{
	if ([[layers getMessageLayer] getMessage] != nil)
	{
		return FALSE;
	}
	return TRUE;
}

-(void) dealloc
{
	if (nextState != nil)
	{
		[nextState release];
		nextState = nil;
	}
	
	[super dealloc];
}

@end
