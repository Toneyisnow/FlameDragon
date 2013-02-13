//
//  Shopping2ChurchDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2ChurchDialog.h"

#import "Shopping2ShowDeadFriendsDialog.h"
#import "Shopping2ShowTransferDialog.h"
#import "Shopping2ConfirmDialog.h"
#import "Shopping2MessageDialog.h"
#import "Shopping2Layer.h"

#import "GameFormula.h"
#import "FDRandom.h"

@implementation Shopping2ChurchDialog

// Override Method
-(void) generateButtonArray
{
	[buttonArray addObject:[self button_Info]];
	[buttonArray addObject:[self button_GiveItem]];
	[buttonArray addObject:[self button_Revive]];
	[buttonArray addObject:[self button_Transfer]];
}

-(void) initMessage
{
	transferFee = 300;
	[self setMessage:[FDLocalString message:55]];	
}

-(void) updateMessage
{
	[self setMessage:[FDLocalString message:56]];	
}

-(void) onRevive
{
	NSLog(@"onRevive");
	[self updateMessage];
	
	BOOL hasDeadFriend = FALSE;
	for (CreatureRecord *friend in [chapterRecord friendRecords]) {
		if (friend.data.hpCurrent == 0)
		{
			hasDeadFriend = TRUE;
			break;
		}
	}
	
	if (hasDeadFriend) {
		lastPageIndex = 0;
		Shopping2ShowDeadFriendsDialog *dialog = [[Shopping2ShowDeadFriendsDialog alloc] initWithFriends:[chapterRecord friendRecords] pageIndex:0];
		[self showDialog:dialog Callback:@selector(onRevive_SelectedFriend:)];
		[dialog release];
	}
	else {
		NSString *msg = [FDLocalString message:60];
		Shopping2MessageDialog *dialog = [[Shopping2MessageDialog alloc] initWithMessage:msg];
		[self showDialog:dialog Callback:nil];
		[dialog release];
	}

}

-(void) onRevive_SelectedFriend:(NSNumber *)num
{
	int selectedNum = [num intValue];
	if (selectedNum < 0) {
		if (selectedNum == -1) return;
		lastPageIndex = (selectedNum == -2) ? lastPageIndex - 1 : ((selectedNum == -3) ? lastPageIndex + 1 : 0);
		Shopping2ShowDeadFriendsDialog *dialog = [[Shopping2ShowDeadFriendsDialog alloc] initWithFriends:[chapterRecord friendRecords] pageIndex:lastPageIndex];
		[self showDialog:dialog Callback:@selector(onRevive_SelectedFriend:)];
		[dialog release];
		
		return;
	}
	
	lastSelectedCreatureIndex = selectedNum;
	
	CreatureRecord *friend = [[chapterRecord friendRecords] objectAtIndex:lastSelectedCreatureIndex];
	int moneyNeeded = [GameFormula getMoneyNeededForRevive:friend];
	NSString *msg = [NSString stringWithFormat:[FDLocalString confirm:57], [FDLocalString creature:friend.definitionId], moneyNeeded];
	Shopping2ConfirmDialog *dialog = [[Shopping2ConfirmDialog alloc] initWithMessage:msg];
	[self showDialog:dialog Callback:@selector(onRevive_Confirmed:)];
	[dialog release];

}

-(void) onRevive_Confirmed:(NSNumber *)num
{
	int selectedNum = [num intValue];
	if (selectedNum <= 0) {
		// Cancel
		return;
	}
	
	CreatureRecord *friend = [[chapterRecord friendRecords] objectAtIndex:lastSelectedCreatureIndex];
	int moneyNeeded = [GameFormula getMoneyNeededForRevive:friend];
	if (chapterRecord.money < moneyNeeded) {
		
		// If not enough money
		NSString *message = [FDLocalString message:63];
		Shopping2MessageDialog *dialog = [[Shopping2MessageDialog alloc] initWithMessage:message];
		[self showDialog:dialog Callback:nil];
		[dialog release];
		return;
	}
	
	[self doRevive];
}

-(void) doRevive
{
	// Revive
	CreatureRecord *friend = [[chapterRecord friendRecords] objectAtIndex:lastSelectedCreatureIndex];
	friend.data.hpCurrent = friend.data.hpMax;
	
	int moneyNeeded = [GameFormula getMoneyNeededForRevive:friend];
	
	chapterRecord.money -= moneyNeeded;

	[(Shopping2Layer *)parentLayer updateMoneyBar];
}

