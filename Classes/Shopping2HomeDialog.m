//
//  Shopping2HomeDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-5-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2HomeDialog.h"

#import "FDLocalString.h"
#import "DataDepot.h"
#import "FDSpriteStore.h"

#import "Shopping2Layer.h"
#import "Shopping2ShowProductDialog.h"
#import "Shopping2MessageDialog.h"
#import "Shopping2ConfirmDialog.h"
#import "Shopping2SelectAmorTargetDialog.h"
#import "Shopping2ShowFriendsDialog.h"
#import "Shopping2ShowItemsDialog.h"
#import "Shopping2ShowSellItemsDialog.h"

#import "CreatureRecord.h"
#import "ItemBox.h"
#import "MagicBox.h"
#import "Shopping2Layer.h"
#import "FDFriend.h"

@implementation Shopping2HomeDialog

-(id) init
{
	self = [super init];
	
	buttonArray = [[NSMutableArray alloc] init];
	
	return self;
}

-(void) initMessage
{
}

-(void) setMessage:(NSString *)msg
{
	if (messageSprite != nil) {
		[messageSprite removeFromLayer];
		[messageSprite release];
		messageSprite = nil;
	}
	
	messageSprite = [[FDSprite alloc] initWithString:msg Size:16];
	[messageSprite setAnchorPoint:CGPointMake(0, 0)];
	[baseSprite addSprite:messageSprite zOrder:1];
	[messageSprite setLocation:CGPointMake(10, 60)];
}

-(void) initButtons
{
	[self generateButtonArray];
	
	int posX = [baseSprite size].width - 120;
	int posY = 20;
	
	for (int i = 0; i < 4; i++) {
		ShoppingButton *button = [buttonArray objectAtIndex:i];
		
		[baseSprite addSprite:[button getSprite] zOrder:0];
		[button setLocation:CGPointMake(posX, posY)];
		
		posX += 30;
	}
	
}

-(void) clickedOn:(CGPoint)location
{
	CGPoint innnerLocation = [self getInnerLocation:location];
	
	for (ShoppingButton *button in buttonArray) {
		if ([button isClicked:innnerLocation]) {
			[button onClick];
			return;
		}
	}
	
	[super clickedOn:location];
}

-(void) generateButtonArray
{
	// Should be called by child class
}

-(ShoppingButton *) button_BuyAmor
{
	ShoppingButton *button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"Shop_Buy_0.png"]];
	[button setCallback:self Method:@selector(onBuyAmor)];
	return [button autorelease];
}

-(ShoppingButton *) button_BuyItem
{
	ShoppingButton *button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"Shop_Buy_0.png"]];
	[button setCallback:self Method:@selector(onBuyItem)];
	return [button autorelease];	
}

-(ShoppingButton *) button_Sell
{
	ShoppingButton *button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"Shop_Sell_0.png"]];
	[button setCallback:self Method:@selector(onSell)];
	return [button autorelease];	
}

-(ShoppingButton *) button_GiveItem
{
	ShoppingButton *button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"Shop_Give_0.png"]];
	[button setCallback:self Method:@selector(onGiveItem)];
	return [button autorelease];	
}

-(ShoppingButton *) button_Equip
{
	ShoppingButton *button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"Shop_Equip_0.png"]];
	[button setCallback:self Method:@selector(onEquip)];
	return [button autorelease];	
}

-(ShoppingButton *) button_Info
{
	ShoppingButton *button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"Shop_Info_0.png"]];
	[button setCallback:self Method:@selector(onInfo)];
	return [button autorelease];
}

-(ShoppingButton *) button_Save
{
	ShoppingButton *button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"Shop_Save_0.png"]];
	[button setCallback:self Method:@selector(onSaveGame)];
	return [button autorelease];	
}

-(ShoppingButton *) button_Load
{
	ShoppingButton *button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"Shop_Load_0.png"]];
	[button setCallback:self Method:@selector(onLoadGame)];
	return [button autorelease];	
}
-(ShoppingButton *) button_Revive
{
	ShoppingButton *button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"Shop_Revive_0.png"]];
	[button setCallback:self Method:@selector(onRevive)];
	return [button autorelease];	
}
-(ShoppingButton *) button_Transfer
{
	ShoppingButton *button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"Shop_Trans_0.png"]];
	[button setCallback:self Method:@selector(onTransfer)];
	return [button autorelease];	
}
-(ShoppingButton *) button_Exit
{
	ShoppingButton *button = [[ShoppingButton alloc] initWithSprite:[[FDSpriteStore instance] sprite:@"Shop_Exit_0.png"]];
	[button setCallback:self Method:@selector(onExitGame)];
	return [button autorelease];	
}

