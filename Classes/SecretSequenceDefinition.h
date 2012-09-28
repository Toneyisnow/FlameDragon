//
//  SecretSequenceDefinition.h
//  FlameDragon
//
//  Created by sui toney on 12-9-28.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDFileStream.h"

@interface SecretSequenceDefinition : NSObject {

	// int chapterId;
	NSMutableArray *sequence;
}

@property (assign, readonly) NSMutableArray *sequence;
// @property (assign) int chapterId;

+(id) readFromFile:(FDFileStream *)stream;
-(int) sequenceAtIndex:(int)ind;
-(int) totalLength;


@end
