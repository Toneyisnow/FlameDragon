//
//  Shopping2ShopDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2ShopDialog.h"

#import "Shopping2ShowProductDialog.h"
#import "Shopping2SelectAmorTargetDialog.h"
#import "Shopping2ConfirmDialog.h"
#import "Shopping2MessageDialog.h"
#import "Shopping2ShowItemsDialog.h"
#import "Shopping2ShowFriendsDialog.h"
#import "Shopping2Layer.h"

@implementation Shopping2ShopDialog

// Override Method
-(void) generateButtonArray
{
	[buttonArray addObject:[self button_Buy]];
	[buttonArray addObject:[self button_Sell]];
	[buttonArray addObject:[self button_Equip]];
	[buttonArray addObject:[self button_GiveItem]];
	
}

-(DataDepotShopType) getShopType
{
	return DataDepotShopType_AmorShop;
}

-(NSMutableArray *) getShopItemList:(int)chapterId Type:(DataDepotShopType) shopType
{
    ShopDefinition *shop = [[DataDepot depot] getShopDefinition:chapterRecord.chapterId Type:[self getShopType]];
	
    NSMutableArray *itemList = [NSMutableArray arrayWithArray:shop.itemList];
    // Fix Bug: If the user doesn't have Item 805, here will add one for Chapter 16-22
    if (chapterRecord.chapterId >= 16
        && chapterRecord.chapterId <= 22
        && [self getShopType] == DataDepotShopType_ItemShop
        && [chapterRecord getCreatureThatCarriesItem:805] == nil)
    {
        [itemList addObject:[NSNumber numberWithInt:805]];
    }
    return itemList;
}

-(void) onBuy
{
	NSLog(@"onBuy");
	[self updateMessage];
	
	/*ShopDefinition *shop = [[DataDepot depot] getShopDefinition:chapterRecord.chapterId Type:[self getShopType]];
	
    NSMutableArray *itemList = [NSMutableArray arrayWithArray:shop.itemList];
    //NSMutableArray *itemList = [[NSMutableArray alloc] init];
    //[itemList addObjectsFromArray:shop.itemList];
    // Fix Bug: If the user doesn't have Item 805, here will add one for Chapter 16
    if (chapterRecord.chapterId == 16
        && [self getShopType] == DataDepotShopType_ItemShop
        && [chapterRecord getCreatureThatCarriesItem:805] == nil)
    {
        [itemList addObject:[NSNumber numberWithInt:805]];
    }
    */
    NSMutableArray *itemList = [self getShopItemList:chapterRecord.chapterId Type:[self getShopType]];
	Shopping2ShowItemsDialog *dialog = [[Shopping2ShowItemsDialog alloc] initWithItemList:itemList pageIndex:0];
	
	[self showDialog:dialog Callback:@selector(onBuy_Selected:)];
	[dialog release];
    //[itemList release];
}

-(void) onBuy_Selected:(NSNumber *)num
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
		
		NSMutableArray *itemList = [self getShopItemList:chapterRecord.chapterId Type:[self getShopType]];
        Shopping2ShowItemsDialog *dialog = [[Shopping2ShowItemsDialog alloc] initWithItemList:itemList pageIndex:lastPageIndex];
		[self showDialog:dialog Callback:@selector(onBuy_Selected:)];
		[dialog release];
		
		return;
	} 
	
	NSLog(@"onBuy_Selected : %d", selectedNum);
	
	NSMutableArray *itemList = [self getShopItemList:chapterRecord.chapterId Type:[self getShopType]];
	NSNumber *itemId  = [itemList objectAtIndex:selectedNum];
	
	lastSelectedItemIndex = [itemId intValue];
	ItemDefinition *item = [[DataDepot depot] getItemDefinition:lastSelectedItemIndex];
	
	// Confirm Message
	NSString *message = [NSString stringWithFormat:[FDLocalString confirm:54], item.name, item.price];
	
	Shopping2ConfirmDialog *dialog = [[Shopping2ConfirmDialog alloc] initWithMessage:message];
	[self showDialog:dialog Callback:@selector(onBuy_Confirmed:)];
	[dialog release];
}

