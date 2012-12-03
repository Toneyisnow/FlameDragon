//
//  IdleState.m
//  FlameDragon
//
//  Created by sui toney on 11-11-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "IdleState.h"
#import "FDFriend.h"
#import "ShowingMoveScopeState.h"
#import "SystemMenuState.h"

@implementation IdleState

-(id) initWithLayers:(ActionLayers *)ls
{
	self = [super initWithLayers:ls];
	return self;
}

-(void) clickedOn:(CGPoint)location
{
	CGPoint position = [field convertLocToPos:[field getMapLocationbyScreen:location]];
	
	
	FDCreature *creature = [field getCreatureByPos:position];
	
	if (creature != nil)
	{
		if ([creature isKindOfClass:[FDFriend class]] && !creature.hasActioned)
		{
			// Show actions
			[field setCursorTo:position];
			[layers prepareToMove:creature Location:location];
			[field prepareToMove:creature];
			
			nextState = [[ShowingMoveScopeState alloc] initWithLayers:layers Friend:(FDFriend *)creature];
		}
		else {
			// Show status
			[layers showItemStatusAsync:creature];
			if ([creature.data.magicList count] > 0) {
				[layers showMagicStatusAsync:creature];
			}
		}
	}
	else {
		// Show system menu
		if ([FDPosition isEqual:[field getCursorPos] With:position])
		{
			[field showMenu:3 At:position];
			nextState = [[SystemMenuState alloc] initWithLayers:layers Position:position];
		}
		
		[field setCursorTo:position];
	}
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

// Idle state should never be disposed
-(BOOL) shouldDispose
{
	return FALSE;
}


-(id) returnedValue
{
	return nil;
}

-(void) consume:(id)value
{
	
}

-(void) resumeState
{
	// This is not going to happen
}

// This is not going to happen
-(void) cancelState
{
}


@end
