//
//  Shopping2BarDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2BarDialog.h"
#import "Shopping2RecordDialog.h"
#import "Shopping2ConfirmDialog.h"
#import "Shopping2MessageDialog.h"

#import "VillageScene.h"
#import "TitleScene.h"

@implementation Shopping2BarDialog

// Override Method
-(void) generateButtonArray
{
	[buttonArray addObject:[self button_Info]];
	[buttonArray addObject:[self button_Save]];
	[buttonArray addObject:[self button_Load]];
	[buttonArray addObject:[self button_Exit]];
}

-(void) onSaveGame
{
	NSLog(@"onSaveGame");
	Shopping2RecordDialog *dialog = [[Shopping2RecordDialog alloc] init];
	[self showDialog:dialog Callback:@selector(confirmSaveGame:)];
	[dialog release];
}

-(void) onLoadGame
{
	NSLog(@"onLoadGame");
	Shopping2RecordDialog *dialog = [[Shopping2RecordDialog alloc] init];
	[self showDialog:dialog Callback:@selector(confirmLoadGame:)];
	[dialog release];	
}

-(void) onExitGame
{
	NSLog(@"onExitGame");
	
	NSString *msg = [FDLocalString confirm:53];
	Shopping2ConfirmDialog *dialog = [[Shopping2ConfirmDialog alloc] initWithMessage:msg];
	[self showDialog:dialog Callback:@selector(doExitGame:)];
	[dialog release];
}


-(void) confirmSaveGame:(NSNumber *)indexObj
{
	NSLog(@"confirmSaveGame");
	
	int index = [indexObj intValue];
	if (index < 0) {
		// Cancel
		return;
	}
	
	lastSelectedItemIndex = index;
	
	GameRecord *record = [GameRecord readFromSavedFile];
	ChapterRecord *info = [record getChapterRecord:index];
	
	if ([info chapterId] > 0) {
		// Show confirm dialog
		NSString *msg = [FDLocalString confirm:51];
		Shopping2ConfirmDialog *dialog = [[Shopping2ConfirmDialog alloc] initWithMessage:msg];
		[self showDialog:dialog Callback:@selector(doSaveGame:)];
		[dialog release];	
	}
	else {
		[self doSaveGame:[NSNumber numberWithInt:1]];
	}
}

-(void) doSaveGame:(NSNumber *)num
{
	int selectedNum = [num intValue];
	
	if (selectedNum <= 0) {
		
		// Cancel
		return;
	}
		
	NSLog(@"Do Save Game.");
	
	GameRecord *record = [GameRecord readFromSavedFile];
	
	[record setChapterRecord:chapterRecord Index:selectedNum];
	[record saveRecord];
	
	NSLog(@"Game is Saved.");
	
	NSString *msg = [FDLocalString message:57];
	Shopping2MessageDialog *dialog = [[Shopping2MessageDialog alloc] initWithMessage:msg];
	[self showDialog:dialog Callback:nil];
	[dialog release];
}

-(void) confirmLoadGame:(NSNumber *)indexObj
{
	int index = [indexObj intValue];
	
	if (index < 0) {
		// Cancel
		return;
	}
	
	GameRecord *record = [GameRecord readFromSavedFile];
	ChapterRecord *info = [record getChapterRecord:index];
	
	lastSelectedItemIndex = index;
	
	
	if ([info chapterId] > 0) {
		
		
		// Confirm dialog
		NSString *msg = [FDLocalString confirm:52];
		Shopping2ConfirmDialog *dialog = [[Shopping2ConfirmDialog alloc] initWithMessage:msg];
		[self showDialog:dialog Callback:@selector(doLoadGame:)];
		[dialog release];
				
		//[self doLoadGame:indexObj];
	}	
}

-(void) doLoadGame:(NSNumber *)indexObj
{
	NSLog(@"Do Load Game.");
	
	int confirmed = [indexObj intValue];
	
	if (confirmed <= 0) {
		return;
	}
	
	GameRecord *record = [GameRecord readFromSavedFile];
	ChapterRecord *info = [record getChapterRecord:lastSelectedItemIndex];
	
	if ([info chapterId] <= 0) {
		return;
	}
	
	VillageScene *scene = [VillageScene node];
	[scene loadWithRecord:info];
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:scene]];
}

-(void) doExitGame:(NSNumber *)indexObj
{
	int index = [indexObj intValue];
	
	if (index <= 0) {
		// Cancel
		return;
	}
	
	TitleScene *scene = [TitleScene node];
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:scene]];
}


@end