-(void) onBuy_Confirmed:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum <= 0) {
		// Cancelled
		
		[self onBuy];
		return;
	}
	
	ItemDefinition *item = [[DataDepot depot] getItemDefinition:lastSelectedItemIndex];
	
	if (chapterRecord.money < item.price) {
		
		// If not enough money
		NSString *message = [FDLocalString message:63];
		Shopping2MessageDialog *dialog = [[Shopping2MessageDialog alloc] initWithMessage:message];
		[self showDialog:dialog Callback:nil];
		[dialog release];
		
		return;
	}
	
	lastPageIndex = 0;
	
	if ([item isAttackItem] || [item isDefendItem]) {
	
		Shopping2SelectAmorTargetDialog *dialog = [[Shopping2SelectAmorTargetDialog alloc] initWithFriends:[chapterRecord friendRecords] itemId:item.identifier pageIndex:0];
		[self showDialog:dialog Callback:@selector(onBuyAmor_SelectedTarget:)];
		[dialog release];
	} else {
	
		Shopping2ShowFriendsDialog *dialog = [[Shopping2ShowFriendsDialog alloc] initWithFriends:[chapterRecord friendRecords] pageIndex:0];
		[self showDialog:dialog Callback:@selector(onBuyItem_Done:)];
		[dialog release];
	}
}

-(void) onBuyAmor_SelectedTarget:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		
		if (selectedNum == -1) return;
		lastPageIndex = (selectedNum == -2) ? lastPageIndex - 1 : ((selectedNum == -3) ? lastPageIndex + 1 : 0);
		
		Shopping2SelectAmorTargetDialog *dialog = [[Shopping2SelectAmorTargetDialog alloc] initWithFriends:[chapterRecord friendRecords] itemId:lastSelectedItemIndex pageIndex:lastPageIndex];
		[self showDialog:dialog Callback:@selector(onBuyAmor_SelectedTarget:)];
		[dialog release];
		
		return;
	} 
	
	lastSelectedCreatureIndex = selectedNum;
	
	CreatureRecord *friend = [[chapterRecord friendRecords] objectAtIndex:lastSelectedCreatureIndex];
	
	// Check if the item list is full
	if ([friend.data.itemList count] >= [CreatureData ITEM_MAX]) {
		
		NSString *creatureName = [FDLocalString creature:friend.definitionId];
		NSString *message = [NSString stringWithFormat:[FDLocalString message:62], creatureName];
		Shopping2MessageDialog *dialog = [[Shopping2MessageDialog alloc] initWithMessage:message];
		[self showDialog:dialog Callback:nil];
		[dialog release];
		
		return;
	} else {
		
		// Confirm Message
		NSString *message = [FDLocalString confirm:56];
		Shopping2ConfirmDialog *dialog = [[Shopping2ConfirmDialog alloc] initWithMessage:message];
		[self showDialog:dialog Callback:@selector(onBuyAmor_Done:)];
		[dialog release];
	}
}

-(void) onBuyAmor_Done:(NSNumber *)num
{
	int selectedNum = [num intValue];
		
	// Buy that amor
	[self doBuyItem:(selectedNum == 1)];
	
	NSLog(@"Amor Bought");
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
	if ([friend.data.itemList count] >= [CreatureData ITEM_MAX]) {
		
		NSString *creatureName = [FDLocalString creature:friend.definitionId];
		NSString *message = [NSString stringWithFormat:[FDLocalString message:62], creatureName];
		Shopping2MessageDialog *dialog = [[Shopping2MessageDialog alloc] initWithMessage:message];
		[self showDialog:dialog Callback:nil];
		[dialog release];
		
		return;
	} else {
		
		// Buy the item
		[self doBuyItem:FALSE];
	}
}


-(void) doBuyItem:(BOOL)equip
{
	// Buy that amor
	ItemDefinition *item = [[DataDepot depot] getItemDefinition:lastSelectedItemIndex];
	if (item == nil) {
		NSLog(@"Item Error: doBuyItem Failed. Cannot find item with index %d.", lastSelectedItemIndex);
		return;
	}
	
	chapterRecord.money -= item.price;
	
	CreatureRecord *friend = [[chapterRecord friendRecords] objectAtIndex:lastSelectedCreatureIndex];
	[friend.data.itemList addObject:[NSNumber numberWithInt:lastSelectedItemIndex]];

	int itemIndex = [friend.data.itemList count] - 1;
	if (equip) {
		// Equip this item
		if ([item isAttackItem]) {
			friend.data.attackItemIndex = itemIndex;
		}
		if ([item isDefendItem]) {
			friend.data.defendItemIndex = itemIndex;
		}
	}
	
	[(Shopping2Layer *)parentLayer updateMoneyBar];
}

@end
