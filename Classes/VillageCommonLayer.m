//
//  VillageCommonLayer.m
//  FlameDragon
//
//  Created by sui toney on 13-6-16.
//
//

#import "VillageCommonLayer.h"
#import "PickFriendScene.h"
#import "MainGameScene.h"
#import "Constants.h"

@implementation VillageCommonLayer

@synthesize chapterRecord;

-(void) loadWithRecord:(ChapterRecord *)record
{
	self.chapterRecord = record;
}

-(void) takeTick
{
    // Implement in child class
}

-(void) doExit
{
    CCScene *scene = nil;
    if ([self needPickFriend:chapterRecord]) {
        PickFriendScene *picking = [PickFriendScene node];
        [picking loadWithRecord:chapterRecord];
        scene = picking;
    } else if ([self needAutoPickFriend:chapterRecord]) {
        
        NSMutableArray *selectedFriends = [[NSMutableArray alloc] init];
        for (int i = 0; i < [[chapterRecord friendRecords] count]; i++) {
            CreatureRecord *c = [[chapterRecord friendRecords] objectAtIndex:i];
            [selectedFriends addObject:[NSNumber numberWithInt:c.creatureId]];
        }
        
        MainGameScene *mainGame = [MainGameScene node];
        [mainGame loadWithInfo:chapterRecord withSelectedFriends:selectedFriends];
        scene = mainGame;
        [selectedFriends release];
        
    } else {
        MainGameScene *mainGame = [MainGameScene node];
        [mainGame loadWithInfo:chapterRecord];
        scene = mainGame;
    }
    
	[[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:scene]];
}

-(BOOL) needPickFriend:(ChapterRecord *) record {
    
    return ([[record friendRecords] count] > [Constants maxPickedFriendCount]);
}

-(BOOL) needAutoPickFriend:(ChapterRecord *) record {
    
    CreatureRecord *cRecord = [[record friendRecords] lastObject];
    
    return (cRecord.creatureId > [Constants maxPickedFriendCount:record.chapterId]);
}

@end
