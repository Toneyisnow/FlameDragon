//
//  DefendItemDefinition.m
//  FlameDragon
//
//  Created by sui toney on 11-12-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "DefendItemDefinition.h"
#import "FDCreature.h"

@implementation DefendItemDefinition

@synthesize itemCategory, dp, ev;

+(id) readFromFile:(FDFileStream *)stream
{
	DefendItemDefinition * def = [[DefendItemDefinition alloc] init];
	
	def.identifier = [stream readInt];
	
	NSString *idStr = [NSString stringWithFormat:@"%03d", def.identifier];
	def.name = NSLocalizedStringFromTable (idStr, @"Item", @"comment");
	
	//def.name = [stream readString];
	def.itemCategory = [stream readInt];
	
	def.price = [stream readInt];
	def.sellprice = [stream readInt];
	
	def.dp = [stream readInt];
	def.ev = [stream readInt];
	
	return [def autorelease];
}

-(void) extraEffectEquipedBy:(id)obj
{
	if (![obj isKindOfClass:[FDCreature class]]) {
		return;
	}
	
	//FDCreature *creature = (FDCreature *)obj;
	
	// Creature updates its properties
	
	
	
}


-(NSString *) getAttributeString
{
	NSString *str = [NSString stringWithFormat:@"+DP %03d", dp];
	
	return str;
}

@end
