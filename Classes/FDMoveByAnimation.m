//
//  FDMoveToAnimation.m
//  FlameDragon
//
//  Created by sui toney on 13-4-22.
//
//

#import "FDMoveByAnimation.h"

@implementation FDMoveByAnimation

-(id) initWithDelta:(CGPoint)pos WithTick:(int)tick Sprite:(FDSprite *)c
{
    self = [super initWithSprite:c];
    
    currentTick = 0;
    totalTick = (tick > 0) ? tick : 1;
    deltaLocation = pos;
    
    animationStarted = NO;
    return self;
}

+(id) aniWithDelta:(CGPoint)pos WithTick:(int)tick Sprite:(FDSprite *)c
{
    FDMoveByAnimation *ani = [[FDMoveByAnimation alloc] initWithDelta:pos WithTick:tick Sprite:c];
    
    return [ani autorelease];
}

-(void) takeTick:(int)synchronizeTick
{
    if (!animationStarted) {
        [self startAnimation];
    }
    
	currentTick ++;
    
    float x = originalLocation.x + (currentTick * deltaLocation.x/ totalTick);
    float y = originalLocation.y + (currentTick * deltaLocation.y/ totalTick);
    
    [sprite setLocation:CGPointMake(x, y)];
    
    if (currentTick >= totalTick) {
        finished = YES;
    }
}

-(void) startAnimation {
    
    animationStarted = YES;
    originalLocation = [sprite location];
}

-(void) reset
{
	currentTick = 0;
}

@end
