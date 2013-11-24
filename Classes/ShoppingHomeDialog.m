//
//  ShoppingHomeDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-5-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "ShoppingHomeDialog.h"

#import "FDLocalString.h"
#import "DataDepot.h"

#import "ShoppingMessageDialog.h"
#import "ShoppingAmorDialog.h"
#import "ShoppingConfirmDialog.h"
#import "ShoppingShowProductDialog.h"
#import "ShoppingSelectAmorTargetDialog.h"
#import "ShoppingShowFriendsDialog.h"
#import "ShoppingShowItemsDialog.h"
#import "CreatureRecord.h"
#import "ItemBox.h"

@implementation ShoppingHomeDialog

-(id) init
{
	self = [super init];
	
	buttonLocation1 = CGPointMake([baseSprite size].width - 120, 20);
	buttonLocation2 = CGPointMake([baseSprite size].width - 90, 20);
	buttonLocation3 = CGPointMake([baseSprite size].width - 60, 20);
	buttonLocation4 = CGPointMake([baseSprite size].width - 30, 20);
	
	[self addButton:[self generateButton1]];
	[self addButton:[self generateButton2]];
	[self addButton:[self generateButton3]];
	[self addButton:[self generateButton4]];
	
	return self;
}

-(ShoppingButton *) generateButton1
{
	return nil;
}

-(ShoppingButton *) generateButton2
{
	return nil;
}

-(ShoppingButton *) generateButton3
{
	return nil;
}

-(ShoppingButton *) generateButton4
{
	return nil;
}

-(void) onBuyAmor
{
	
	CCLOG(@"onBuyAmor");
	
	// NSMutableArray *list = [self getProductList:chapterRecord.chapterId Type:DataDepotShopType_AmorShop];
	ShopDefinition *shop = [[DataDepot depot] getShopDefinition:chapterRecord.chapterId Type:DataDepotShopType_AmorShop];
	
	ShoppingShowProductDialog *dialog = [[ShoppingShowProductDialog alloc] initWithList:shop.itemList From:self];
	[dialog setSelectedCallback:self Method:@selector(onBuyAmor_SelectedAmor:)];
	[self onPush:dialog];
	[dialog release];
	
	
	//NSString *msg = [NSString stringWithFormat:@"Friend Count: %d", [[chapterRecord friendRecords] count]];
	CCLOG(@"Friend Count: %d", [[chapterRecord friendRecords] count]);
}

-(void) onBuyAmor_SelectedAmor:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		// Cancelled
		
		return;
	} 
	
	CCLOG(@"onBuyAmor_SelectedAmor : %d", selectedNum);
	
	// Confirm Message
	NSString *message = [FDLocalString confirm:54];
	ShoppingConfirmDialog *dialog = [[ShoppingConfirmDialog alloc] initWithMessage:message From:self];
	[dialog setSelectedCallback:self Method:@selector(onBuyAmor_ConfirmedAmor:)];
	[self onPush:dialog];
	[dialog release];
	
}

-(void) onBuyAmor_ConfirmedAmor:(NSNumber *)num
{
	BOOL selectedNum = [num boolValue];
	
	if (selectedNum == FALSE) {
		// Cancelled
		
		[self onBuyAmor];
		return;
	}
	
	lastSelectedItemIndex = selectedNum;
	
	ItemDefinition *item = [self getItemDefinition:chapterRecord.chapterId Type:DataDepotShopType_AmorShop Index:lastSelectedItemIndex];
	if (chapterRecord.money < item.price) {
		
		// If not enough money
		NSString *message = [FDLocalString message:63];
		ShoppingMessageDialog *dialog = [[ShoppingMessageDialog alloc] initWithMessage:message From:self];
		[self onPush:dialog];
		[dialog release];
	}
	else {
		ShoppingSelectAmorTargetDialog *dialog = [[ShoppingSelectAmorTargetDialog alloc] initFrom:self];
		[dialog setSelectedCallback:self Method:@selector(onBuyAmor_SelectedTarget:)];
		[self onPush:dialog];
		[dialog release];
	}
}

-(void) onBuyAmor_SelectedTarget:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		// Cancelled
		
		return;
	} 
	
	lastSelectedCreatureIndex = selectedNum;
	
	// Confirm Message
	NSString *message = [FDLocalString confirm:56];
	ShoppingConfirmDialog *dialog = [[ShoppingConfirmDialog alloc] initWithMessage:message From:self];
	[dialog setSelectedCallback:self Method:@selector(onBuyAmor_Done:)];
	[self onPush:dialog];
	[dialog release];
}

-(void) onBuyAmor_Done:(NSNumber *)num
{
	BOOL selectedNum = [num boolValue];
	
	// Buy that amor
	// ItemDefinition *item = [self getItemDefinition:chapterRecord.chapterId Type:DataDepotShopType_AmorShop Index:lastSelectedItemIndex];
	// int money = item.price;
	
	if (selectedNum) {
		// Equip this item
	}
}

