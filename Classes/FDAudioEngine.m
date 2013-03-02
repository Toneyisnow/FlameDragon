//
//  FDAudioEngine.m
//  FlameDragon
//
//  Created by sui toney on 13-3-2.
//
//

#import "FDAudioEngine.h"
#import "SimpleAudioEngine.h"


@implementation FDAudioEngine

+(void) playTitleMusic {
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Title.mp3"];
}

+(void) playShopMusic:(AudioShopType)type {
    
    switch (type) {
        case AudioShopType_Amor:
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"ShopAmor.mp3"];
            break;
        case AudioShopType_Item:
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"ShopItem.mp3"];
            break;
        case AudioShopType_Church:
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"ShopChurch.mp3"];
            break;
        case AudioShopType_Bar:
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"ShopBar.mp3"];
            break;
        default:
            break;
    }
}

+(void) playVillageMusic:(int)chapterId {
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Village_1.mp3"];
}

+(void) playBattleGroundMusic:(int)chapterId {
    
    int musicId = 1;
    
    switch (chapterId) {
        case 1: musicId = 2; break;
        case 2:
        case 3: musicId = 5; break;
        case 4:
        case 5: musicId = 4; break;
        case 6:
        case 7:
        case 8:
            musicId = 1;
            break;
        case 9:
        case 10:
        case 11:
        case 12:
        case 13:
        case 14:
        case 15:
            musicId = 3;
            break;
            
        default:
            musicId = 1;
            break;
    }
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:[NSString stringWithFormat:@"Battle_%d.mp3", musicId]];
}

+(void) stopMusic {
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
}


@end
