//
//  CreatureRecord.m
//  FlameDragon
//
//  Created by sui toney on 12-3-21.
//  Copyright 2012 ms. All rights reserved.
//

#import "CreatureRecord.h"

@implementation CreatureRecord

@synthesize creatureId, definitionId;
@synthesize data;
@synthesize location;


-(id) initWithTestData
{
	self = [super init];
	
	location = CGPointMake(8, 10);
	creatureId = 1;
	definitionId = 1;
	
	data = [[CreatureData alloc] init];
	data.level = 3;
	data.hpMax = 100;
	data.mpMax = 0;
	data.hpCurrent = 100;
	data.mpCurrent = 0;
	data.ap = 10;
	data.dp = 5;
	data.mv = 4;
	data.dx = 5;
	data.ex = 10;
	data.bodyStatus = BodyStatus_Normal;
	
	[data.itemList addObject:[NSNumber numberWithInt:221]];
	[data.itemList addObject:[NSNumber numberWithInt:311]];
	
	data.attackItemIndex = 0;
	data.defendItemIndex = 1;
	
	
	return self;
}

+(id) friendSampleRecord:(int)friendId
{
	CreatureRecord *record = [[CreatureRecord alloc] init];
	
	record.location = CGPointMake(8, 10);
	record.creatureId = friendId;
	record.definitionId = friendId;
	
	record.data = [[CreatureData alloc] init];
	record.data.level = 3;
	record.data.hpMax = 100;
	record.data.mpMax = 0;
	record.data.hpCurrent = 100;
	record.data.mpCurrent = 0;
	record.data.ap = 10;
	record.data.dp = 5;
	record.data.mv = 4;
	record.data.dx = 5;
	record.data.ex = 10;
	record.data.bodyStatus = BodyStatus_Normal;
	
	[record.data.itemList addObject:[NSNumber numberWithInt:221]];
	[record.data.itemList addObject:[NSNumber numberWithInt:311]];
	
	record.data.attackItemIndex = 0;
	record.data.defendItemIndex = 1;
	
	
	return [record autorelease];
}

-(void) encodeWithCoder:(NSCoder *)coder {
	
	[coder encodeInt:location.x forKey:@"locationX"];
    [coder encodeInt:location.y forKey:@"locationY"];
    [coder encodeInt:creatureId forKey:@"creatureId"];
	[coder encodeInt:definitionId forKey:@"definitionId"];
	[coder encodeObject:data forKey:@"data"];
	
	NSLog(@"Encoded CreatureRecord for CreatureId=%d", creatureId);
}

-(id) initWithCoder:(NSCoder *)coder {
	
    self = [super init];
	
	int x = [coder decodeIntForKey:@"locationX"];
    int y = [coder decodeIntForKey:@"locationY"];
	location = CGPointMake(x, y);
	
	creatureId = [coder decodeIntForKey:@"creatureId"];
	definitionId = [coder decodeIntForKey:@"definitionId"];
	data = [[coder decodeObjectForKey:@"data"] retain];
	
	
    return self;
}

/*
 -(int) getFriendId
{
	return definitionId % 100;
}
*/

-(void) dealloc
{
	[data release];
	
	[super dealloc];
}

@end