-(void) showDialog:(Shopping2Dialog *)dialog Callback:(SEL)callback
{
	Shopping2Layer *layer = (Shopping2Layer *)parentLayer;
	 
	[layer setDialog:dialog];
	
	if (callback != nil) {
		[dialog setSelectedCallback:self Method:callback];
	}
	
	[dialog setRecord:chapterRecord];
	[dialog show:layer];
}

-(void) onBuyAmor
{
}

-(void) onBuyItem
{
}

-(void) onSell
{
	NSLog(@"onSell");
	[self setMessage:[FDLocalString message:52]];
	
	lastPageIndex = 0;
	Shopping2ShowFriendsDialog *dialog = [[Shopping2ShowFriendsDialog alloc] initWithFriends:[chapterRecord friendRecords] pageIndex:0];
	[self showDialog:dialog Callback:@selector(onSell_SelectedFriend:)];
	[dialog release];
}

-(void) onSell_SelectedFriend:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		
		if (selectedNum == -1) return;
		lastPageIndex = (selectedNum == -2) ? lastPageIndex - 1 : ((selectedNum == -3) ? lastPageIndex + 1 : 0);
		
		Shopping2ShowFriendsDialog *dialog = [[Shopping2ShowFriendsDialog alloc] initWithFriends:[chapterRecord friendRecords] pageIndex:lastPageIndex];
		[self showDialog:dialog Callback:@selector(onSell_SelectedFriend:)];
		[dialog release];
		
		return;
	}
	
	lastSelectedCreatureIndex = selectedNum;
	CreatureRecord *friend = [[chapterRecord friendRecords] objectAtIndex:lastSelectedCreatureIndex];
	
	if ([friend.data.itemList count] == 0) {
		
		NSString *message = [FDLocalString message:64];
		Shopping2MessageDialog *dialog = [[Shopping2MessageDialog alloc] initWithMessage:message];
		[self showDialog:dialog Callback:@selector(onSell)];
		[dialog release];
		
	} else {
		lastPageIndex = 0;
		Shopping2ShowSellItemsDialog *dialog = [[Shopping2ShowSellItemsDialog alloc] initWithItemList:friend.data.itemList pageIndex:0];
		[self showDialog:dialog Callback:@selector(onSell_SelectedItem:)];
		[dialog release];
	}
}

-(void) onSell_SelectedItem:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		
		if (selectedNum == -1) { [self onSell]; return; }
		lastPageIndex = (selectedNum == -2) ? lastPageIndex - 1 : ((selectedNum == -3) ? lastPageIndex + 1 : 0);
		
		CreatureRecord *friend = [[chapterRecord friendRecords] objectAtIndex:lastSelectedCreatureIndex];
		Shopping2ShowSellItemsDialog *dialog = [[Shopping2ShowSellItemsDialog alloc] initWithItemList:friend.data.itemList pageIndex:lastPageIndex];
		[self showDialog:dialog Callback:@selector(onSell_SelectedItem:)];
		[dialog release];
		return;
	}
	
	lastSelectedItemIndex = selectedNum;
	
	CreatureRecord *friend = [[chapterRecord friendRecords] objectAtIndex:lastSelectedCreatureIndex];
	int itemId = [[friend.data.itemList objectAtIndex:lastSelectedItemIndex] intValue];
	ItemDefinition *item = [[DataDepot depot] getItemDefinition:itemId];
	
	// int itemIndex = selectedNum;
	
	NSString *message = [NSString stringWithFormat:[FDLocalString confirm:55], item.name, item.sellprice];
	Shopping2ConfirmDialog *dialog = [[Shopping2ConfirmDialog alloc] initWithMessage:message];
	[self showDialog:dialog Callback:@selector(onSell_Confirm:)];
	[dialog release];
}

