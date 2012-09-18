//
//  ShoppingScene.h
//  FlameDragon
//
//  Created by sui toney on 12-4-27.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "Shopping2Layer.h"
#import "ChapterRecord.h"

@interface ShoppingScene : CCScene {

	Shopping2Layer *mainLayer;
}

-(void) loadWithRecord:(ChapterRecord *) record Type:(Shopping2Type)type;

@end
