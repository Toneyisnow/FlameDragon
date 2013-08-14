//
//  ActionMenuState.m
//  FlameDragon
//
//  Created by sui toney on 11-11-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "ActionMenuState.h"
#import "FDMenuItem.h"
#import "SelectAttackTargetState.h"
#import "ItemsMenuState.h"
#import "FDTreasure.h"
#import "ConfirmMessage.h"
#import "MagicBox.h"
#import "SelectMagicTargetState.h"
#import "FDLocalString.h"
#import "TalkMessage.h"
#import "MagicDefinition.h"
#import "DataDepot.h"

@implementation ActionMenuState

-(id) initWithLayers:(ActionLayers *)ls Friend:(FDFriend *)frien
//-(id) initWithField:(id<IField,IFieldActionable>) fi Friend:(FDFriend *)frien
{
	self = [super initWithLayers:ls];
	
	currentFriend = frien;
	
	return self;
}

-(void) clickedOn:(CGPoint)location
{
	[layers updateSideBarLocation:location];
    
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
			[field closeMenu];
			switch ([menuItem getId]) {
				case 10:
					// Magic
					[self selectMagic];
					break;
				case 11:
					// Attack
					[field selectAttackTarget:currentFriend];
					nextState = [[SelectAttackTargetState alloc] initWithLayers:layers Friend:currentFriend];
					break;
				case 12:
					// Item
					[field showMenu:2 At:[field getObjectPos:currentFriend]];
					nextState = [[ItemsMenuState alloc] initWithLayers:layers Friend:currentFriend];
				
					break;
				case 13:
					// Sleep, and check treasure before that
					[self checkTreasureAndSleep];
					break;
				default:
					break;
			}
		}
	}
	else {
		if (![currentFriend hasActioned]) {
			[field cancelMove:currentFriend];
			shouldDispose = TRUE;
		}
		else {
			[field closeMenu];
			[layers creatureActionDone:currentFriend];
			
			isFinished = TRUE;
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

-(void) selectMagic
{
	MagicBox *box = [[MagicBox alloc] initWithCreature:currentFriend Type:MagicOperatingType_Select];
	
	[box setCallback:self Method:@selector(confirmSelectMagic:)];
	[box show:[layers getMessageLayer]];	
}

-(void) confirmSelectMagic:(NSNumber *)num
{
	int magicIndex = [num intValue];
	
	if (magicIndex < 0) {
		[self resumeState];
		return;
	}
	
	// If mana is not enough
	int magicId = [[currentFriend.data.magicList objectAtIndex:magicIndex] intValue];
	MagicDefinition *magic = [[DataDepot depot] getMagicDefinition:magicId];
	if (currentFriend.data.mpCurrent < magic.mpCost) {
		[self selectMagic];
		return;
	}
	
	[field selectMagicTarget:currentFriend MagicIndex:magicIndex];
	nextState = [[SelectMagicTargetState alloc] initWithLayers:layers Friend:currentFriend MagicIndex:magicIndex];
}

-(void) consume:(id)value
{

}

-(void) resumeState
{
	if (shouldDispose) {
		return;
		
	}
	[field showMenu:1 At:[field getObjectPos:currentFriend]];
}

-(void) checkTreasureAndSleep
{
	// If there is item, prompt whether to pick it up
	FDTreasure *treasure = [field getTreasureAt:[field getObjectPos:currentFriend]];
	if (treasure != nil && ![treasure hasOpened])
	{
		ConfirmMessage *message = [[ConfirmMessage alloc] initWithType:ConfirmMessageType_OpenBox CreatureAniDefId:[[currentFriend getDefinition] getAnimationId]];
		[message show:[layers getMessageLayer]];
		[message setCallback:self Method:@selector(confirmPickTreasure:)];
	}
	else
	{
        // Notify the event listener before ending turn
		//[layers creatureEndTurn:currentFriend];
        [layers appendToMainActivityMethod:@selector(notifyEventListener) Param1:nil Param2:nil Obj:layers];
        [layers appendToMainActivityMethod:@selector(creatureEndTurn:) Param1:currentFriend Param2:nil Obj:layers];
        
		isFinished = TRUE;
		shouldDispose = TRUE;
	}
}

-(void) confirmPickTreasure :(NSNumber *)num
{
	ConfirmMessageResult result = [num intValue];
	
	if (result == ConfirmMessageResult_Yes) {
		
		FDTreasure *treasure = [field getTreasureAt:[field getObjectPos:currentFriend]];
		ItemDefinition *item = [treasure getItem];
		
		NSString *msg = [NSString stringWithFormat:[FDLocalString message:3], item.name];
		TalkMessage *talk = [[TalkMessage alloc] initWithCreature:currentFriend Message:msg];
		[talk show:[layers getMessageLayer]];
		[talk release];
        
		if (![item isMoney] && [currentFriend isItemListFull])
		{
			ConfirmMessage *message = [[ConfirmMessage alloc] initWithType:ConfirmMessageType_ItemFull CreatureAniDefId:[[currentFriend getDefinition] getAnimationId]];
			[message setCallback:self Method:@selector(confirmExchangeItem:)];
			[layers appendToCurrentActivityMethod:@selector(show:) Param1:[layers getMessageLayer] Param2:nil Obj:message];
		}
		else
		{
			[layers pickUpTreasure:currentFriend];
			
			isFinished = TRUE;
			shouldDispose = TRUE;
		}
	}
	else
	{
		// Leave the treasure
		TalkMessage *talk = [[TalkMessage alloc] initWithCreature:currentFriend Message:[FDLocalString message:2]];
		[talk show:[layers getMessageLayer]];
		[talk release];
        
		isFinished = TRUE;
		shouldDispose = TRUE;
	}
	
	[layers appendToMainActivityMethod:@selector(closeMenu) Param1:nil Param2:nil Obj:field];
	
    // Notify the event listener before ending turn
    [layers appendToMainActivityMethod:@selector(notifyEventListener) Param1:nil Param2:nil Obj:layers];
    [layers appendToMainActivityMethod:@selector(creatureEndTurn:) Param1:currentFriend Param2:nil Obj:layers];
}


-(void) confirmExchangeItem:(NSNumber *)num
{
	ConfirmMessageResult result = [num intValue];
	
	if (result == ConfirmMessageResult_Yes) {
	
		[self selectItemToPutBack];
	}
	else {
		// Put it back
		TalkMessage *talk = [[TalkMessage alloc] initWithCreature:currentFriend Message:[FDLocalString message:7]];
		[talk show:[layers getMessageLayer]];
        [talk release];
	}
	
	isFinished = TRUE;
	shouldDispose = TRUE;
}

-(void) selectItemToPutBack
{
	ItemBox *box = [[ItemBox alloc] initWithCreature:currentFriend Type:ItemOperatingType_Exchange];
	
	[box setCallback:self Method:@selector(confirmItemToPutBack:)];
	[box show:[layers getMessageLayer]];
}

-(void) confirmItemToPutBack:(NSNumber *)num
{
	int itemIndex = [num intValue];
	
	if (itemIndex >= 0) {
		[layers exchangeTreasure:currentFriend withItem:itemIndex];
	}
	
	isFinished = TRUE;
	shouldDispose = TRUE;
}


@end
