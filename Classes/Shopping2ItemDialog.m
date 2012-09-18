//
//  Shopping2ItemDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2ItemDialog.h"

#import "Shopping2ShowProductDialog.h"
#import "Shopping2ConfirmDialog.h"
#import "Shopping2MessageDialog.h"
#import "Shopping2ShowFriendsDialog.h"

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
	
	Shopping2ShowProductDialog *dialog = [[Shopping2ShowProductDialog alloc] initWithList:shop.itemList];
	[self showDialog:dialog Callback:@selector(onBuyItem_SelectedItem:)];
	[dialog release];
	
}

-(void) onBuyItem_SelectedItem:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		
		// Cancelled
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
		Shopping2ShowFriendsDialog *dialog = [[Shopping2ShowFriendsDialog alloc] init];
		[self showDialog:dialog Callback:@selector(onBuyItem_Done:)];
		[dialog release];
	}
}

-(void) onBuyItem_Done:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		// Cancelled
		
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
	}
}


@end
