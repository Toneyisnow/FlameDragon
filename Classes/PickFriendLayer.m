//
//  PickFriendLayer.m
//  FlameDragon
//
//  Created by sui toney on 13-3-23.
//
//

#import "PickFriendLayer.h"
#import "MainGameScene.h"
#import "DataDepot.h"
#import "Common.h"
#import "Constants.h"
#import "VillageScene.h"

@implementation PickFriendLayer

@synthesize chapterRecord;

-(id) init
{
	self = [super init];
	
    selectedFlag = [[NSMutableArray alloc] init];
    countSprite = nil;
    chapterRecord = nil;
    
	return self;
}

-(void) loadWithRecord:(ChapterRecord *)record
{
	self.chapterRecord = [record retain];
    
    mandatoryList = [[DataDepot depot] getMandatoryPickedFriend:chapterRecord.chapterId];
    
    int startX = 10;
    int startY = 10;
    int intervalX = 40;
    int intervalY = 40;
    
    CCMenu *menu = [CCMenu menuWithItems:nil];
    menu.position = CGPointZero;

    for (int i = 0; i < [[chapterRecord friendRecords] count]; i++) {
        
        int x = i % 8;
        int y = i / 8;
        
        int posX = startX + x * intervalX;
        int posY = startY + y * intervalY;
        
        CCMenuItem *iconMenuItem = [CCMenuItemImage
                                    itemFromNormalImage:[NSString stringWithFormat:@"Icon-%03d-02.png", i+1] selectedImage:NULL
                                    target:self selector:@selector(clickFriend:)];
        iconMenuItem.position = CGPointMake(posX, posY);
        iconMenuItem.tag = i;
        iconMenuItem.anchorPoint = ccp(0, 0);
        
        [selectedFlag addObject:[NSNumber numberWithBool:NO]];
        
        if ([Common containInt:i inArray:mandatoryList]) {
            [self setSelectedFlag:YES toItem:iconMenuItem];
        } else {
            [self setSelectedFlag:NO toItem:iconMenuItem];
        }
        
        [menu addChild:iconMenuItem];
    }
    
    CCMenuItem *okButton = [CCMenuItemImage
                                itemFromNormalImage:@"ConfirmButtonYes.png" selectedImage:NULL
                                target:self selector:@selector(clickOk:)];
    okButton.position = CGPointMake(300, 200);
    [menu addChild:okButton];
    
    CCMenuItem *cancelButton = [CCMenuItemImage
                            itemFromNormalImage:@"ConfirmButtonNo.png" selectedImage:NULL
                            target:self selector:@selector(clickCancel:)];
    cancelButton.position = CGPointMake(340, 200);
    [menu addChild:cancelButton];
    
    [self addChild:menu];

    // Add Label
    [self refreshCountLabel];
}

-(void) refreshCountLabel
{
    if (countSprite != nil) {
        [countSprite removeFromLayer];
        [countSprite release];
    }
    
    NSString *countString = [NSString stringWithFormat:@"%02d / %02d", [self getPickedCount], [Constants maxPickedFriendCount]];
    countSprite = [[FDSprite alloc] initWithString:countString Size:14];
    [countSprite setLocation:CGPointMake(178, 10)];
    [self addChild:[countSprite getSprite]];
}

-(int) getPickedCount
{
    int count = 0;
    for (NSNumber *num in selectedFlag) {
        
        if ([num boolValue] == YES) {
            count ++;
        }
    }
    return count;
}

-(void) clickFriend :(id)sender
{
    NSLog(@"Clicked from sender: %@", sender);
        
    CCMenuItem *menu = (CCMenuItem *)sender;
    // int creatureIndex = menu.tag;

    if ([Common containInt:menu.tag inArray:mandatoryList]) {
        return;
    }
    
    if ([self getPickedCount] >= [Constants maxPickedFriendCount]) {
        return;
    }
    
    // Enable or Disable the Button
    BOOL selected = [[selectedFlag objectAtIndex:menu.tag] boolValue];
    [self setSelectedFlag:!selected toItem:menu];
    
    [self refreshCountLabel];
}

-(void) clickOk :(id)sender
{
    if ([self getPickedCount] != [Constants maxPickedFriendCount]) {
        NSLog(@"The Picked Count (%d) is not fit to MaxPickecFriendCount (%d).", [self getPickedCount], [Constants maxPickedFriendCount]);
        return;
    }
    
    [self doEnterGame];
}

-(void) clickCancel :(id)sender
{
    [self doCancel];
}

-(void) setSelectedFlag:(BOOL)yesOrNo toItem:(CCMenuItem *)item {
    
    if (item == nil || item.tag < 0 || item.tag >= [selectedFlag count]) {
        return;
    }
    
    [selectedFlag replaceObjectAtIndex:item.tag withObject:[NSNumber numberWithBool:yesOrNo]];
    
    // Change the UI
    if (yesOrNo == YES) {
        item.scaleX = item.scaleY = 1.5;
    } else {
        item.scaleX = item.scaleY = 1.0;
    }
}

-(void) doEnterGame {
    
    NSMutableArray *selectedFriends = [[NSMutableArray alloc] init];
    for (int i = 0; i < [[chapterRecord friendRecords] count]; i++) {
        
        if (selectedFlag == nil || [selectedFlag count] <= i) {
            continue;
        }
        
        if ([[selectedFlag objectAtIndex:i] boolValue] == YES) {
            [selectedFriends addObject:[NSNumber numberWithInt:i]];
        }
    }
    
    MainGameScene *mainGame = [MainGameScene node];
    [mainGame loadWithInfo:chapterRecord withSelectedFriends:selectedFriends];
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:mainGame]];
    
    [selectedFriends release];
}

-(void) doCancel {
    
    VillageScene *scene = [VillageScene node];
    [scene loadWithRecord:chapterRecord];
	
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:1.0 scene:scene]];
}

-(void) dealloc {
    
    if (chapterRecord != nil) {
        [chapterRecord release];
        chapterRecord = nil;
    }
    
    if (countSprite != nil) {
        [countSprite removeFromLayer];
        [countSprite release];
    }
    
    [selectedFlag release];
    
    [super dealloc];
}

@end
