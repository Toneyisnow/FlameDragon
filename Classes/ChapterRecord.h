//
//  GameNewInfo.h
//  FlameDragon
//
//  Created by sui toney on 12-3-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "GameStartInfo.h"


@interface ChapterRecord : GameStartInfo {

	int money;
	NSMutableArray *friendRecords;
	
}

-(NSMutableArray *) friendRecords;

+(ChapterRecord *) emptyRecord;
+(ChapterRecord *) sampleRecord;
+(ChapterRecord *) generateRecord:(int)chapter money:(int)m;

@property (nonatomic, assign) int money;



@end