-(void) onSell_Confirm:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum != 1) {
		
		// Cancel
		[self onSell_SelectedFriend:[NSNumber numberWithInt:lastSelectedCreatureIndex]];
		return;
	}
	
	// Sell the item
	[self doSellItem];
	
	NSLog(@"Item Sold");
	
}

-(void) doSellItem
{
	CreatureRecord *friend = [[chapterRecord friendRecords] objectAtIndex:lastSelectedCreatureIndex];
	int itemId = [[friend.data.itemList objectAtIndex:lastSelectedItemIndex] intValue];
	ItemDefinition *item = [[DataDepot depot] getItemDefinition:itemId];
	
	chapterRecord.money += item.sellprice;
	
	[friend.data removeItem:lastSelectedItemIndex];
	
	[(Shopping2Layer *)parentLayer updateMoneyBar];
}

-(void) onGiveItem
{
	NSLog(@"onGiveItem");
	[self setMessage:[FDLocalString message:52]];
	
	NSString *message = [FDLocalString message:58];
	Shopping2MessageDialog *dialog = [[Shopping2MessageDialog alloc] initWithMessage:message];
	[self showDialog:dialog Callback:@selector(onGiveItem_Start:)];
	[dialog release];
}

-(void) onGiveItem_Start:(NSNumber *)num
{
	lastPageIndex = 0;
	Shopping2ShowFriendsDialog *dialog = [[Shopping2ShowFriendsDialog alloc] initWithFriends:[chapterRecord friendRecords] pageIndex:0];
	[self showDialog:dialog Callback:@selector(onGiveItem_SelectedWhose:)];
	[dialog release];	
}

-(void) onGiveItem_SelectedWhose:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		if (selectedNum == -1) return;
		lastPageIndex = (selectedNum == -2) ? lastPageIndex - 1 : ((selectedNum == -3) ? lastPageIndex + 1 : 0);
		
		Shopping2ShowFriendsDialog *dialog = [[Shopping2ShowFriendsDialog alloc] initWithFriends:[chapterRecord friendRecords] pageIndex:lastPageIndex];
		[self showDialog:dialog Callback:@selector(onGiveItem_SelectedWhose:)];
		[dialog release];
		return;
	}
	
	lastSelectedCreatureIndex = selectedNum;
	
	CreatureRecord *friend = [[chapterRecord friendRecords] objectAtIndex:lastSelectedCreatureIndex];
	
	if ([friend.data.itemList count] == 0) {
		
		NSString *message = [FDLocalString message:64];
		Shopping2MessageDialog *dialog = [[Shopping2MessageDialog alloc] initWithMessage:message];
		[self showDialog:dialog Callback:@selector(onGiveItem_Start:)];
		[dialog release];
		
	} else {
		lastPageIndex = 0;
		Shopping2ShowItemsDialog *dialog = [[Shopping2ShowItemsDialog alloc] initWithItemList:friend.data.itemList pageIndex:0];
		[self showDialog:dialog Callback:@selector(onGiveItem_SelectedItem:)];
		[dialog release];
	}
}

-(void) onGiveItem_SelectedItem:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		if (selectedNum == -1) {
			[self onGiveItem_Start:[NSNumber numberWithInt:0]];
			return;
		}
		
		lastPageIndex = (selectedNum == -2) ? lastPageIndex - 1 : ((selectedNum == -3) ? lastPageIndex + 1 : 0);
		
		CreatureRecord *friend = [[chapterRecord friendRecords] objectAtIndex:lastSelectedCreatureIndex];
		Shopping2ShowItemsDialog *dialog = [[Shopping2ShowItemsDialog alloc] initWithItemList:friend.data.itemList pageIndex:lastPageIndex];
		[self showDialog:dialog Callback:@selector(onGiveItem_SelectedItem:)];
		[dialog release];
		
		return;
	}
	
	lastSelectedItemIndex = selectedNum;
	
	NSString *message = [FDLocalString message:59];
	Shopping2MessageDialog *dialog = [[Shopping2MessageDialog alloc] initWithMessage:message];
	[self showDialog:dialog Callback:@selector(onGiveItem_ToWhom:)];
	[dialog release];
}

-(void) onGiveItem_ToWhom:(NSNumber *)num
{	
	lastPageIndex = 0;
	Shopping2ShowFriendsDialog *dialog = [[Shopping2ShowFriendsDialog alloc] initWithFriends:[chapterRecord friendRecords] pageIndex:0];
	[self showDialog:dialog Callback:@selector(onGiveItem_ToTargetSelected:)];
	[dialog release];	
}

