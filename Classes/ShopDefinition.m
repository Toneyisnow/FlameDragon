//
//  ShopDefinition.m
//  FlameDragon
//
//  Created by sui toney on 12-9-8.
//  Copyright 2012 ms. All rights reserved.
//

#import "ShopDefinition.h"
#import "FDFileStream.h"

@implementation ShopDefinition

@synthesize itemList;

+(id) readFromFile:(FDFileStream *)stream
{
	ShopDefinition * def = [[ShopDefinition alloc] init];
	
	int itemCount = [stream readInt];
	
	for (int i = 0; i < itemCount; i++) {
		int item = [stream readInt];
		
		[def.itemList addObject:[NSNumber numberWithInt:item]];
	}
	
	return def;
}


-(id) init
{
	self = [super init];
	
	itemList = [[NSMutableArray alloc] init];
	return self;
}


-(void) dealloc
{
	[itemList release];
	
	[super dealloc];
}

@end
