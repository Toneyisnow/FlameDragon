//
//  FDMoveToAnimation.h
//  FlameDragon
//
//  Created by sui toney on 13-4-22.
//
//

#import "cocos2d.h"
#import "FDAnimation.h"
#import "FDSprite.h"

@interface FDMoveByAnimation : FDAnimation {
    
    int currentTick;
    int totalTick;
    CGPoint originalLocation;
    CGPoint deltaLocation;
    
    BOOL animationStarted;
}

-(id) initWithDelta:(CGPoint)pos WithTick:(int)tick Sprite:(FDSprite *)c;
+(id) aniWithDelta:(CGPoint)pos WithTick:(int)tick Sprite:(FDSprite *)c;

@end
