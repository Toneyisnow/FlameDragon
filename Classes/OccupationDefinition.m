//
//  OccupationDefinition.m
//  FlameDragon
//
//  Created by sui toney on 12-9-27.
//  Copyright 2012 ms. All rights reserved.
//

#import "OccupationDefinition.h"


@implementation OccupationDefinition

@synthesize attackItemCategoryList;
@synthesize defendItemCategoryList;
@synthesize occupationId, magicDefenceRate;

+(id) readFromFile:(FDFileStream *)stream
{
	
	OccupationDefinition * def = [[OccupationDefinition alloc] init];
	
	def.occupationId = [stream readInt];
	int attackCount = [stream readInt];
	for (int i = 0; i < attackCount; i++) {
			int itemCategory = [stream readInt];
			[def.attackItemCategoryList addObject:[NSNumber numberWithInt:itemCategory]];
	}
	int defendCount = [stream readInt];
	for (int i = 0; i < defendCount; i++) {
			int itemCategory = [stream readInt];
			[def.defendItemCategoryList addObject:[NSNumber numberWithInt:itemCategory]];
	}
	
	def.magicDefenceRate = [stream readInt];
	
	return def;
}

-(id) init
{
	self = [super init];
	
	attackItemCategoryList = [[NSMutableArray alloc] init];
	defendItemCategoryList = [[NSMutableArray alloc] init];
	
	return self;
}

-(BOOL) canUseAttackItem:(int)attackItemCategory
{
	for (NSNumber *itemCategory in attackItemCategoryList)
	{
		if ([itemCategory intValue] == attackItemCategory) {
			return TRUE;
		}
	}
	
	return FALSE;
}

-(BOOL) canUseDefendItem:(int)defendItemCategory
{
	for (NSNumber *itemCategory in defendItemCategoryList)
	{
		if ([itemCategory intValue] == defendItemCategory) {
			return TRUE;
		}
	}
	
	return FALSE;
}


-(void) dealloc
{
	[attackItemCategoryList release];
	[defendItemCategoryList release];
	
	[super dealloc];
}


@end
