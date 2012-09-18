//
//  UsableItemDefinition.m
//  FlameDragon
//
//  Created by sui toney on 11-12-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "UsableItemDefinition.h"
#import "FDCreature.h"

@implementation UsableItemDefinition

@synthesize useType;
@synthesize quantity;


+(id) readFromFile:(FDFileStream *)stream
{
	UsableItemDefinition * def = [[UsableItemDefinition alloc] init];
		
	def.identifier = [stream readInt];
	
	NSString *idStr = [NSString stringWithFormat:@"%03d", def.identifier];
	def.name = NSLocalizedStringFromTable (idStr, @"Item", @"comment");
	
	def.price = [stream readInt];
	def.sellprice = [stream readInt];
	
	def.useType = [stream readInt];
	def.quantity = [stream readInt];
	
	return [def autorelease];
}


-(void) usedBy:(id)obj
{
	if (![obj isKindOfClass:[FDCreature class]]) {
		return;
	}
	
	FDCreature *creature = (FDCreature *)obj;
	
	// Creature updates its properties
	switch (useType) {
		case UsableItemType_Hp:
			[creature updateHP:quantity];
			break;
		case UsableItemType_Mp:
			[creature updateMP:quantity];
			break;
		case UsableItemType_MaxHp:
			//[creature updateMaxHP:quantity];
			break;
		case UsableItemType_MaxMp:
			//[creature updateMaxHP:quantity];
			break;
		default:
			break;
	}

}

-(NSString *) getAttributeString
{
	NSString *str = nil;
	
	switch (useType) {
		case UsableItemType_Hp:
			str = [NSString stringWithFormat:@"+HP %03d", quantity];
			break;
		case UsableItemType_Mp:
			str = [NSString stringWithFormat:@"+MP %03d", quantity];
			break;
		case UsableItemType_MaxHp:
			str = [NSString stringWithFormat:@"+HP %03d", quantity];
			break;
		case UsableItemType_MaxMp:
			str = [NSString stringWithFormat:@"+MP %03d", quantity];
			break;
		default:
			break;
	}
	
	
	return str;
}

@end
