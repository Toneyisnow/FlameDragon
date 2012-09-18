//
//  ItemsMenuState.m
//  FlameDragon
//
//  Created by sui toney on 11-11-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "ItemsMenuState.h"
#import "ItemBox.h"
#import "ExchangeItemTargetState.h"
#import "SelectItemTargetState.h"

@implementation ItemsMenuState

-(id) initWithLayers:(ActionLayers *)ls Friend:(FDFriend *)frien
{
	self = [super initWithLayers:ls];
	
	currentFriend = frien;
	
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
			case 20:
					// Exchange item
					[self selectItemToExchange];
					break;
			case 21:
					// Use item
					[self selectItemToUse];
					break;
			case 22:
					// Equip item
					[self selectItemToEquip];
					break;
			case 23:
					// Drop item
					[self selectItemToDrop];
					break;
			default:
				break;
		    }
			[field closeMenu];
			
			
			//nextState = [[SelectItemMenuState alloc] initWithLayers:layers Friend:currentFriend Type:operating];
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

-(void) selectItemToUse
{
	ItemBox *box = [[ItemBox alloc] initWithCreature:currentFriend Type:ItemOperatingType_Use];
	
	[box setCallback:self Method:@selector(confirmItemToUse:)];
	[box show:[layers getMessageLayer]];
}

-(void) confirmItemToUse:(NSNumber *)num
{
	int itemIndex = [num intValue];
	
	if (itemIndex < 0) {
		[self resumeState];
		return;
	}
	
	[field selectItemTarget:currentFriend IncludeSelf:TRUE];
	nextState = [[SelectItemTargetState alloc] initWithLayers:layers Friend:currentFriend ItemIndex:itemIndex];
}

-(void) selectItemToEquip
{
	ItemBox *box = [[ItemBox alloc] initWithCreature:currentFriend Type:ItemOperatingType_Equip];
	
	[box setCallback:self Method:@selector(confirmItemToEquip:)];
	[box show:[layers getMessageLayer]];	
}

-(void) confirmItemToEquip:(NSNumber *)num
{
	int itemIndex = [num intValue];
	
	if (itemIndex < 0) {
		[self resumeState];
		return;
	}
	
	[currentFriend equipEquipment:itemIndex];
	[self selectItemToEquip];
}

-(void) selectItemToDrop
{
	ItemBox *box = [[ItemBox alloc] initWithCreature:currentFriend Type:ItemOperatingType_Drop];
	
	[box setCallback:self Method:@selector(confirmItemToDrop:)];
	[box show:[layers getMessageLayer]];
}

-(void) confirmItemToDrop:(NSNumber *)num
{
	int itemIndex = [num intValue];
	
	if (itemIndex < 0) {
		[self resumeState];
		return;
	}
	
	[currentFriend dropItem:itemIndex];
	[self resumeState];
}

-(void) selectItemToExchange
{
	ItemBox *box = [[ItemBox alloc] initWithCreature:currentFriend Type:ItemOperatingType_Exchange];
	
	[box setCallback:self Method:@selector(confirmItemToExchange:)];
	[box show:[layers getMessageLayer]];
}

-(void) confirmItemToExchange:(NSNumber *)num
{
	int itemIndex = [num intValue];
	
	if (itemIndex < 0) {
		[self resumeState];
		return;
	}
	
	[field selectItemTarget:currentFriend IncludeSelf:TRUE];
	nextState = [[ExchangeItemTargetState alloc] initWithLayers:layers Friend:currentFriend ItemIndex:itemIndex];
}

-(void) resumeState
{
	[field showMenu:2 At:[field getObjectPos:currentFriend]];
}

@end
