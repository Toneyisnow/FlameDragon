//
//  CreatureRecord.h
//  FlameDragon
//
//  Created by sui toney on 12-3-21.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "CreatureData.h"
#import "FDFileStream.h"

@interface CreatureRecord : NSObject<NSCoding> {

	int creatureId;
	int definitionId;
	int creatureType;
	
	CreatureData *data;
	CGPoint location;
	
}

-(id) initWithTestData;
+(id) friendSampleRecord:(int)friendId;

- (NSComparisonResult)compareRecords:(id)inObject;

//-(int) getFriendId;

@property (nonatomic) int creatureId;
@property (nonatomic) int definitionId;
@property (nonatomic) int creatureType;

@property (nonatomic, retain) CreatureData *data;
@property (nonatomic) CGPoint location;

@end
