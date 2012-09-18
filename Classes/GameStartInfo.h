//
//  GameStartInfo.h
//  FlameDragon
//
//  Created by sui toney on 12-3-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"


@interface GameStartInfo : NSObject<NSCoding> {

	int chapterId;
}

-(id) initWithChapter:(int)l;

@property (assign, nonatomic) int chapterId;

@end
