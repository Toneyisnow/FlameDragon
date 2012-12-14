//
//  MagicDefinition.m
//  FlameDragon
//
//  Created by sui toney on 11-11-23.
//  Copyright 2011 ms. All rights reserved.
//

#import "MagicDefinition.h"
#import "FDLocalString.h"
#import "GameFormula.h"

@implementation MagicDefinition

@synthesize name;
@synthesize magicType;
@synthesize identifier, effectScope, effectRange, hittingRate, mpCost;
@synthesize quantityRange;

+(id) readFromFile:(FDFileStream *)stream
{
	MagicDefinition * def = [[MagicDefinition alloc] init];
	
	def.identifier = [stream readInt];
	
	//NSString *idStr = [NSString stringWithFormat:@"%03d", def.identifier];
	//def.name = NSLocalizedStringFromTable (idStr, @"Magic", @"comment");
	def.name = [FDLocalString magic:def.identifier];
	
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


-(void) takeOffensiveEffect:(id)obj
{
	FDCreature *target = (FDCreature *)obj;
	
	if (target == nil) {
		return;
	}
	
	switch (identifier) {
		case 301:
			[GameFormula actionedByProhibited:target];
			break;
		case 302:
			[GameFormula actionedByPoison:target];
			break;
		case 303:
			[GameFormula actionedByFrozen:target];
			break;
		default:
			break;
	}
}

-(void) takeDefensiveEffect:(id)obj
{
	FDCreature *target = (FDCreature *)obj;
	
	if (target == nil) {
		return;
	}
	
	switch (identifier) {
		case 401:
			[GameFormula actionedByEnhanceAp:target];
			break;
		case 402:
			[GameFormula actionedByEnhanceDp:target];
			break;
		case 403:
			[GameFormula actionedByEnhanceDx:target];
			break;
		case 404:
			[target.data clearStatusPoisoned];
			break;
		case 405:
			[target.data clearStatusFrozen];
			break;
		case 406:
			target.hasMoved = target.hasActioned = FALSE;
			break;
		case 407:
			[GameFormula actionedByEnhanceAp:target];
			[GameFormula actionedByEnhanceDp:target];
			[GameFormula actionedByEnhanceDx:target];
			break;
		case 408:
			// Don't know what is the effect
			break;
		default:
			break;
	}
}

-(int) baseExperience
{
	switch (identifier) {
		case 401:
		case 402:
		case 403:
			return 2;
		case 406:
			return 8;
		case 301:
		case 302:
		case 303:
		case 404:
		case 405:
			return 4;
		case 501:
			return 10;
		default:
			break;
	}
	return 0;
}

-(BOOL) hasAnimation
{
	return magicType == MagicType_Attack;
}


@end
