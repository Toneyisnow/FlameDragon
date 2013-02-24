//
//  GroundField.h
//  FlameDragon
//
//  Created by sui toney on 11-11-9.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "GroundBlock.h"
#import "FDFileStream.h"
#import "FDIntMap.h"

@interface GroundField : NSObject {

	CGSize fieldSize;
	NSMutableArray *blockList;
	
	NSMutableDictionary *backgroundDic;
    
    FDIntMap *groundMapForGround;
    FDIntMap *groundMapForFly;
    
}

-(id) initWithDefinitionStream:(FDFileStream *)fileStream;

-(CGSize) fieldSize;

-(GroundBlock *) blockAtX:(int)x Y:(int)y;

-(int) fightBackgroundIdAtX:(int)x Y:(int)y;

-(FDIntMap *) getGroundMapForGround;
-(FDIntMap *) getGroundMapForFly;

@end
