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
	[self setMessage:[FDLocalString message:55]];	
}

-(void) onRevive
{
	NSLog(@"onRevive");
	[self setMessage:[FDLocalString message:56]];
	
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
	
	// TODO: money
	int moneyNeeded = 100;
	if (chapterRecord.money < moneyNeeded) {
		
		// If not enough money
		NSString *message = [FDLocalString message:63];
		Shopping2MessageDialog *dialog = [[Shopping2MessageDialog alloc] initWithMessage:message];
		[self showDialog:dialog Callback:nil];
		[dialog release];
	}
	else {
		
		NSString *msg = [FDLocalString confirm:57];
		Shopping2ConfirmDialog *dialog = [[Shopping2ConfirmDialog alloc] initWithMessage:msg];
		[self showDialog:dialog Callback:@selector(onRevive_Confirmed:)];
		[dialog release];
	}
}

-(void) onRevive_Confirmed:(NSNumber *)num
{
	int selectedNum = [num intValue];
	if (selectedNum <= 0) {
		// Cancel
		return;
	}
	
	[self doRevive];
}

-(void) doRevive
{
	// Revive
	CreatureRecord *friend = [[chapterRecord friendRecords] objectAtIndex:lastSelectedCreatureIndex];
	friend.data.hpCurrent = friend.data.hpMax;
	
	chapterRecord.money -= 100;

	[(Shopping2Layer *)parentLayer updateMoneyBar];

}

-(void) onTransfer
{
	[self setMessage:[FDLocalString message:56]];
	
	BOOL hasTransferFriend = FALSE;
	for (CreatureRecord *friend in [chapterRecord friendRecords]) {
		if (friend.data.level >= 20)
		{
			hasTransferFriend = TRUE;
			break;
		}
	}
	
	if (hasTransferFriend) {
		Shopping2ShowTransferDialog *dialog = [[Shopping2ShowTransferDialog alloc] init];
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
		// Cancel
		return;
	}
	
	lastSelectedCreatureIndex = selectedNum;
	
	NSString *msg = [FDLocalString confirm:58];
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
	[self doTransfer];
	
}

-(void) doTransfer
{
	
	[(Shopping2Layer *)parentLayer updateMoneyBar];
}

@end
