//
//  AITreasureParam.m
//  FlameDragon
//
//  Created by sui toney on 13-6-17.
//
//

#import "AITreasureParam.h"

@implementation AITreasureParam

-(id) initWithTreasurePos:(CGPoint)tPos escapeTo:(CGPoint)ePos
{
    self = [super init];
    
    treaturePosition = tPos;
    escapePosition = ePos;
    return self;
}

-(CGPoint) getEscapePosition
{
    return escapePosition;
}

-(CGPoint) getTreasurePosition
{
    return treaturePosition;
}

@end