-(void) onGiveItem_ToTargetSelected:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		
		if (selectedNum == -1) {
			[self onGiveItem_Start:[NSNumber numberWithInt:0]];
			return;
		}
		lastPageIndex = (selectedNum == -2) ? lastPageIndex - 1 : ((selectedNum == -3) ? lastPageIndex + 1 : 0);
		
		Shopping2ShowFriendsDialog *dialog = [[Shopping2ShowFriendsDialog alloc] initWithFriends:[chapterRecord friendRecords] pageIndex:lastPageIndex];
		[self showDialog:dialog Callback:@selector(onGiveItem_ToTargetSelected:)];
		[dialog release];	
		
		return;
	}
	
	CreatureRecord *targetFriend = [[chapterRecord friendRecords] objectAtIndex:selectedNum];
	
	// Check if the item list is full
	if (selectedNum != lastSelectedCreatureIndex && [targetFriend.data.itemList count] >= 8) {
		
		NSString *message = [FDLocalString message:62];
		Shopping2MessageDialog *dialog = [[Shopping2MessageDialog alloc] initWithMessage:message];
		[self showDialog:dialog Callback:nil];
		[dialog release];
		
		return;
	}
	
	// Item Given.
	[self doGiveItem:selectedNum];
	NSLog(@"Item is given");
	
	[self onGiveItem];
}

-(void) doGiveItem:(int)creatureIndex
{
	CreatureRecord *targetFriend = [[chapterRecord friendRecords] objectAtIndex:creatureIndex];
	CreatureRecord *originFriend = [[chapterRecord friendRecords] objectAtIndex:lastSelectedCreatureIndex];
	
	// Item move to target
	NSNumber *itemId = [originFriend.data.itemList objectAtIndex:lastSelectedItemIndex];
	
	[targetFriend.data.itemList addObject:itemId];
	[originFriend.data.itemList removeObjectAtIndex:lastSelectedItemIndex];
	
}

-(void) onEquip
{
	NSLog(@"onEquip");
	[self setMessage:[FDLocalString message:52]];
	
	lastPageIndex = 0;
	Shopping2ShowFriendsDialog *dialog = [[Shopping2ShowFriendsDialog alloc] initWithFriends:[chapterRecord friendRecords] pageIndex:0];
	[self showDialog:dialog Callback:@selector(onEquip_SelectedFriend:)];
	[dialog release];
}

-(void) onEquip_SelectedFriend:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		if (selectedNum == -1) {
			return;
		}
		lastPageIndex = (selectedNum == -2) ? lastPageIndex - 1 : ((selectedNum == -3) ? lastPageIndex + 1 : 0);
		
		Shopping2ShowFriendsDialog *dialog = [[Shopping2ShowFriendsDialog alloc] initWithFriends:[chapterRecord friendRecords] pageIndex:lastPageIndex];
		[self showDialog:dialog Callback:@selector(onEquip_SelectedFriend:)];
		[dialog release];	
		
		return;		
	}
	
	lastSelectedCreatureIndex = selectedNum;
	
	Shopping2Layer *layer = (Shopping2Layer *)parentLayer;
	CreatureRecord *record = [[chapterRecord friendRecords] objectAtIndex:selectedNum];	
	FDFriend *creature = [[FDFriend alloc] initWithDefinition:record.definitionId Id:record.creatureId Data:record.data];

	NSLog(@"Creature equip items: %d %d", creature.data.attackItemIndex, creature.data.defendItemIndex);
	
	ItemBox *ibox = [[ItemBox alloc] initWithCreature:creature Type:ItemOperatingType_Equip];
	[ibox setCallback:self Method:@selector(onEquip_SelectedItem:)];
	[ibox show:layer];
	[layer setMessageBox:ibox];
	[ibox autorelease];
}

-(void) onEquip_SelectedItem:(NSNumber *)num
{
	// First close that ibox
	Shopping2Layer *layer = (Shopping2Layer *)parentLayer;
	[layer setMessageBox:nil]; 
	
	
	int selectedNum = [num intValue];
	if (selectedNum < 0) {
		// Cancel
		
		return;
	}
	
	lastSelectedItemIndex = selectedNum;
	
	//Equip that item
	[self doEquip];
	
	
	[self onEquip_SelectedFriend:[NSNumber numberWithInt:lastSelectedCreatureIndex]];
}

