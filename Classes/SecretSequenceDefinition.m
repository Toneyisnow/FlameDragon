//
//  SecretSequenceDefinition.m
//  FlameDragon
//
//  Created by sui toney on 12-9-28.
//  Copyright 2012 ms. All rights reserved.
//

#import "SecretSequenceDefinition.h"


@implementation SecretSequenceDefinition

@synthesize sequence;


+(id) readFromFile:(FDFileStream *)stream
{
	SecretSequenceDefinition * def = [[SecretSequenceDefinition alloc] init];
	
	int count = [stream readInt];
	for (int i = 0; i < count; i++) {
		int num = [stream readInt];
		[def.sequence addObject:[NSNumber numberWithInt:num]];
	}
	
	return [def autorelease];
}

-(id) init
{
	self = [super init];
	
	sequence = [[NSMutableArray alloc] init];
	
	return self;
}

-(int) sequenceAtIndex:(int)ind
{
	return [[sequence objectAtIndex:ind] intValue];
}

-(int) totalLength
{
	return [sequence count];
}

-(void) dealloc
{
	[sequence release];
	
	[super dealloc];
}



@end
