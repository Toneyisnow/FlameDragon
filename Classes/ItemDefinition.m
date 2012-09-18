//
//  ItemDefinition.m
//  FlameDragon
//
//  Created by sui toney on 11-11-23.
//  Copyright 2011 ms. All rights reserved.
//

#import "ItemDefinition.h"
#import "FDCreature.h"

@implementation ItemDefinition

@synthesize name;
@synthesize identifier, price, sellprice;

+(id) readFromFile:(FDFileStream *)stream
{
	// Should implement from sub class
	
	return nil;
}

-(NSString *) getAttributeString
{
	return nil;

}

// Since money is special, put this function here
-(BOOL) isMoney
{
	return (identifier / 100 == 9);
}

-(int) getMoneyQuantity
{
	switch (identifier) {
		case 901:
			return 3000;
			break;
		case 902:
			return 5000;
			break;
		default:
			break;
	}
	return 0;
}

-(BOOL) isAttackItem
{
	return identifier / 100 == 2;
}

-(BOOL) isDefendItem
{
	return identifier / 100 == 3;
}

@end
