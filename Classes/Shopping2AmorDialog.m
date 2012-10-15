//
//  Shopping2AmorDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-10-15.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2AmorDialog.h"


@implementation Shopping2AmorDialog


-(void) initMessage
{
	[self setMessage:[FDLocalString message:51]];	
}

-(void) updateMessage
{
	[self setMessage:[FDLocalString message:52]];	
}

-(DataDepotShopType) getShopType
{
	return DataDepotShopType_AmorShop;
}

@end
