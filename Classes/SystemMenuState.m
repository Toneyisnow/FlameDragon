//
//  SystemMenuState.m
//  FlameDragon
//
//  Created by sui toney on 11-11-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "SystemMenuState.h"
#import "RecordMenuState.h"
#import "SettingsMenuState.h"
#import "ConfirmMessage.h"
#import "TalkMessage.h"
#import "FDLocalString.h"

@implementation SystemMenuState

-(id) initWithLayers:(ActionLayers *)ls Position:(CGPoint)pos
{
	self = [super initWithLayers:ls];
	
	centralPosition = pos;
	confirmingEndTurn = FALSE;
	
	return self;
}

-(void) clickedOn:(CGPoint)location
{
	CGPoint position = [field convertLocToPos:[field getMapLocationbyScreen:location]];
	
	FDMenuItem *menuItem = [field getMenuItemByPos:position];
	
	if (menuItem != nil)
	{
		if (![menuItem isSelected])
		{
			if ([menuItem isValid]) {
				[field selectMenuItem:menuItem];
			}
		}
		else
		{
			switch ([menuItem getId]) {
				case 30:
					// Matching
					[field closeMenu];
					shouldDispose = TRUE;
					
					break;
				case 31:
					// Record Menu
					[field closeMenu];
					[field showMenu:4 At:centralPosition];
					nextState = [[RecordMenuState alloc] initWithLayers:layers Position:centralPosition];
					
					break;
				case 32:
					// Settings Menu
					[field closeMenu];
					[field showMenu:5 At:centralPosition];
					nextState = [[SettingsMenuState alloc] initWithLayers:layers Position:centralPosition];
					
					break;
				case 33:
					// End Turn
					[self promptEndTurn];
					
					break;
				default:
					break;
			}
		}
	}
	else {
		[field closeMenu];
		shouldDispose = TRUE;
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

-(id) returnedValue
{
	return nil;
}

-(void) consume:(id)value
{
	if (confirmingEndTurn) {
		
		NSNumber *result = (NSNumber *)value;
		
		if ([result intValue] == 1) {
			// Pick up the treasure
			[layers endFriendTurn];
			shouldDispose = TRUE;
			isFinished = TRUE;
		}
		else {
			// Keep it
		}
		confirmingEndTurn = FALSE;
	}	
	
}

-(void) resumeState
{
	if (shouldDispose) {
		return;
		
	}
	
	[field showMenu:3 At:centralPosition];	
}

-(void) promptEndTurn
{
	ConfirmMessage *message = [[ConfirmMessage alloc] initWithType:ConfirmMessageType_EndTurn CreatureAniDefId:0];
	[message show:[layers getMessageLayer]];
	[message setCallback:self Method:@selector(confirmEndTurn:)];
}

-(void) confirmEndTurn:(NSNumber *)num
{
	ConfirmMessageResult result = [num intValue];
	
	if (result == ConfirmMessageResult_Yes) {
		
		TalkMessage *talk = [[TalkMessage alloc] initWithCreature:nil Message:[FDLocalString message:1]];
		[talk show:[layers getMessageLayer]];
		[talk release];
        
		[layers appendToCurrentActivityMethod:@selector(closeMenu) Param1:nil Param2:nil Obj:field];
		[layers appendToCurrentActivityMethod:@selector(endFriendTurn) Param1:nil Param2:nil Obj:layers];
		
		isFinished = TRUE;
		shouldDispose = TRUE;
	}
	else {
		// Cancel
		TalkMessage *talk = [[TalkMessage alloc] initWithCreature:nil Message:[FDLocalString message:2]];
		[talk show:[layers getMessageLayer]];
        [talk release];
	}
	
	
}

@end
