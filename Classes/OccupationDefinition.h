//
//  OccupationDefinition.h
//  FlameDragon
//
//  Created by sui toney on 12-9-27.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDFileStream.h"


@interface OccupationDefinition : NSObject {

	int occupationId;
	NSMutableArray *attackItemCategoryList;
	NSMutableArray *defendItemCategoryList;
	
}

@property (assign, readonly) NSMutableArray *attackItemCategoryList;
@property (assign, readonly) NSMutableArray *defendItemCategoryList;
@property (assign) int occupationId;



+(id) readFromFile:(FDFileStream *)stream;

-(BOOL) canUseAttackItem:(int)attackItemCategory;
-(BOOL) canUseDefendItem:(int)defendItemCategory;

@end
