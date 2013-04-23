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
    self = [super init];
    
    return self;
}

+(id) aniWithDelta:(CGPoint)pos WithTick:(int)tick Sprite:(FDSprite *)c
{
    FDMoveByAnimation *ani = [[FDMoveByAnimation alloc] initWithDelta:pos WithTick:tick Sprite:c];
    
    return [ani autorelease];
}

-(void) takeTick:(int)synchronizeTick
{
	
}

@end