-(void) onSellAmor
{
	
	CCLOG(@"onSellAmor");
	ShoppingShowFriendsDialog *dialog = [[ShoppingShowFriendsDialog alloc] initFrom:self];
	[dialog setSelectedCallback:self Method:@selector(onSellAmor_SelectedFriend:)];
	[self onPush:dialog];
	[dialog release];
	
	
	//NSString *msg = [NSString stringWithFormat:@"Friend Count: %d", [[chapterRecord friendRecords] count]];
	CCLOG(@"Friend Count: %d", [[chapterRecord friendRecords] count]);
}

-(void) onSellAmor_SelectedFriend:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		// Cancel
		
		return;
	}
	
	lastSelectedCreatureIndex = selectedNum;
	
	ShoppingShowItemsDialog *dialog = [[ShoppingShowItemsDialog alloc] initFrom:self];
	[dialog setSelectedCallback:self Method:@selector(onSellAmor_SelectedItem:)];
	[self onPush:dialog];
	[dialog release];
	
}

-(void) onSellAmor_SelectedItem:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		// Cancel
		
		return;
	}
	
	NSString *message = [FDLocalString confirm:55];
	ShoppingConfirmDialog *dialog = [[ShoppingConfirmDialog alloc] initWithMessage:message From:self];
	[dialog setSelectedCallback:self Method:@selector(onSellAmor_Confirm:)];
	[self onPush:dialog];
	[dialog release];
	
}

-(void) onSellAmor_Confirm:(NSNumber *)num
{
	BOOL selectedNum = [num boolValue];
	
	if (!selectedNum) {
		// Cancel
		
		return;
	}
}

-(void) onGiveItem
{
	CCLOG(@"onGiveItem");
	
	NSString *message = [FDLocalString message:58];
	ShoppingMessageDialog *dialog = [[ShoppingMessageDialog alloc] initWithMessage:message From:self];
	[dialog setSelectedCallback:self Method:@selector(onGiveItem_Start:)];
	[self onPush:dialog];
	[dialog release];
	
	
}

-(void) onGiveItem_Start:(NSNumber *)num
{
	ShoppingShowFriendsDialog *dialog = [[ShoppingShowFriendsDialog alloc] initFrom:self];
	[dialog setSelectedCallback:self Method:@selector(onSellAmor_SelectedFriend:)];
	[self onPush:dialog];
	[dialog release];	
}

-(void) onGiveItem_SelectedWhose:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		// Cancel
		
		return;
	}
	
	lastSelectedCreatureIndex = selectedNum;
	
	//NSMutableArray *itemList = [[NSMutableArray alloc] init];
	
	ShoppingShowItemsDialog *dialog = [[ShoppingShowItemsDialog alloc] initFrom:self];
	[dialog setSelectedCallback:self Method:@selector(onGiveItem_SelectedItem:)];
	[self onPush:dialog];
	[dialog release];
}

-(void) onGiveItem_SelectedItem:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		// Cancel
		
		return;
	}
	
	lastSelectedItemIndex = selectedNum;
	
	NSString *message = [FDLocalString message:59];
	ShoppingMessageDialog *dialog = [[ShoppingMessageDialog alloc] initWithMessage:message From:self];
	[dialog setSelectedCallback:self Method:@selector(onGiveItem_Start:)];
	[self onPush:dialog];
	[dialog release];
}

-(void) onGiveItem_ToWhom:(NSNumber *)num
{	
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		// Cancel
		
		return;
	}
	
	CreatureRecord *targetFriend = [[chapterRecord friendRecords] objectAtIndex:selectedNum];
	CreatureRecord *originFriend = [[chapterRecord friendRecords] objectAtIndex:lastSelectedCreatureIndex];
	
	// Check if the item list is full
	if (selectedNum != lastSelectedCreatureIndex && [targetFriend.data.itemList count] >= 8) {
		
		NSString *message = [FDLocalString message:62];
		ShoppingMessageDialog *dialog = [[ShoppingMessageDialog alloc] initWithMessage:message From:self];
		[dialog setSelectedCallback:self Method:@selector(onGiveItem_Start:)];
		[self onPush:dialog];
		[dialog release];
		
		return;
	}
	
	// Item move to target
	NSNumber *itemId = [originFriend.data.itemList objectAtIndex:lastSelectedItemIndex];
	
	[targetFriend.data.itemList addObject:itemId];
	[originFriend.data.itemList removeObjectAtIndex:lastSelectedItemIndex];
	
	
	[self onGiveItem];
}

-(void) onEquip
{
	CCLOG(@"onEquip");
	ShoppingShowFriendsDialog *dialog = [[ShoppingShowFriendsDialog alloc] initFrom:self];
	[dialog setSelectedCallback:self Method:@selector(onEquip_SelectedFriend:)];
	[self onPush:dialog];
	[dialog release];
}

-(void) onEquip_SelectedFriend:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum < 0) {
		// Cancel
		
		return;
	}
	
	/*
	 ItemBox *ibox = [[ItemBox alloc] initWithCreature:creature Type:ItemOperatingType_Equip];
	[ibox show:messageLayer];	
	*/
}

@end
