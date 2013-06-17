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
	
	// Official Name: FlameDragonII.sav
	return [NSString stringWithFormat:@"%@/FlameDragon1.sav", dir];
}

+(id) readFromSavedFile
{
	return [self readFromSavedFile:[self defaultSavedFileName]];
}

+(id) readFromSavedFile:(NSString *)fileName
{
	if (![[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
		CCLOG(@"Cannot find game state file, create a new instance.");
		return [[[self alloc] init] autorelease];
	}
	
	CCLOG(@"Loading game record from file [%@]", fileName);
	GameRecord *record = nil;
    
    @try {
        record = [[NSKeyedUnarchiver unarchiveObjectWithFile:fileName] retain];
        CCLOG(@"Loaded game record from file [%@]", fileName);
    }
    @catch (NSException *exception) {
        CCLOG(@"Error: Loaded game record from file [%@] error: [%@]", fileName, [exception reason]);
    }
    @finally {
        
    }
    
    if (record == nil) {
        [GameRecord restoreRecord:fileName];
        record = [[NSKeyedUnarchiver unarchiveObjectWithFile:fileName] retain];
        CCLOG(@"Loaded game record from file [%@]", fileName);
    }
    
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
    
    CCLOG(@"Saving game record to: %@", fileName);
    
	NSFileManager *fm = [NSFileManager defaultManager];
	NSError *myerror;
    if ([fm fileExistsAtPath:fileName]) {
        [GameRecord backupRecord:fileName];
        [fm removeItemAtPath:fileName error:&myerror];
    }
	
    @try
    {
        [NSKeyedArchiver archiveRootObject:self toFile:fileName];
	}
    @catch (NSException *ex) {
        CCLOG(@"Error: %@", [ex reason]);
    }
    @finally {
        [fileName release];
    }
}

-(void) encodeWithCoder:(NSCoder *)coder {
	
	[coder encodeObject:battleRecord forKey:@"battleRecord"];
	[coder encodeObject:chapterRecords forKey:@"chapterRecords"];
	
	CCLOG(@"Encoded Finished");
}

-(id) initWithCoder:(NSCoder *)coder {
	
    self = [super init];
    battleRecord = [[coder decodeObjectForKey:@"battleRecord"] retain];
	chapterRecords = [[coder decodeObjectForKey:@"chapterRecords"] retain];
    return self;
}

+(void) backupRecord:(NSString *)fileName {

    NSError *myerror;
    NSString *backupFileName = [NSString stringWithFormat:@"%@.bak", fileName];
    CCLOG(@"Backing up game record to: %@", backupFileName);
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:backupFileName]) {
       [fm removeItemAtPath:backupFileName error:&myerror];
    }
    [fm copyItemAtPath:fileName toPath:backupFileName error:&myerror];
}

+(void) restoreRecord:(NSString *)fileName {
    
    NSError *myerror;
    NSString *backupFileName = [NSString stringWithFormat:@"%@.bak", fileName];
    CCLOG(@"Restoring game record from: %@", backupFileName);
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:fileName]) {
        [fm removeItemAtPath:fileName error:&myerror];
    }
    
    [fm copyItemAtPath:backupFileName toPath:fileName error:&myerror];
}

-(void) dealloc
{
	[battleRecord release];
	[chapterRecords release];
	
	[super dealloc];
}

@end
