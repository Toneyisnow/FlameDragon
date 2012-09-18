//
//  VillageScene.h
//  FlameDragon
//
//  Created by sui toney on 12-4-27.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "VillageLayer.h"
#import "ChapterRecord.h"

@interface VillageScene : CCScene {

	VillageLayer *mainLayer;
}

@property (readonly) VillageLayer *mainLayer;

-(void) setChapter:(int)chapter;

-(void) loadWithRecord:(ChapterRecord *) record;

@end
