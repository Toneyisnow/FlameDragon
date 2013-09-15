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

@synthesize itemCategory,ap,hit,ev,dp;
@synthesize attackRange;

+(id) readFromFile:(FDFileStream *)stream
{
	AttackItemDefinition * def = [[AttackItemDefinition alloc] init];
	
	def.identifier = [stream readInt];
	
	def.name = [FDLocalString item:def.identifier];
	def.itemCategory = [stream readInt];
	def.price = [stream readInt];
	def.sellprice = [stream readInt];
	def.ap = [stream readInt];
    def.dp = [stream readInt];
	def.hit = [stream readInt];
	
	int scope = [stream readInt];
	if (scope > 2) {
		// Long Distance Amor
		def.attackRange = [[[FDRange alloc] initWithMin:2 Max:scope] autorelease];
	} else {
		// Short Distance Amor
		def.attackRange = [[[FDRange alloc] initWithMin:1 Max:scope] autorelease];
	}
	
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

-(int) getPoisonRate
{
	// Cui Du Dao, Hei An Jian, Hei An Gong
	if (identifier == 214 || identifier == 205 || identifier == 247) {
		return 30;
	}
	
	return 0;
}

@end
