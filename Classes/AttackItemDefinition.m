//
//  AttackItemDefinition.m
//  FlameDragon
//
//  Created by sui toney on 11-12-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "AttackItemDefinition.h"
#import "FDCreature.h"

@implementation AttackItemDefinition

@synthesize itemCategory,ap,hit,ev,attackScope;


+(id) readFromFile:(FDFileStream *)stream
{
	AttackItemDefinition * def = [[AttackItemDefinition alloc] init];
	
	def.identifier = [stream readInt];
	
	NSString *idStr = [NSString stringWithFormat:@"%03d", def.identifier];
	def.name = NSLocalizedStringFromTable (idStr, @"Item", @"comment");
	
	//def.name = [stream readString];
	def.itemCategory = [stream readInt];
	
	def.price = [stream readInt];
	def.sellprice = [stream readInt];
	
	def.ap = [stream readInt];
	def.hit = [stream readInt];
	
	// Currently there is no weapon that ev > 0
	def.ev = 0;
	
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
	NSString *str = [NSString stringWithFormat:@"+AP %03d", ap];
	
	return str;
}

@end
