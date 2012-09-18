//
//  ExchangeItemTargetState.m
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "ExchangeItemTargetState.h"
#import "ItemBox.h"

// #import "ExchangeItemBackState.h"

@implementation ExchangeItemTargetState

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
			target = [field getCreatureByPos:position];
			if ([target isKindOfClass:[FDFriend class]]) {
				
				//int itemId = [currentFriend getItemId:itemIndex];
				[field removeAllIndicators];
				
				if (![target isItemListFull]) {
					
					[layers giveItem:currentFriend ItemIndex:itemIndex Target:target];
				
					isFinished = TRUE;
					shouldDispose = TRUE;
				}
				else {
					// Exchange
					[self selectItemToExchangeBack];
					//nextState = [[ExchangeItemBackState alloc] initWithLayers:layers Friend:currentFriend ItemIndex:itemIndex Target:creature];
					
				}
			}
		}
		else
		{
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

-(void) resumeState
{
	
}

-(void) selectItemToExchangeBack
{
	ItemBox *box = [[ItemBox alloc] initWithCreature:target Type:ItemOperatingType_Exchange];
	
	[box setCallback:self Method:@selector(confirmItemToExchangeBack:)];
	[box show:[layers getMessageLayer]];
}

-(void) confirmItemToExchangeBack:(NSNumber *)num
{
	int backItemIndex = [num intValue];
	
	if (backItemIndex < 0) {
		shouldDispose = TRUE;
		return;
	}
	
	[layers exchangeItem:currentFriend ItemIndex:itemIndex Target:target ItemIndex:backItemIndex];
	//[layers giveItem:target ItemIndex:backItemIndex Target:currentFriend];
	//[layers giveItem:currentFriend ItemIndex:itemIndex Target:target];
	
	isFinished = TRUE;
	shouldDispose = TRUE;
}


@end