-(void) onTransfer
{
	[self updateMessage];
	
	BOOL hasTransferFriend = FALSE;
	for (CreatureRecord *friend in [chapterRecord friendRecords]) {
		
		int definitionId = friend.definitionId;
		if (friend.data.level >= 20 && [[DataDepot depot] getTransfersDefinition:definitionId] != nil)
		{
			hasTransferFriend = TRUE;
			break;
		}
	}
	
	// TODO: Before we have transfer function
	// hasTransferFriend = FALSE;
	
	if (hasTransferFriend) {
		
		Shopping2ShowTransferDialog *dialog = [[Shopping2ShowTransferDialog alloc] initWithFriends:[chapterRecord friendRecords] pageIndex:lastPageIndex];
		[self showDialog:dialog Callback:@selector(onTransfer_SelectedFriend:)];
		[dialog release];
	}
	else {
		NSString *msg = [FDLocalString message:61];
		Shopping2MessageDialog *dialog = [[Shopping2MessageDialog alloc] initWithMessage:msg];
		[self showDialog:dialog Callback:nil];
		[dialog release];
	}
	
}

-(void) onTransfer_SelectedFriend:(NSNumber *)num
{
	int selectedNum = [num intValue];
	if (selectedNum < 0) {
		
		if (selectedNum == -1) return;
		lastPageIndex = (selectedNum == -2) ? lastPageIndex - 1 : ((selectedNum == -3) ? lastPageIndex + 1 : 0);
		
		Shopping2ShowTransferDialog *dialog = [[Shopping2ShowTransferDialog alloc] initWithFriends:[chapterRecord friendRecords] pageIndex:lastPageIndex];
		[self showDialog:dialog Callback:@selector(onTransfer_SelectedFriend:)];
		[dialog release];
		
		return;
	}
	
	lastSelectedItemIndex = selectedNum;
	
	TransferDefinition *transfer = [[DataDepot depot] getTransferDefinition:lastSelectedItemIndex];
	CreatureDefinition *creature = [[DataDepot depot] getCreatureDefinition:transfer.fromCreatureDefId];
	CreatureDefinition *creatureNew = [[DataDepot depot] getCreatureDefinition:transfer.toCreatureDefId];
	NSString *occupationNewName = [creatureNew getOccupationString];
	
	NSString *msg = [NSString stringWithFormat:[FDLocalString confirm:58], [creature getNameString], occupationNewName, transferFee];
	Shopping2ConfirmDialog *dialog = [[Shopping2ConfirmDialog alloc] initWithMessage:msg];
	[self showDialog:dialog Callback:@selector(onTransfer_Confirm:)];
	[dialog release];
	
}

-(void) onTransfer_Confirm:(NSNumber *)num
{
	int selectedNum = [num intValue];
	if (selectedNum <= 0) {
		// Cancel
		return;
	}
	
	// Transfer the career of the friend
	if (chapterRecord.money >= transferFee) {
		[self doTransfer];
	}
	else {
		NSString *msg = [FDLocalString message:63];
		Shopping2MessageDialog *dialog = [[Shopping2MessageDialog alloc] initWithMessage:msg];
		[self showDialog:dialog Callback:nil];
		[dialog release];
	}
	
}

-(void) doTransfer
{
	TransferDefinition *transfer = [[DataDepot depot] getTransferDefinition:lastSelectedItemIndex];
	
	if (transfer == nil) {
		NSLog(@"Error:Did not find the Transfer with Id = %d to transfer.", transfer.transferId);
		return;
	}
	
	CreatureRecord *friend = nil;
	for (CreatureRecord *r in [chapterRecord friendRecords]) {
		if (r.creatureId == transfer.fromCreatureDefId) {
			friend = r;
			break;
		}
	}
	
	if (friend == nil) {
		NSLog(@"Error:Did not find the Friend with DefinitionId = %d to transfer.", transfer.fromCreatureDefId);
		return;
	}
	
	if (transfer.requireItemId != 0) {
		
		if (![friend.data hasItem:transfer.requireItemId]) {
			NSLog(@"Error:The Creature %d doesn't have the item that support this transfer %d.", friend.creatureId, transfer.requireItemId);
			return;
		}
		
		[friend.data removeItemWithId:transfer.requireItemId];
	}
	
	chapterRecord.money -= transferFee;
	
	// Update the Creature Data
	friend.definitionId = transfer.toCreatureDefId;
	friend.data.level = 1;
	friend.data.ap += [FDRandom fromRange:transfer.apRange];
	friend.data.dp += [FDRandom fromRange:transfer.dpRange];
	friend.data.dx += [FDRandom fromRange:transfer.dxRange];
	friend.data.hpMax += [FDRandom fromRange:transfer.hpRange];
	friend.data.mpMax += [FDRandom fromRange:transfer.mpRange];
	friend.data.mv += [FDRandom fromRange:transfer.mvRange];
	friend.data.hpCurrent = friend.data.hpMax;
	friend.data.mpCurrent = friend.data.mpMax;
	
	[(Shopping2Layer *)parentLayer updateMoneyBar];
}

@end
