//
//  ShowingMoveScopeState.m
//  FlameDragon
//
//  Created by sui toney on 11-11-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "ShowingMoveScopeState.h"
#import "ActionMenuState.h"

@implementation ShowingMoveScopeState

-(id) initWithLayers:(ActionLayers *)ls Friend:(FDFriend *)frien
{
	self = [super initWithLayers:ls];
	currentFriend = frien;

	return self;
}

/*
-(id) initWithField:(id<IField,IFieldActionable>) fi Friend:(FDFriend *)frien
{
	self = [super initWithField:fi];
	
	currentFriend = frien;
	
	return self;
}
*/

-(void) clickedOn:(CGPoint)location
{
	CCLOG(@"clickedOn: ShowingMoveScopeState");
	
	[layers clearCreatureInfo];

	CGPoint position = [field convertLocToPos:[field getMapLocationbyScreen:location]];
	
	if (![FDPosition isEqual:[field getCursorPos] With:position])
	{
		// Set cursor to current position
		[field setCursorTo:position];
	}
	else
	{
		if ([field isInScope:position])
		{
			[field removeAllIndicators];
			//[field moveCreature:currentCreature To:[field getPath:position]];
			[layers moveCreature:currentFriend To:position showMenu:TRUE];
			
			nextState = [[ActionMenuState alloc] initWithLayers:layers Friend:currentFriend];
		}
		else {
			[field removeAllIndicators];
			//[field cancelPrepare:currentCreature];
			shouldDispose = TRUE;
		}
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

-(void) consume:(id)value
{
	
}

-(void) resumeState
{
	[field setCursorTo:[field getObjectPos:currentFriend]];
	[field prepareToMove:currentFriend];
}

-(void) preSetMapLocation:(CGPoint)loc
{
	[layers clearCreatureInfo];
}


@end
