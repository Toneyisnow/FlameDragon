//
//  MagicalInformation.m
//  FlameDragon
//
//  Created by sui toney on 12-10-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "MagicalInformation.h"


@implementation MagicalInformation

-(id) init
{
	self = [super init];
	
	informationList = [[NSMutableArray alloc] init];
	
	return self;
}

-(void) addInformation:(AttackInformation *)info
{
	if (info == nil) {
		NSLog(@"Add Information Error: info is nil.");
		return;
	}
	
	[informationList addObject:info];
}

-(NSMutableArray *) getInformations
{
	return informationList;
}


-(void) dealloc
{
	[informationList release];
	
	[super dealloc];
}

@end
