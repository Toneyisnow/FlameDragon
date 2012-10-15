//
//  Shopping2ItemDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2ItemDialog.h"

#import "Shopping2ShowItemsDialog.h"
#import "Shopping2ConfirmDialog.h"
#import "Shopping2MessageDialog.h"
#import "Shopping2ShowFriendsDialog.h"
#import "Shopping2Layer.h"

@implementation Shopping2ItemDialog

// Override Method

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
	return DataDepotShopType_ItemShop;
}

@end
