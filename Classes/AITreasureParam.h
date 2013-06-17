//
//  AITreasureParam.h
//  FlameDragon
//
//  Created by sui toney on 13-6-17.
//
//

#import "cocos2d.h"

@interface AITreasureParam : NSObject {
    
    CGPoint escapePosition;
    CGPoint treaturePosition;
}

-(id) initWithTreasurePos:(CGPoint)tPos escapeTo:(CGPoint)ePos;

-(CGPoint) getEscapePosition;
-(CGPoint) getTreasurePosition;

@end
