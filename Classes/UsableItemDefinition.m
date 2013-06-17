//
//  UsableItemDefinition.m
//  FlameDragon
//
//  Created by sui toney on 11-12-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "UsableItemDefinition.h"
#import "FDCreature.h"
#import "FDLocalString.h"
#import "GameFormula.h"

@implementation UsableItemDefinition

@synthesize useType;
@synthesize quantity;
@synthesize isReusable;

+(id) readFromFile:(FDFileStream *)stream
{
	UsableItemDefinition * def = [[UsableItemDefinition alloc] init];
		
	def.identifier = [stream readInt];
	
	//NSString *idStr = [NSString stringWithFormat:@"%03d", def.identifier];
	//def.name = NSLocalizedStringFromTable (idStr, @"Item", @"comment");
	def.name = [FDLocalString item:def.identifier];
	def.price = [stream readInt];
	def.sellprice = [stream readInt];
	
	def.useType = [stream readInt];
	def.quantity = [stream readInt];
	
	def.isReusable = ([stream readInt] == 1);
	
	return [def autorelease];
}


-(void) usedBy:(id)obj
{
	if (obj == nil || ![obj isKindOfClass:[FDCreature class]]) {
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
		case UsableItemType_AntiFreeze:
			[creature.data clearStatusFrozen];
			break;
		case UsableItemType_AntiPoison:
			[creature.data clearStatusPoisoned];
			break;
		case UsableItemType_MaxHp:
			creature.data.hpMax += quantity;
			break;
		case UsableItemType_MaxMp:
			creature.data.mpMax += quantity;
			break;
		case UsableItemType_Ap:
			creature.data.ap += quantity;
			break;
		case UsableItemType_Dp:
			creature.data.dp += quantity;
			break;
		case UsableItemType_Dx:
			creature.data.dx += quantity;
			break;
		case UsableItemType_Mv:
			creature.data.mv += quantity;
			break;
		case UsableItemType_EyeStar:
            creature.data.statusEnhanceDx = quantity;
            break;
        case UsableItemType_EyeDark:
            // This can only used to enemies
            [GameFormula magicWithIntId:303 From:nil To:creature Field:nil];
            break;
        case UsableItemType_EyeIce:
            creature.data.statusEnhanceDp = quantity;
            break;
        case UsableItemType_EyeFire:
            creature.data.statusEnhanceAp = quantity;
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
			str = [FDLocalString unknown];
			break;
	}
	
	
	return str;
}

@end
