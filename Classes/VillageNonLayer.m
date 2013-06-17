//
//  VillageNonLayer.m
//  FlameDragon
//
//  Created by sui toney on 13-6-16.
//
//

#import "VillageNonLayer.h"
#import "GameRecord.h"

@implementation VillageNonLayer

/*
+(id) scene
{
    CCScene  *scene = [CCScene node];
    VillageNonLayer *layer = [VillageNonLayer node];
    
    layer.isTouchEnabled = YES;
    
    [scene addChild:layer];
    
    return scene;
}
*/

-(void) loadWithRecord:(ChapterRecord *) record
{
    [super loadWithRecord:record];
    
    // touchCount = 0;
    recordDialog = nil;
    
    confirmSave = [[ConfirmMessage alloc] initWithType:ConfirmMessageType_SaveGame CreatureAniDefId:0];
	[confirmSave setCallback:self Method:@selector(selectSave:)];
	[confirmSave show:self];
}

-(void) ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint clickedLoc = [[CCDirector sharedDirector] convertToGL:location];
    
    if (confirmSave != nil) {
        [confirmSave clickedOn:clickedLoc];
    }
    else if (recordDialog != nil) {
		[recordDialog clickedOn:clickedLoc];
	}
}

-(void) selectSave:(NSNumber *)result
{
    if ([result intValue] != ConfirmMessageResult_Yes) {
		[self doExit];
		return;
	}
	
    recordDialog = [[Shopping2RecordDialog alloc] init];
	// [self showDialog:recordDialog Callback:@selector(confirmSaveGame:)];
	
    [recordDialog setSelectedCallback:self Method:@selector(doSave:)];
	
	[recordDialog setRecord:chapterRecord];
	[recordDialog show:self];
}

-(void) doSave:(NSNumber *)result
{
    int index = [result intValue];
	if (index < 0)
    {
		// Cancel
        [super doExit];
		return;
	}
	
    CCLOG(@"Do Save.");

    if (chapterRecord == nil)
    {
        CCLOG(@"ChapterRecord is nil, ignore the saving.");
    }
    else
    {
        GameRecord *record = [GameRecord readFromSavedFile];
	
        [record setChapterRecord:chapterRecord Index:index];
        [record saveRecord];
	
        CCLOG(@"Game is Saved.");
    }
    
    [super doExit];
}

-(void) dealloc
{
    if (confirmSave != nil) {
        [confirmSave release];
        confirmSave = nil;
    }
    
    if (recordDialog != nil) {
        [recordDialog release];
        recordDialog = nil;
    }
    
    [super dealloc];
}

@end
