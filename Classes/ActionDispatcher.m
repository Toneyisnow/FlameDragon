//
//  ActionDispatcher.m
//  FlameDragon
//
//  Created by sui toney on 11-11-7.
//  Copyright 2011 ms. All rights reserved.
//

#import "ActionDispatcher.h"
#import "FDPath.h"
#import "FDFriend.h"
#import "FDPosition.h"
#import "FDMenuItem.h"
#import "IdleState.h"

@implementation ActionDispatcher

-(id) initWithLayers:(ActionLayers *)ls
// -(id) initWithField:(id<IField, IFieldActionable>) fi Message:(MessageLayer *)mLayer
{
	self = [super init];
	
	layers = ls;
	field = [[layers getFieldLayer] getField];
	
	stateQueue = [[NSMutableArray alloc] init];
	IdleState *state = [[IdleState alloc] initWithLayers:layers];
	[stateQueue addObject:state];
	[state release];
	
	// dispatcherState = DispatcherState_Idle;
	
	return self;
}

-(void) clickedOn:(CGPoint)location
{
	IMessage *message = [[layers getMessageLayer] getMessage];
	if (message != nil)
	{
		[message clickedOn:location];
		return;
	}
	
	if ([layers isInteractiveBusy])
	{
		return;
	}

	[self updateState];
	
	[[self getLastState] clickedOn:location];
	[self updateState];
}

-(void) pressLeft
{
	if ([layers isInteractiveBusy])
	{
		return;
	}
	[self updateState];
	[[self getLastState] pressLeft];
	[self updateState];
}

-(void) pressRight
{
	if ([layers isInteractiveBusy])
	{
		return;
	}
	[self updateState];
	[[self getLastState] pressRight];
	[self updateState];
}

-(void) pressUp
{
	if ([layers isInteractiveBusy])
	{
		return;
	}
	[self updateState];
	[[self getLastState] pressUp];
	[self updateState];
}

-(void) pressDown
{
	if ([layers isInteractiveBusy])
	{
		return;
	}
	[self updateState];
	[[self getLastState] pressDown];
	[self updateState];
}

-(void) pressOk
{
	if ([layers isInteractiveBusy])
	{
		return;
	}
	[self updateState];
	[[self getLastState] pressOk];
	[self updateState];
}

-(void) pressCancel
{
	if ([layers isInteractiveBusy])
	{
		return;
	}
	[self updateState];
	[[self getLastState] pressCancel];
	[self updateState];
}

-(void) updateState
{
	DispatcherState *state = [self getLastState];
	
	if (state != nil && [state shouldDispose]) {
		
		if ([[state returnedValue] isKindOfClass:[NSNull class]]) {
			while ([stateQueue count] > 1) {
				[stateQueue removeObjectAtIndex:([stateQueue count]-1)];
			}
		}
		else {

			[state retain];
			
			//[state cancelState];
			//[stateQueue removeObjectAtIndex:([stateQueue count]-1)];
			[stateQueue removeObject:state];
		
			DispatcherState *previousState = [self getLastState];
			[previousState consume:[state returnedValue]];
		
			[previousState resumeState];
			
			[self updateState];
			//[state release];
		}
	}
	else if ([state getNextState] != nil) {
		
		[stateQueue addObject:[state getNextState]];
		[state clearNextState];
		//[state finishState];
		
	}

}

-(DispatcherState *) getLastState
{
	if ([stateQueue count] > 0) {
		return [stateQueue objectAtIndex:[stateQueue count]-1];
	}
	else {
		return nil;
	}

}

-(CGPoint) getMapLocation
{
	return [field getMapLocation];
}

-(void) setMapLocation:(CGPoint)loc
{
	DispatcherState *lastState = [self getLastState];
	
	if (lastState != nil) {
		[lastState preSetMapLocation:loc];
		
		if (![lastState allowMoveScreen]) {
			return;
		}
	}
	
	if ([layers isLocked])
	{
		return;
	}
		
	[field setMapLocation:loc];
	
}

-(void) dealloc
{
	[stateQueue release];
	
	[super dealloc];
}


@end
