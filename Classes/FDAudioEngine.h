//
//  FDAudioEngine.h
//  FlameDragon
//
//  Created by sui toney on 13-3-2.
//
//

#import "cocos2d.h"

typedef enum AudioShopType {
    AudioShopType_Amor,
    AudioShopType_Item,
    AudioShopType_Church,
    AudioShopType_Bar
} AudioShopType;

@interface FDAudioEngine : NSObject

+(void) playTitleMusic;
+(void) playEndingMusic;
+(void) playShopMusic:(AudioShopType)type;
+(void) playVillageMusic:(int)chapterId;
+(void) playBattleGroundMusic:(int)chapterId;
+(void) stopMusic;

+(void) resumeAudio;
+(void) pauseAudio;

@end
