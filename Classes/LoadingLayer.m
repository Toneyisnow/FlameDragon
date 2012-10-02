//
//  LoadingLayer.m
//  FlameDragon
//
//  Created by sui toney on 12-10-2.
//  Copyright 2012 ms. All rights reserved.
//

#import "LoadingLayer.h"
#import "GameRecord.h"
#import "FDLocalString.h"
#import "FDWindow.h"
#import "VillageScene.h"
#import "FDSpriteStore.h"
#import "Constants.h"
#import "TitleScene.h"

@implementation LoadingLayer

-(id) init
{
	self = [super init];
	
	baseSprite = [[FDSpriteStore instance] sprite:@"MessageBox.png"];
	[self addChild:[baseSprite getSprite]];
	
	[baseSprite setScaleX:[Constants villageScale] Y:[Constants villageScale]];
	[baseSprite setLocation:[FDWindow downCenter]];
	[baseSprite retain];
	
	
	GameRecord *record = [GameRecord readFromSavedFile];
	for (int index = 0; index < 4; index ++) {
		ChapterRecord *cRecord = [record getChapterRecord:index];
		NSString *chapterName = [FDLocalString chapterTitle:[cRecord chapterId]];
		CGPoint pos = [FDWindow chapterRecordShowLocation:index];
		
		FDSprite *recordSprite = [[FDSprite alloc] initWithString:chapterName Size:16];
		
		CCMenuItemSprite* menuItem = [CCMenuItemSprite itemFromNormalSprite:[recordSprite getSprite] selectedSprite:NULL target:self selector:@selector(onLoadRecord:)];
		
		menuItem.position = pos;
		menuItem.tag = index;
		menuItem.anchorPoint = ccp(0.5, 0);
		
		CCMenu *menu = [CCMenu menuWithItems:menuItem, nil];
		menu.position = CGPointZero;
		[[baseSprite getSprite] addChild:menu];
		
		[recordSprite release];
	}
	
	FDSprite *backButtonSprite = [[FDSprite alloc] initWithString:[FDLocalString message:65] Size:12];
	CCMenuItemSprite* menuItem = [CCMenuItemSprite itemFromNormalSprite:[backButtonSprite getSprite] selectedSprite:NULL target:self selector:@selector(onBack:)];
	
	menuItem.position = CGPointMake(280, 10);
	menuItem.anchorPoint = ccp(0.5, 0);
	
	CCMenu *menu = [CCMenu menuWithItems:menuItem, nil];
	menu.position = CGPointZero;
	[[baseSprite getSprite] addChild:menu];
	
	[backButtonSprite release];
	
	return self;
}

-(void) onLoadRecord:(id)sender
{
	CCMenuItem *menu = (CCMenuItem *)sender;
	
	if (menu != NULL && menu.tag >= 0) {
		[self doLoadRecord:menu.tag];
	}	
}

-(void) doLoadRecord:(int)index
{
	GameRecord *record = [GameRecord readFromSavedFile];
	ChapterRecord *cRecord = [record getChapterRecord:index];
		
	VillageScene *scene = [VillageScene node];
	[scene loadWithRecord:cRecord];
	
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:scene]];	
}

-(void) onBack:(id)sender
{
	TitleScene *scene = [TitleScene node];
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:scene]];
}


-(void) dealloc
{
	if (baseSprite != nil) {
		[baseSprite removeFromLayer];
		[baseSprite release];
		baseSprite = nil;
	}
	[super dealloc];
}

@end
