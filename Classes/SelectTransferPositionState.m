//
//  SelectTransferPositionState.m
//  FlameDragon
//
//  Created by sui toney on 13-5-1.
//
//

#import "SelectTransferPositionState.h"

@implementation SelectTransferPositionState

-(id) initWithLayers:(ActionLayers *)ls Friend:(FDFriend *)frien Creature:(FDCreature *)c
{
    self = [super initWithLayers:ls];
	
	currentFriend = frien;
	targetCreature = c;
	
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
        if (![FDPosition isEqual:[field getObjectPos:targetCreature] With:position]
            && [field canLandedAt:position forCreature:targetCreature])
        {
            [layers transferBy:currentFriend forCreature:targetCreature to:position];
            
            isFinished = TRUE;
            shouldDispose = TRUE;
        }
		else {
			// Cancel the state
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
