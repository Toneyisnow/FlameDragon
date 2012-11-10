//
//  UsableItemDefinition.m
//  FlameDragon
//
//  Created by sui toney on 11-12-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "SpecialItemDefinition.h"
#import "FDCreature.h"
#import "FDLocalString.h"

@implementation SpecialItemDefinition


+(id) readFromFile:(FDFileStream *)stream
{
	SpecialItemDefinition * def = [[SpecialItemDefinition alloc] init];
		
	def.identifier = [stream readInt];
	
	NSString *idStr = [NSString stringWithFormat:@"%03d", def.identifier];
	def.name = NSLocalizedStringFromTable (idStr, @"Item", @"comment");
	
	def.price = [stream readInt];
	def.sellprice = [stream readInt];
	
	return [def autorelease];
}


-(void) usedBy:(id)obj
{
	if (![obj isKindOfClass:[FDCreature class]]) {
		return;
	}
	
	
}

-(NSString *) getAttributeString
{
	return [FDLocalString unknown];
}

@end
