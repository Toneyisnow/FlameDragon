//
//  PickFriendLayer.h
//  FlameDragon
//
//  Created by sui toney on 13-3-23.
//
//

#import "cocos2d.h"
#import "FDLayer.h"
#import "ChapterRecord.h"
#import "FDSprite.h"

@interface PickFriendLayer : FDLayer {
    
    ChapterRecord *chapterRecord;
	NSMutableArray *mandatoryList;
    NSMutableArray *selectedFlag;
    
    FDSprite *countSprite;
}

@property (retain) ChapterRecord *chapterRecord;

-(void) loadWithRecord:(ChapterRecord *) record;
-(int) getPickedCount;
-(void) setSelectedFlag:(BOOL)yesOrNo toItem:(CCMenuItem *)item;
-(void) doEnterGame;
-(void) refreshCountLabel;

-(void) clickOk :(id)sender;
-(void) clickCancel :(id)sender;

@end
