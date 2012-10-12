//
//  FDSpriteStore.h
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDImage.h"
#import "FDSprite.h"

@interface FDSpriteStore : NSObject {

	NSMutableDictionary *spriteDictionary;
	NSMutableDictionary *imageDictionary;
}

+(id) instance;

-(FDImage *) image:(NSString *)fileName;
-(FDSprite *) sprite:(NSString *)fileName;
//-(FDSprite *) sprite:(NSString *)fileName Id:(int)i;

// NOTE: this is not used yet
-(FDSprite *) iconFile:(int)iconFileIndex Pos:(int)pos;

-(FDSprite *) emptySprite;


@end