-(void) doEquip
{
	NSLog(@"do Equip for user %d item %d", lastSelectedCreatureIndex, lastSelectedItemIndex);
	
	CreatureRecord *record = [[chapterRecord friendRecords] objectAtIndex:lastSelectedCreatureIndex];	
	NSNumber *itemId = [record.data.itemList objectAtIndex:lastSelectedItemIndex];
	ItemDefinition *item = [[DataDepot depot] getItemDefinition:[itemId intValue]];
	
	CreatureDefinition *creatureDef = [[DataDepot depot] getCreatureDefinition:record.definitionId];
	if (![creatureDef canEquip:[itemId intValue]]) {
		// Cannot equip this item
		return;
	}
	
	if ([item isAttackItem]) {
		record.data.attackItemIndex = lastSelectedItemIndex;
	}
	else if ([item isDefendItem]) {
		record.data.defendItemIndex = lastSelectedItemIndex;
	}
}

-(void) onInfo
{
	NSLog(@"onInfo");
	[self setMessage:[FDLocalString message:52]];
	
	lastPageIndex = 0;
	Shopping2ShowFriendsDialog *dialog = [[Shopping2ShowFriendsDialog alloc] initWithFriends:[chapterRecord friendRecords] pageIndex:0];
	[self showDialog:dialog Callback:@selector(onInfo_ShowItems:)];
	[dialog release];
}

-(void) onInfo_ShowItems:(NSNumber *)num
{
	// First close that ibox
	//[self closeCurrentBox]; 
	
	NSLog(@"onInfo_ShowItems:%d", [num intValue]);
	
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		if (selectedNum == -1) {
			return;
		}
		lastPageIndex = (selectedNum == -2) ? lastPageIndex - 1 : ((selectedNum == -3) ? lastPageIndex + 1 : 0);
		
		Shopping2ShowFriendsDialog *dialog = [[Shopping2ShowFriendsDialog alloc] initWithFriends:[chapterRecord friendRecords] pageIndex:lastPageIndex];
		[self showDialog:dialog Callback:@selector(onInfo_ShowItems:)];
		[dialog release];	
		
		return;		
	}
	
	lastSelectedCreatureIndex = selectedNum;
	
	Shopping2Layer *layer = (Shopping2Layer *)parentLayer;
	CreatureRecord *record = [[chapterRecord friendRecords] objectAtIndex:selectedNum];	
	FDFriend *creature = [[FDFriend alloc] initWithDefinition:record.definitionId Id:record.creatureId Data:record.data];
	
	ItemBox *ibox = [[ItemBox alloc] initWithCreature:creature Type:ItemOperatingType_ShowOnly];
	
	if ([creature.data.magicList count] > 0) {
		[ibox setCallback:self Method:@selector(onInfo_ShowMagics:)];
	} else {
		[ibox setCallback:self Method:@selector(closeCurrentBox)];
	}
	
	[ibox show:layer];
	[layer setMessageBox:ibox];
	[ibox autorelease];
}

-(void) onInfo_ShowMagics:(NSNumber *)num
{
	Shopping2Layer *layer = (Shopping2Layer *)parentLayer;
	CreatureRecord *record = [[chapterRecord friendRecords] objectAtIndex:lastSelectedCreatureIndex];	
	FDFriend *creature = [[FDFriend alloc] initWithDefinition:record.definitionId Id:record.creatureId Data:record.data];
	
	MagicBox *mbox = [[MagicBox alloc] initWithCreature:creature Type:MagicOperatingType_ShowOnly];
	[mbox setCallback:self Method:@selector(closeCurrentBox)];
	[mbox show:layer];
	[layer setMessageBox:mbox];
	[mbox autorelease];
}

-(void) closeCurrentBox
{
	Shopping2Layer *layer = (Shopping2Layer *)parentLayer;
	[layer setMessageBox:nil]; 
}

-(void) onSaveGame
{
}

-(void) onLoadGame
{
}

-(void) onExitGame
{
}

-(void) onRevive
{
}

-(void) onTransfer
{
}

-(void) dealloc
{
	[buttonArray release];
	
	[super dealloc];
}

@end
