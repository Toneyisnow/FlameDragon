//
//  GameLoadedInfo.m
//  FlameDragon
//
//  Created by sui toney on 12-3-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "BattleRecord.h"
#import "ChapterRecord.h"

@implementation BattleRecord

@synthesize turnNo, money;
@synthesize withAllEvents;

-(id) initWithChapter:(int)l
{
	self = [super initWithChapter:l];
	
	friendRecords = [[NSMutableArray alloc] init];
	enemyRecords = [[NSMutableArray alloc] init];
	npcRecords = [[NSMutableArray alloc] init];
	deadCreatureRecords = [[NSMutableArray alloc] init];
	unsettledRecords = [[NSMutableArray alloc] init];
	
	treasureRecords = [[NSMutableArray alloc] init];
	activeEventIds = [[NSMutableArray alloc] init];
	// activeEventIds = nil;
	
	withAllEvents = FALSE;
	
	return self;
}

-(id) initWithTestData
{
	self = [super initWithChapter:1];
	
	turnNo = 3;
	money = 1230;
	
	friendRecords = [[NSMutableArray alloc] init];
	enemyRecords = [[NSMutableArray alloc] init];
	npcRecords = [[NSMutableArray alloc] init];
	deadCreatureRecords = [[NSMutableArray alloc] init];
	
	CreatureRecord *r1 = [[CreatureRecord alloc] initWithTestData];
	[friendRecords addObject:r1];
    [r1 release];
    
	return self;
}

// Note: this method is deprecated
-(id) initWithChapterRecord:(GameStartInfo *)info
{
	ChapterRecord *chapterRecord = (ChapterRecord *)info;
	
	self = [super initWithChapter:chapterRecord.chapterId];
	friendRecords = [chapterRecord friendRecords];
	
	turnNo = 1;
	money = chapterRecord.money;
	
	withAllEvents = TRUE;
	
	return self;
}

-(void) encodeWithCoder:(NSCoder *)coder {
	
	[coder encodeInt:chapterId forKey:@"chapterId"];
    [coder encodeInt:turnNo forKey:@"turnNo"];
    [coder encodeInt:money forKey:@"money"];
	[coder encodeObject:friendRecords forKey:@"friendRecords"];
	[coder encodeObject:enemyRecords forKey:@"enemyRecords"];
	[coder encodeObject:npcRecords forKey:@"npcRecords"];
	[coder encodeObject:deadCreatureRecords forKey:@"deadCreatureRecords"];
	[coder encodeObject:unsettledRecords forKey:@"unsettledRecords"];
	[coder encodeObject:treasureRecords forKey:@"treasureRecords"];
	[coder encodeObject:activeEventIds forKey:@"activeEventIds"];
	
}

-(id) initWithCoder:(NSCoder *)coder {
	
    self = [super init];
    chapterId = [coder decodeIntForKey:@"chapterId"];
    turnNo = [coder decodeIntForKey:@"turnNo"];
    money = [coder decodeIntForKey:@"money"];
	
	friendRecords = (NSMutableArray *)[[coder decodeObjectForKey:@"friendRecords"] retain];
	enemyRecords = (NSMutableArray *)[[coder decodeObjectForKey:@"enemyRecords"] retain];
	npcRecords = (NSMutableArray *)[[coder decodeObjectForKey:@"npcRecords"] retain];
	deadCreatureRecords = (NSMutableArray *)[[coder decodeObjectForKey:@"deadCreatureRecords"] retain];
	unsettledRecords = (NSMutableArray *)[[coder decodeObjectForKey:@"unsettledRecords"] retain];
	treasureRecords = (NSMutableArray *)[[coder decodeObjectForKey:@"treasureRecords"] retain];
	activeEventIds = (NSMutableArray *)[[coder decodeObjectForKey:@"activeEventIds"] retain];
	
    return self;
}

-(NSMutableArray *) friendRecords
{
	return friendRecords;
}
-(NSMutableArray *) enemyRecords
{
	return enemyRecords;
}
-(NSMutableArray *) npcRecords
{
	return npcRecords;
}

-(NSMutableArray *) deadCreatureRecords
{
	return deadCreatureRecords;
}

-(NSMutableArray *) unsettledRecords
{
	return unsettledRecords;
}

-(NSMutableArray *) treasureRecords
{
	return treasureRecords;
}

-(NSMutableArray *) activeEventIds
{
	return activeEventIds;
}

-(void) dealloc
{
	[friendRecords release];
	[enemyRecords release];
	[npcRecords release];
	[deadCreatureRecords release];
	
	[treasureRecords release];
	
	if (activeEventIds != nil) {
		[activeEventIds release];
	}
	
	[super dealloc];
}

@end
