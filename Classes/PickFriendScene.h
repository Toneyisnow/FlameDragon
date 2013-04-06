//
//  PickFriendScene.h
//  FlameDragon
//
//  Created by sui toney on 13-3-23.
//
//

#import "cocos2d.h"
#import "PickFriendLayer.h"
#import "ChapterRecord.h"

@interface PickFriendScene : CCScene {

    PickFriendLayer *mainLayer;
}

@property (readonly) PickFriendLayer *mainLayer;

-(void) loadWithRecord:(ChapterRecord *) record;


@end
