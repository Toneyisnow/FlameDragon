//
//  TransfersDefinition.m
//  FlameDragon
//
//  Created by sui toney on 13-2-6.
//  Copyright 2013 ms. All rights reserved.
//

#import "TransfersDefinition.h"


@implementation TransfersDefinition

@synthesize creatureDefId;
@synthesize transferArray;


+(id) readFromFile:(FDFileStream *)stream
{
	TransfersDefinition * def = [[TransfersDefinition alloc] init];
	
	def.creatureDefId = [stream readInt];
	int count = [stream readInt];
	
	for (int i = 0; i < count; i++) {
		TransferDefinition *t = [TransferDefinition readFromFile:stream];
		t.fromCreatureDefId = def.creatureDefId;
		
		[def.transferArray addObject:t];
	}
	
	return def;
}

-(id) init
{
	self = [super init];
	transferArray = [[NSMutableArray alloc] init];
	
	return self;
}

-(TransferDefinition *) getTransfer:(int)index
{
	if (transferArray == nil || index < 0 || index >= [transferArray count]) {
		return nil;
	}
	
	return [transferArray objectAtIndex:index];
}

-(int) totalCount
{
	return (transferArray == nil) ? 0 : [transferArray count];
}


@end
