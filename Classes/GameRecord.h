//
//  GameRecord.h
//  FlameDragon
//
//  Created by sui toney on 12-3-28.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "BattleRecord.h"
#import "ChapterRecord.h"

@interface GameRecord : NSObject {

	BattleRecord *battleRecord;
	NSMutableArray *chapterRecords;
}

+(id) readFromSavedFile;
+(id) readFromSavedFile:(NSString *)fileName;
-(void) saveRecord;
-(void) saveRecord:(NSString *)fileName;

-(void) setBattleRecord:(BattleRecord *)info;
-(void) setChapterRecord:(ChapterRecord *)info Index:(int)index;

-(ChapterRecord *) getChapterRecord:(int)index;

@property (retain, readonly) BattleRecord *battleRecord;
//@property (retain, readonly) NSMutableArray *chapterRecords;

@end
