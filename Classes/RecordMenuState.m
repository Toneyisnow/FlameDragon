//
//  RecordMenuState.m
//  FlameDragon
//
//  Created by sui toney on 11-11-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "RecordMenuState.h"
#import "FDTalkActivity.h"
#import "ConfirmMessage.h"
#import "FDLocalString.h"

@implementation RecordMenuState

-(id) initWithLayers:(ActionLayers *)ls Position:(CGPoint)pos
{
	self = [super initWithLayers:ls];
	
	centralPosition = pos;
	
	confirmingLoad = FALSE;
	confirmingSave = FALSE;
	confirmingQuit = FALSE;
	
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
				case 40:
					// Save
					[self promptSaveGame];
					break;
				case 41:
					// Information
					[field closeMenu];
					
					[layers showChapterInfo];
					shouldDispose = TRUE;
					isFinished = TRUE;
					
					break;
				case 42:
					// Load
					[self promptLoadGame];
					break;
				case 43:
					// Quit Game
					[self promptQuitGame];
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

-(void) promptSaveGame
{
	ConfirmMessage *message = [[ConfirmMessage alloc] initWithType:ConfirmMessageType_SaveGame CreatureAniDefId:0];
	[message show:[layers getMessageLayer]];
	[message setCallback:self Method:@selector(confirmSaveGame:)];	
}

-(void) confirmSaveGame:(NSNumber *)num
{
	ConfirmMessageResult result = [num intValue];
	
	if (result == ConfirmMessageResult_Yes)
	{
		[field closeMenu];
		shouldDispose = TRUE;
		isFinished = TRUE;
		
		[layers appendToCurrentActivityMethod:@selector(saveGame) Param1:nil Param2:nil];
	}
	
	NSString *message = nil;
	if (result == ConfirmMessageResult_Yes)
	{
		message = [FDLocalString message:9];
	}
	else
	{
		message = [FDLocalString message:2];
	}
	
	FDTalkActivity *talk = [[FDTalkActivity alloc] initWithCreature:nil Message:message Layer:[layers getMessageLayer]];
	[layers appendToCurrentActivity:talk];
	[talk release];
	
}
	
-(void) promptLoadGame
{
	ConfirmMessage *message = [[ConfirmMessage alloc] initWithType:ConfirmMessageType_LoadGame CreatureAniDefId:0];
	[message show:[layers getMessageLayer]];
	[message setCallback:self Method:@selector(confirmLoadGame:)];	
}

-(void) confirmLoadGame:(NSNumber *)num
{
	ConfirmMessageResult result = [num intValue];
	
	if (result == ConfirmMessageResult_Yes)
	{
		[field closeMenu];
		shouldDispose = TRUE;
		isFinished = TRUE;
		
		[layers appendToCurrentActivityMethod:@selector(gameContinue) Param1:nil Param2:nil];
	}
	else
	{
		NSString *message = [FDLocalString message:2];
		FDTalkActivity *talk = [[FDTalkActivity alloc] initWithCreature:nil Message:message Layer:[layers getMessageLayer]];
		[layers appendToCurrentActivity:talk];
		[talk release];
	}
}

-(void) promptQuitGame
{
	ConfirmMessage *message = [[ConfirmMessage alloc] initWithType:ConfirmMessageType_QuitGame CreatureAniDefId:0];
	[message show:[layers getMessageLayer]];
	[message setCallback:self Method:@selector(confirmQuitGame:)];	
}

-(void) confirmQuitGame:(NSNumber *)num
{
	ConfirmMessageResult result = [num intValue];
	
	NSString *message = nil;
	if (result == ConfirmMessageResult_Yes)
	{
		message = [FDLocalString message:8];
	}
	else
	{
		message = [FDLocalString message:2];
	}
	
	FDTalkActivity *talk = [[FDTalkActivity alloc] initWithCreature:nil Message:message Layer:[layers getMessageLayer]];
	[layers appendToCurrentActivity:talk];
	[talk release];
    
	if (result == ConfirmMessageResult_Yes)
	{
		[field closeMenu];
		shouldDispose = TRUE;
		isFinished = TRUE;
		
		[layers appendToCurrentActivityMethod:@selector(gameQuit) Param1:nil Param2:nil];
	}
}

-(id) returnedValue
{
	return nil;
}

-(void) consume:(id)value
{
	int result = [value intValue];
	
	if (confirmingLoad) {
		
		if (result == 1) {
			
			// TODO: Load Game
			NSLog(@"Load Game.");
			
			isFinished = TRUE;
			shouldDispose = TRUE;
		}
		
		confirmingLoad = FALSE;
	}
	
	else if (confirmingSave) {
		
		if (result == 1) {
			
			// TODO: Save Game
			NSLog(@"Save Game.");
			
			isFinished = TRUE;
			shouldDispose = TRUE;
		}
		
		confirmingSave = FALSE;
	}
	
	else if (confirmingQuit) {
		
		if (result == 1) {
			
			// TODO: Quit Game
			NSLog(@"Quit Game.");
			
			isFinished = TRUE;
			shouldDispose = TRUE;
		}
		
		confirmingQuit = FALSE;
	}


}

-(void) resumeState
{
	if (shouldDispose) {
		return;
		
	}
	
	[field showMenu:4 At:centralPosition];	
}

@end
