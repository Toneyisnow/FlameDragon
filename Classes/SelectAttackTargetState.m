//
//  SelectAttackTargetState.m
//  FlameDragon
//
//  Created by sui toney on 11-11-16.
//  Copyright 2011 ms. All rights reserved.
//

#import "SelectAttackTargetState.h"
#import "FDEnemy.h"

@implementation SelectAttackTargetState

-(id) initWithLayers:(ActionLayers *)ls Friend:(FDFriend *)frien
{
	self = [super initWithLayers:ls];
	
	currentFriend = frien;
	
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
			FDCreature *target = [field getCreatureByPos:position];
			if (target != nil && [target isKindOfClass:[FDEnemy class]])
			{
				[field removeAllIndicators];
				[layers attackFrom:currentFriend Target:target];
			
				isFinished = TRUE;
				shouldDispose = TRUE;
			}
		}
		else {
			// Cancel the state
			
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

}



@end