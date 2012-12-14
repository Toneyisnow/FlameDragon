//
//  TitleLayer.m
//  FlameDragon
//
//  Created by sui toney on 11-12-27.
//  Copyright 2011 ms. All rights reserved.
//

#import "TitleLayer.h"
#import "MainGameScene.h"
#import "FDSpriteStore.h"
#import "FDWindow.h"
#import "GameRecord.h"
#import "VillageScene.h"
#import "LoadingScene.h"
#import "Constants.h"

@implementation TitleLayer

-(id) init
{
	self = [super init];
	
	
	FDSprite *bg = [[FDSpriteStore instance] sprite:@"Title.png"];
	[bg setScaleX:[Constants commonScale] Y:[Constants commonScale]];
	[bg setLocation:[FDWindow screenCenter]];
	
	FDSprite *startButton = [[FDSpriteStore instance] sprite:@"Title_Start_1.png"];
	[startButton setScaleX:[Constants commonScale] Y:[Constants commonScale]];
	[startButton setLocation:[FDWindow titleButtonStart]];
	
	FDSprite *loadButton = [[FDSpriteStore instance] sprite:@"Title_Load_1.png"];
	[loadButton setScaleX:[Constants commonScale] Y:[Constants commonScale]];
	[loadButton setLocation:[FDWindow titleButtonLoad]];
	
	FDSprite *continueButton = [[FDSpriteStore instance] sprite:@"Title_Continue_1.png"];
	[continueButton setScaleX:[Constants commonScale] Y:[Constants commonScale]];
	[continueButton setLocation:[FDWindow titleButtonContinue]];
	
	[self addChild:[bg getSprite]];
	[self addChild:[startButton getSprite]];
	[self addChild:[loadButton getSprite]];
	[self addChild:[continueButton getSprite]];
	
	return self;
}

-(void) ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint clickedLoc = [[CCDirector sharedDirector] convertToGL:location];
	
	if ([self clickedOnButton:[FDWindow titleButtonStart] At:clickedLoc])
	{
		[self onNewGame];
	}
	else if ([self clickedOnButton:[FDWindow titleButtonLoad] At:clickedLoc]) {
		[self onLoadGame];
	}
	else if ([self clickedOnButton:[FDWindow titleButtonContinue] At:clickedLoc]) {
		[self onContinueGame];
	}
}

-(BOOL) clickedOnButton:(CGPoint)buttonLoc At:(CGPoint)clickedLoc
{
	return (clickedLoc.x > buttonLoc.x - 80 && clickedLoc.x < buttonLoc.x + 80 && 
			clickedLoc.y > buttonLoc.y - 20 && clickedLoc.y < buttonLoc.y + 20);
}

-(void) onNewGame
{
	NSLog(@"onNewGame");
	
	//GameStartInfo *info = [[ChapterRecord alloc] initWithChapter:1];
	GameStartInfo *info = [[ChapterRecord alloc] initWithChapter:99];
	
	MainGameScene *mainGame = [MainGameScene node];
	[mainGame loadWithInfo:info];
	
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:mainGame]];
	
}

-(void) onLoadGame
{
	NSLog(@"onLoadGame");
	
	[self loadTestingGame];
	
	// LoadingScene *scene = [LoadingScene node];
	// [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:scene]];
}

-(void) onContinueGame
{
	NSLog(@"onContinueGame");
	
	//GameStartInfo *info = [[GameLoadedInfo alloc] initWithLevel:1];
	//GameStartInfo *info = [[GameLoadedInfo alloc] readFromFile:nil];
	
	GameRecord *record = [GameRecord readFromSavedFile];
	GameStartInfo *info = [record.battleRecord retain];
	//[record saveRecord];
	
	if (info.chapterId > 0) {
		
		MainGameScene *mainGame = [MainGameScene node];
		[mainGame loadWithInfo:info];
	
		[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:mainGame]];
	}
	
	[info release];
}

-(void) loadTestingGame
{
	ChapterRecord *record = [ChapterRecord generateRecord:6 money:4000];
	
	[[record friendRecords] addObject:[self loadTestingRecord:1 level:12]];
	[[record friendRecords] addObject:[self loadTestingRecord:2 level:12]];
	[[record friendRecords] addObject:[self loadTestingRecord:3 level:12]];
	[[record friendRecords] addObject:[self loadTestingRecord:4 level:12]];
	[[record friendRecords] addObject:[self loadTestingRecord:5 level:12]];
	[[record friendRecords] addObject:[self loadTestingRecord:6 level:12]];
	[[record friendRecords] addObject:[self loadTestingRecord:7 level:12]];
	[[record friendRecords] addObject:[self loadTestingRecord:8 level:12]];
	
	VillageScene *scene = [VillageScene node];
	[scene loadWithRecord:record];
	
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:scene]];
}

-(CreatureRecord *) loadTestingRecord:(int)creatureId level:(int)level
{
	FDFriend *creature = [[FDFriend alloc] initWithDefinition:creatureId Id:creatureId];
	
	for (int i = creature.data.level; i < level; i++) {
		[creature levelUp];
	}
	
	CreatureRecord *r = [[CreatureRecord alloc] init];
	r.creatureId = [creature getIdentifier];
	r.definitionId = [[creature getDefinition] getId];
	r.creatureType = [creature getCreatureType];
	
	r.data = [creature.data clone];
	r.data.hpCurrent = r.data.hpMax;
	r.data.mpCurrent = r.data.mpMax;
	
	[creature release];
	
	return r;
}

@end
