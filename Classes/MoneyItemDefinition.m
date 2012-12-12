//
//  MoneyItemDefiniton.m
//  FlameDragon
//
//  Created by sui toney on 12-1-8.
//  Copyright 2012 ms. All rights reserved.
//

#import "MoneyItemDefinition.h"

@implementation MoneyItemDefinition
@synthesize quantity;

+(id) readFromFile:(FDFileStream *)stream
{
	MoneyItemDefinition * def = [[MoneyItemDefinition alloc] init];
	
	def.identifier = [stream readInt];
	
	//NSString *idStr = [NSString stringWithFormat:@"%03d", def.identifier];
	//def.name = NSLocalizedStringFromTable (idStr, @"Item", @"comment");
	def.name = [FDLocalString item:def.identifier];
	
	def.quantity = [stream readInt];
	
	return [def autorelease];
}

@end
