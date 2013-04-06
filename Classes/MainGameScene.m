//
//  MainGameScene.m
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "MainGameScene.h"
#import "ActionDispatcher.h"
#import "ActionLayers.h"
#import "EventLoaderFactory.h"
#import "AIHandler.h"
#import "BattleRecord.h"
#import "ChapterRecord.h"

@implementation MainGameScene


-(id) init
{
	self = [super init];
	return self;
}

-(void) loadWithInfo:(GameStartInfo *)info
{
    [self loadWithInfo:info withSelectedFriends:nil];
}

-(void) loadWithInfo:(GameStartInfo *)info withSelectedFriends:(NSMutableArray *)selectedList
{
	fieldLayer = [BattleFieldLayer node];
	messageLayer = [MessageLayer node];
	controlLayer = [ControlLayer node];
	
	[fieldLayer loadChapter:info.chapterId];
	
	layers = [[ActionLayers alloc] initWithField:fieldLayer Message:messageLayer];
	ActionDispatcher *dispatcher = [[ActionDispatcher alloc] initWithLayers:layers];
	[controlLayer setDispatcher:dispatcher];
	[dispatcher release];
	
	// add layer as a child to scene
	[self addChild: fieldLayer];
	[self addChild: messageLayer];
	[self addChild: controlLayer];
	[self schedule: @selector(step:)];
	
	[[[AIHandler alloc] initEnemyHandlerWithLayers:layers] autorelease];
	[[[AIHandler alloc] initNpcHandlerWithLayers:layers] autorelease];
	
	// Listeners
	
	eventLoader = [[EventLoaderFactory createEventLoader:info.chapterId] retain];
	[eventLoader loadWithLayers:layers];
	
	if ([info isKindOfClass:[ChapterRecord class]]) {
		[layers startNewGame:(ChapterRecord *)info withSelectedFriends:selectedList];
	} else if ([info isKindOfClass:[BattleRecord class]]) {
		[layers loadGame:(BattleRecord *)info];
	}

}

-(void) step: (ccTime) delta
{
	[layers takeTick];
}

- (void) dealloc
{
	[layers release];
	[eventLoader release];
	[super dealloc];
}



@end
