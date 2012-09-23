//
//  Shopping2ShowSellItemsDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-23.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2ShowSellItemsDialog.h"


@implementation Shopping2ShowSellItemsDialog

-(int) getPrice:(ItemDefinition *)item
{
	return item.sellprice;
}

@end
