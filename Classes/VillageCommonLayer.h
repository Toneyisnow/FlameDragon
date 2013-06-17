//
//  VillageCommonLayer.h
//  FlameDragon
//
//  Created by sui toney on 13-6-16.
//
//

#import "FDLayer.h"
#import "ChapterRecord.h"

@interface VillageCommonLayer : FDLayer {

    ChapterRecord *chapterRecord;
}

@property (retain) ChapterRecord *chapterRecord;

-(void) loadWithRecord:(ChapterRecord *) record;

-(void) doExit;
-(BOOL) needPickFriend:(ChapterRecord *) record;
-(BOOL) needAutoPickFriend:(ChapterRecord *) record;

-(void) takeTick;


@end
