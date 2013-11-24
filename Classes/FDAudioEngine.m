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
        case 1:  musicId = 2; break;
        case 2:  musicId = 1; break;
        case 3:  musicId = 2; break;
        case 4:  musicId = 1; break;
        case 5:  musicId = 2; break;
        case 6:  musicId = 1; break;
        case 7:  musicId = 2; break;
        case 8:  musicId = 1; break;
        case 9:  musicId = 2; break;
        case 10: musicId = 3; break;
        case 11: musicId = 2; break;
        case 12: musicId = 3; break;
        case 13: musicId = 3; break;
        case 14: musicId = 2; break;
        case 15: musicId = 3; break;
        case 16: musicId = 2; break;
        case 17: musicId = 3; break;
        case 18: musicId = 2; break;
        case 19: musicId = 3; break;
        case 20: musicId = 5; break;
        case 21: musicId = 3; break;
        case 22: musicId = 5; break;
        case 23: musicId = 3; break;
        case 24: musicId = 5; break;
        case 25: musicId = 3; break;
        case 26: musicId = 5; break;
        case 27: musicId = 4; break;
        case 28: musicId = 4; break;
        case 29: musicId = 4; break;
        case 30: musicId = 4; break;
        default:
            musicId = 1;
            break;
    }
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:[NSString stringWithFormat:@"Battle_%d.mp3", musicId]];
}

+(void) stopMusic {
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
}


+(void) resumeAudio {
    [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
}

+(void) pauseAudio {
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
}

@end
