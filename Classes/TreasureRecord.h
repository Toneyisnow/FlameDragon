//
//  TreasureRecord.h
//  FlameDragon
//
//  Created by sui toney on 12-3-30.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"

@interface TreasureRecord : NSObject<NSCoding> {

	CGPoint location;
	int treasureType;
	int itemId;
	BOOL hasOpened;
	
}

@property (nonatomic) CGPoint location;
@property (nonatomic) int treasureType;
@property (nonatomic) int itemId;
@property (nonatomic) BOOL hasOpened;


@end
