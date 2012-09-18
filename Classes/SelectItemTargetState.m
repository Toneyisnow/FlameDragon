//
//  SelectItemTargetState.m
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "SelectItemTargetState.h"


@implementation SelectItemTargetState

-(id) initWithLayers:(ActionLayers *)ls Friend:(FDFriend *)frien ItemIndex:(int)m
{
	self = [super initWithLayers:ls];
	
	currentFriend = frien;
	itemIndex = m;
	
	return self;
}

-(void) clickedOn:(CGPoint)location
{
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
			FDCreature *creature = [field getCreatureByPos:position];
			if ([creature isKindOfClass:[FDFriend class]]) {
			
				[field removeAllIndicators];
				[layers useItem:currentFriend ItemIndex:itemIndex Target:creature];
				
				isFinished = TRUE;
				shouldDispose = TRUE;
			}
		}
		else {
			// Cancel the state
			[field removeAllIndicators];
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
	
}



@end
