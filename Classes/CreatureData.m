//
//  CreatureData.m
//  FlameDragon
//
//  Created by sui toney on 12-3-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "CreatureData.h"
#import "FDPosition.h"

@implementation CreatureData

@synthesize magicList, itemList;

@synthesize level,ap,dp,dx,hpCurrent,mpCurrent,hpMax,mpMax,mv,ex;
@synthesize attackItemIndex, defendItemIndex;
@synthesize aiType;
@synthesize aiParam;
@synthesize bodyStatus;

-(id) init
{
	self = [super init];
	
	itemList = [[NSMutableArray alloc] init];
	magicList = [[NSMutableArray alloc] init];
	
	attackItemIndex = -1;
	defendItemIndex = -1;
	
	return self;
}

+(int) ITEM_MAX
{
	return 8;
}

+(int) MAGIC_MAX
{
	return 12;
}

-(CreatureData *) clone
{
	CreatureData *another = [[CreatureData alloc] init];
	
	another.level = level;
	another.ap = ap;
	another.dp = dp;
	another.dx = dx;
	another.mv = mv;
	another.ex = ex;
	another.hpCurrent = hpCurrent;
	another.mpCurrent = mpCurrent;
	another.hpMax = hpMax;
	another.mpMax = mpMax;
	
	[another.itemList addObjectsFromArray: itemList];
	[another.magicList addObjectsFromArray: magicList];

	another.bodyStatus = bodyStatus;
	another.aiType = aiType;
	another.aiParam = aiParam;
	
	return [another autorelease];
}

-(void) encodeWithCoder:(NSCoder *)coder {
	
	[coder encodeInt:level forKey:@"level"];
    [coder encodeInt:ap forKey:@"ap"];
    [coder encodeInt:dp forKey:@"dp"];
    [coder encodeInt:dx forKey:@"dx"];
    [coder encodeInt:mv forKey:@"mv"];
    [coder encodeInt:hpCurrent forKey:@"hpCurrent"];
    [coder encodeInt:hpMax forKey:@"hpMax"];
    [coder encodeInt:mpCurrent forKey:@"mpCurrent"];
    [coder encodeInt:mpMax forKey:@"mpMax"];
	[coder encodeObject:itemList forKey:@"itemList"];
	[coder encodeObject:magicList forKey:@"magicList"];
	[coder encodeInt:bodyStatus forKey:@"bodyStatus"];
	[coder encodeInt:aiType forKey:@"aiType"];
	[coder encodeCGPoint:[(FDPosition *)aiParam posValue] forKey:@"aiParam"];
	
	NSLog(@"Encoded CreatureData");

}

-(id) initWithCoder:(NSCoder *)coder {
	
    self = [super init];
	
	level = [coder decodeIntForKey:@"level"];
    ap = [coder decodeIntForKey:@"ap"];
    dp = [coder decodeIntForKey:@"dp"];
    dx = [coder decodeIntForKey:@"dx"];
    mv = [coder decodeIntForKey:@"mv"];
    ex = [coder decodeIntForKey:@"ex"];
    hpCurrent = [coder decodeIntForKey:@"hpCurrent"];
    mpCurrent = [coder decodeIntForKey:@"mpCurrent"];
    hpMax = [coder decodeIntForKey:@"hpMax"];
	mpMax = [coder decodeIntForKey:@"mpMax"];
    bodyStatus = [coder decodeIntForKey:@"bodyStatus"];
    aiType = [coder decodeIntForKey:@"aiType"];
	self.aiParam = [FDPosition position:[coder decodeCGPointForKey:@"aiParam"]];
	itemList = [[coder decodeObjectForKey:@"itemList"] retain];
	magicList = [[coder decodeObjectForKey:@"magicList"] retain];
	
    return self;
}

-(void) dealloc
{
	[itemList release];
	[magicList release];
	
	
	[super dealloc];
}

@end
