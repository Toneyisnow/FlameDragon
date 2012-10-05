//
//  GameRecord.m
//  FlameDragon
//
//  Created by sui toney on 12-3-28.
//  Copyright 2012 ms. All rights reserved.
//

#import "GameRecord.h"


@implementation GameRecord

@synthesize battleRecord;


-(id) init
{
	self = [super init];
	
	chapterRecords = [[NSMutableArray alloc] init];
	for (int index = 0; index < 4; index ++) {
		[chapterRecords addObject:[ChapterRecord emptyRecord]];
	}
	
	battleRecord = [[BattleRecord alloc] initWithChapter:0];
	
	return self;
}

+(NSString *) defaultSavedFileName
{
	NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory
														 , NSUserDomainMask
														 , YES) objectAtIndex:0];
	
	return [NSString stringWithFormat:@"%@/FlameDragon1.sav", dir];
}

+(id) readFromSavedFile
{
	return [self readFromSavedFile:[self defaultSavedFileName]];
}

+(id) readFromSavedFile:(NSString *)fileName
{
	if (![[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
		NSLog(@"Cannot find game state file, create a new instance.");
		return [[self alloc] init];
	}
	
	NSLog(@"Loading game record from file [%@]", fileName);
	GameRecord *record = [[NSKeyedUnarchiver unarchiveObjectWithFile:fileName] retain];
	NSLog(@"Loaded game record from file [%@]", fileName);
	
	return [record autorelease];
}

-(void) setBattleRecord:(BattleRecord *)info
{
	if (battleRecord != nil) {
		//[gameLoadedInfo release];
		battleRecord = nil;
	}
	
	battleRecord = [info retain];
}

-(void) setChapterRecord:(ChapterRecord *)info Index:(int)index
{
	[chapterRecords replaceObjectAtIndex:index withObject:info];
}

-(ChapterRecord *) getChapterRecord:(int)index
{
	return [chapterRecords objectAtIndex:index];
}

-(void) saveRecord
{
	[self saveRecord:[GameRecord defaultSavedFileName]];
}

-(void) saveRecord:(NSString *)fileName
{
	[fileName retain];
	NSLog(@"Saving game record to:%@", fileName);
	NSFileManager *fm = [NSFileManager defaultManager];
	if ([fm fileExistsAtPath:fileName]) {
		NSError *myerror;
		[fm removeItemAtPath:fileName error:&myerror];
	}
	
	[NSKeyedArchiver archiveRootObject:self toFile:fileName];
	
	[fileName release];
}

-(void) encodeWithCoder:(NSCoder *)coder {
	
	[coder encodeObject:battleRecord forKey:@"battleRecord"];
	[coder encodeObject:chapterRecords forKey:@"chapterRecords"];
	
	NSLog(@"Encoded Finished");
}

-(id) initWithCoder:(NSCoder *)coder {
	
    self = [super init];
    battleRecord = [[coder decodeObjectForKey:@"battleRecord"] retain];
	chapterRecords = [[coder decodeObjectForKey:@"chapterRecords"] retain];
    return self;
}

-(void) dealloc
{
	[battleRecord release];
	[chapterRecords release];
	
	[super dealloc];
}

@end
