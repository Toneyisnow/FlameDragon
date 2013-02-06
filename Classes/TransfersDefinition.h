//
//  TransfersDefinition.h
//  FlameDragon
//
//  Created by sui toney on 13-2-6.
//  Copyright 2013 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDFileStream.h"
#import "TransferDefinition.h"

@interface TransfersDefinition : NSObject {

	int creatureDefId;
	NSMutableArray *transferArray;
	
}

@property (assign) int creatureDefId;
@property (assign, readonly) NSMutableArray *transferArray;


+(id) readFromFile:(FDFileStream *)stream;

-(TransfersDefinition *) getTransfer:(int)index;
-(int) totalCount;


@end
