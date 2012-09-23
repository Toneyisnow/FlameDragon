//
//  Shopping2ItemDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2ItemDialog.h"

#import "Shopping2ShowItemsDialog.h"
#import "Shopping2ConfirmDialog.h"
#import "Shopping2MessageDialog.h"
#import "Shopping2ShowFriendsDialog.h"
#import "Shopping2Layer.h"

@implementation Shopping2ItemDialog

// Override Method
-(void) generateButtonArray
{
	[buttonArray addObject:[self button_BuyItem]];
	[buttonArray addObject:[self button_Sell]];
	[buttonArray addObject:[self button_Equip]];
	[buttonArray addObject:[self button_GiveItem]];
	
}

-(void) onBuyItem
{
	NSLog(@"onBuyItem");
	
	ShopDefinition *shop = [[DataDepot depot] getShopDefinition:chapterRecord.chapterId Type:DataDepotShopType_ItemShop];
	
	lastPageIndex = 0;
	Shopping2ShowItemsDialog *dialog = [[Shopping2ShowItemsDialog alloc] initWithItemList:shop.itemList pageIndex:0];
	[self showDialog:dialog Callback:@selector(onBuyItem_SelectedItem:)];
	[dialog release];
	
}

-(void) onBuyItem_SelectedItem:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		switch (selectedNum) {
			case -1:
				// Cancel
				return;
			case -2:
				// Go Up Page
				lastPageIndex --; break;
			case -3:
				// Go Down Page
				lastPageIndex ++; break;
			default:
				break;
		}
		
		ShopDefinition *shop = [[DataDepot depot] getShopDefinition:chapterRecord.chapterId Type:DataDepotShopType_ItemShop];
		
		Shopping2ShowItemsDialog *dialog = [[Shopping2ShowItemsDialog alloc] initWithItemList:shop.itemList pageIndex:lastPageIndex];
		[self showDialog:dialog Callback:@selector(onBuyItem_SelectedItem:)];
		[dialog release];
		
		return;
	} 
	
	NSLog(@"onBuyItem_SelectedItem : %d", selectedNum);
	
	ShopDefinition *shop = [[DataDepot depot] getShopDefinition:chapterRecord.chapterId Type:DataDepotShopType_ItemShop];
	NSNumber *itemId  = [shop.itemList objectAtIndex:selectedNum];
	
	ItemDefinition *item = [[DataDepot depot] getItemDefinition:[itemId intValue]];
	
	// Confirm Message
	NSString *message = [NSString stringWithFormat:[FDLocalString confirm:54], item.name, item.price];
	
	Shopping2ConfirmDialog *dialog = [[Shopping2ConfirmDialog alloc] initWithMessage:message];
	[self showDialog:dialog Callback:@selector(onBuyItem_ConfirmedItem:)];
	[dialog release];
	
}
-(void) onBuyItem_ConfirmedItem:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum <= 0) {
		// Cancelled
		
		[self onBuyItem];
		return;
	}
	
	lastSelectedItemIndex = selectedNum;
	
	ItemDefinition *item = [self getItemDefinition:chapterRecord.chapterId Type:DataDepotShopType_ItemShop Index:lastSelectedItemIndex];
	if (chapterRecord.money < item.price) {
		
		// If not enough money
		NSString *message = [FDLocalString message:63];
		Shopping2MessageDialog *dialog = [[Shopping2MessageDialog alloc] initWithMessage:message];
		[self showDialog:dialog Callback:nil];
		[dialog release];
	}
	else {
		
		lastPageIndex = 0;
		Shopping2ShowFriendsDialog *dialog = [[Shopping2ShowFriendsDialog alloc] initWithFriends:[chapterRecord friendRecords] pageIndex:0];
		[self showDialog:dialog Callback:@selector(onBuyItem_Done:)];
		[dialog release];
	}
}

-(void) onBuyItem_Done:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		switch (selectedNum) {
			case -1:
				// Cancel
				return;
			case -2:
				// Go Up Page
				lastPageIndex --; break;
			case -3:
				// Go Down Page
				lastPageIndex ++; break;
			default:
				break;
		}
		
		Shopping2ShowFriendsDialog *dialog = [[Shopping2ShowFriendsDialog alloc] initWithFriends:[chapterRecord friendRecords] pageIndex:lastPageIndex];
		[self showDialog:dialog Callback:@selector(onBuyItem_Done:)];
		[dialog release];
		
		return;
	} 
	
	lastSelectedCreatureIndex = selectedNum;
	
	CreatureRecord *friend = [[chapterRecord friendRecords] objectAtIndex:lastSelectedCreatureIndex];
	
	// Check if the item list is full
	if ([friend.data.itemList count] >= 8) {
		
		NSString *message = [FDLocalString message:62];
		Shopping2MessageDialog *dialog = [[Shopping2MessageDialog alloc] initWithMessage:message];
		[self showDialog:dialog Callback:nil];
		[dialog release];
		
		return;
	} else {
		
		// Buy the item
		[self doBuyItem];
	}
}

-(void) doBuyItem
{
	ItemDefinition *item = [self getItemDefinition:chapterRecord.chapterId Type:DataDepotShopType_ItemShop Index:lastSelectedItemIndex];
	chapterRecord.money -= item.price;
	
	
	CreatureRecord *friend = [[chapterRecord friendRecords] objectAtIndex:lastSelectedCreatureIndex];
	[friend.data.itemList addObject:[NSNumber numberWithInt:item.identifier]];
	
	[(Shopping2Layer *)parentLayer updateMoneyBar];
}


@end
