//
//  FDFrameDefinition.h
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDSprite.h"

@interface FDFrameDefinition : NSObject {

	int tickCount;
}

-(id) initWithTime:(int) t;

-(void) renderFrame:(FDSprite *)sprite;


@property (nonatomic) int tickCount;

@end
