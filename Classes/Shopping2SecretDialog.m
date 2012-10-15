//
//  Shopping2SecretDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-28.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2SecretDialog.h"


@implementation Shopping2SecretDialog

-(void) initMessage
{
	[self setMessage:[FDLocalString message:53]];	
}

-(void) updateMessage
{
	[self setMessage:[FDLocalString message:54]];	
}

-(DataDepotShopType) getShopType
{
	return DataDepotShopType_SecretShop;
}

@end
