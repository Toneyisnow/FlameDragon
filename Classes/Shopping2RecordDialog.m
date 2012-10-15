//
//  Shopping2RecordDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-5-29.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2RecordDialog.h"
#import "GameRecord.h"
#import "FDLocalString.h"
#import "FDWindow.h"

@implementation Shopping2RecordDialog


-(id) init
{
	self = [super init];
	
	// Load the Game Records
	GameRecord *record = [GameRecord readFromSavedFile];
	for (int index = 0; index < 4; index ++) {
		ChapterRecord *cRecord = [record getChapterRecord:index];
		NSString *chapterName = [FDLocalString chapterTitle:[cRecord chapterId]];
		CGPoint pos = [FDWindow chapterRecordShowLocation:index];
		
		FDSprite *recordSprite = [[FDSprite alloc] initWithString:chapterName Size:16];
		
		CCMenuItemSprite* menuItem = [CCMenuItemSprite itemFromNormalSprite:[recordSprite getSprite] selectedSprite:NULL target:self selector:@selector(clickedViewOn:)];
		
		menuItem.position = pos;
		menuItem.tag = index;
		menuItem.anchorPoint = ccp(0.5, 0);
		
		CCMenu *menu = [CCMenu menuWithItems:menuItem, nil];
		menu.position = CGPointZero;
		[[baseSprite getSprite] addChild:menu];
		
		[recordSprite release];
		
		// [self addLabel:chapterName Location:CGPointMake(pos.x, pos.y)];
	}
	
	return self;
}

-(void) onClicked:(CGPoint)location
{
	// Do nothing
	
	/*
	id returnedObject = [NSNumber numberWithInt:1];
	[self onExit:returnedObject];
	 */
}




@end
