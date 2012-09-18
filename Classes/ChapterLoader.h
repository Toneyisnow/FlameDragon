//
//  ChapterLoader.h
//  FlameDragon
//
//  Created by sui toney on 11-11-11.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDSprite.h"
#import "GroundField.h"

@interface ChapterLoader : NSObject {

	int chapterNumber;
	
	FDSprite *mapImage;
	
	GroundField *ground;
	
	//CGSize fieldSize;
}

-(id) initWithId:(int)num;

-(FDSprite *) getMapImage;

-(GroundField *) getGroundField;

//-(CGSize) getFieldSize;

@end
