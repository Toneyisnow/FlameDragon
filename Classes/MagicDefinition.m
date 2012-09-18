//
//  MagicDefinition.m
//  FlameDragon
//
//  Created by sui toney on 11-11-23.
//  Copyright 2011 ms. All rights reserved.
//

#import "MagicDefinition.h"

@implementation MagicDefinition

@synthesize name;
@synthesize magicType;
@synthesize identifier, effectScope, effectRange, hittingRate, mpCost;
@synthesize quantityRange;

+(id) readFromFile:(FDFileStream *)stream
{
	MagicDefinition * def = [[MagicDefinition alloc] init];
	
	def.identifier = [stream readInt];
	
	NSString *idStr = [NSString stringWithFormat:@"%03d", def.identifier];
	def.name = NSLocalizedStringFromTable (idStr, @"Magic", @"comment");
	
	def.magicType = [stream readInt];

	int min = [stream readInt];
	int max = [stream readInt];
	def.quantityRange = [[FDRange alloc] initWithMin:min Max:max];

	def.hittingRate = [stream readInt];
	def.effectScope = [stream readInt];
	def.effectRange = [stream readInt];
	def.mpCost = [stream readInt];
	
	return [def autorelease];
}


-(void) takeEffect:(id)obj
{
	
	
	
}

@end
