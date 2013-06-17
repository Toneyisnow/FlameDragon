//
//  TreasureRecord.m
//  FlameDragon
//
//  Created by sui toney on 12-3-30.
//  Copyright 2012 ms. All rights reserved.
//

#import "TreasureRecord.h"


@implementation TreasureRecord

@synthesize itemId, treasureType;
@synthesize location;
@synthesize hasOpened;

-(void) encodeWithCoder:(NSCoder *)coder {
	
	[coder encodeInt:location.x forKey:@"locationX"];
    [coder encodeInt:location.y forKey:@"locationY"];
    [coder encodeInt:treasureType forKey:@"treasureType"];
	[coder encodeInt:itemId forKey:@"itemId"];
	[coder encodeBool:hasOpened forKey:@"hasOpened"];
	
	// CCLOG(@"Encoded TreasureRecord for Location=(%f, %f)", location.x, location.y);
}

-(id) initWithCoder:(NSCoder *)coder {
	
    self = [super init];
	
	int x = [coder decodeIntForKey:@"locationX"];
    int y = [coder decodeIntForKey:@"locationY"];
	location = CGPointMake(x, y);
	
	treasureType = [coder decodeIntForKey:@"treasureType"];
	itemId = [coder decodeIntForKey:@"itemId"];
	hasOpened = [coder decodeBoolForKey:@"hasOpened"];
	
    return self;
}


@end
