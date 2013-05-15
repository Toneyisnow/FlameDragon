//
//  ShoppingBarDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-5-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "ShoppingBarDialog.h"
#import "ButtonFactory.h"
#import "ShoppingRecordDialog.h"
#import "GameRecord.h"
#import "VillageScene.h"
#import "FDLocalString.h"
#import "ShoppingMessageDialog.h"
#import "ShoppingConfirmDialog.h"
#import "TitleScene.h"


@implementation ShoppingBarDialog

-(ShoppingButton *) generateButton1
{
	ShoppingButton *button1 = [ButtonFactory createButton:ShoppingButtonType_Info];
	[button1 setLocation:buttonLocation1];
	return button1;
}

-(ShoppingButton *) generateButton2
{
	ShoppingButton *button2 = [ButtonFactory createButton:ShoppingButtonType_Save];
	[button2 setLocation:buttonLocation2];
	[button2 setCallback:self Method:@selector(onSaveGame)];
	return button2;
}

-(ShoppingButton *) generateButton3
{
	ShoppingButton *button = [ButtonFactory createButton:ShoppingButtonType_Load];
	[button setLocation:buttonLocation3];
	[button setCallback:self Method:@selector(onLoadGame)];
	return button;
}

-(ShoppingButton *) generateButton4
{
	ShoppingButton *button4 = [ButtonFactory createButton:ShoppingButtonType_Exit];
	[button4 setLocation:buttonLocation4];
	[button4 setCallback:self Method:@selector(onExitGame)];
	
	return button4;
}

-(void) onSaveGame
{
	CCLOG(@"onSaveGame");
	ShoppingRecordDialog *dialog = [[ShoppingRecordDialog alloc] initFrom:self];
	[dialog setSelectedCallback:self Method:@selector(confirmSaveGame:)];
	[self onPush:dialog];
	[dialog release];
}

-(void) onLoadGame
{
	CCLOG(@"onLoadGame");
	ShoppingRecordDialog *dialog = [[ShoppingRecordDialog alloc] initFrom:self];
	[dialog setSelectedCallback:self Method:@selector(confirmLoadGame:)];
	[self onPush:dialog];
	[dialog release];	
}

-(void) onExitGame
{
	CCLOG(@"onExitGame");

	NSString *msg = [FDLocalString message:56];
	ShoppingConfirmDialog *dialog = [[ShoppingConfirmDialog alloc] initWithMessage:msg From:self];
	[dialog setSelectedCallback:self Method:@selector(doExitGame:)];
	[self onPush:dialog];
	[dialog release];
}


-(void) confirmSaveGame:(NSNumber *)indexObj
{
	CCLOG(@"confirmSaveGame");
	
	int index = [indexObj intValue];
	
	GameRecord *record = [GameRecord readFromSavedFile];
	ChapterRecord *info = [record getChapterRecord:index];
	
	if ([info chapterId] > 0) {
		// Show confirm dialog
		[self doSaveGame:indexObj];

	}
	else {
		[self doSaveGame:indexObj];
	}
}

-(void) doSaveGame:(NSNumber *)indexObj
{
	CCLOG(@"Do Save Game.");
	
	int index = [indexObj intValue];
	
	GameRecord *record = [GameRecord readFromSavedFile];
		
	[record setChapterRecord:chapterRecord Index:index];
	[record saveRecord];
	
	CCLOG(@"Game is Saved.");
	
	NSString *msg = [FDLocalString message:52];
	ShoppingMessageDialog *dialog = [[ShoppingMessageDialog alloc] initWithMessage:msg From:self];
	[self onPush:dialog];
	[dialog release];
}

-(void) confirmLoadGame:(NSNumber *)indexObj
{
	int index = [indexObj intValue];
	
	GameRecord *record = [GameRecord readFromSavedFile];
	ChapterRecord *info = [record getChapterRecord:index];
	
	if ([info chapterId] > 0) {
		
		// Confirm dialog
		NSString *msg = [FDLocalString message:54];
		ShoppingConfirmDialog *dialog = [[ShoppingConfirmDialog alloc] initWithMessage:msg From:self];
		[dialog setSelectedCallback:self Method:@selector(doLoadGame:)];
		[self onPush:dialog];
		[dialog release];
		
		lastSelectedIndex = index;
		
		//[self doLoadGame:indexObj];
	}	
}

-(void) doLoadGame:(NSNumber *)indexObj
{
	CCLOG(@"Do Load Game.");
	
	bool confirmed = [indexObj boolValue];
	
	if (!confirmed) {
		return;
	}
	
	GameRecord *record = [GameRecord readFromSavedFile];
	ChapterRecord *info = [record getChapterRecord:lastSelectedIndex];

	if ([info chapterId] <= 0) {
		return;
	}
	
	VillageScene *scene = [VillageScene node];
	[scene loadWithRecord:info];
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:scene]];
}

-(void) doExitGame:(NSNumber *)indexObj
{
	TitleScene *scene = [TitleScene node];
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:scene]];
}


@end
