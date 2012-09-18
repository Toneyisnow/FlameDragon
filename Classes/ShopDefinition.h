//
//  ShopDefinition.h
//  FlameDragon
//
//  Created by sui toney on 12-9-8.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDFileStream.h"

typedef enum DataDepotShopType
{
	DataDepotShopType_AmorShop = 1,
	DataDepotShopType_ItemShop = 2,
	DataDepotShopType_HiddenShop = 3
} DataDepotShopType;


@interface ShopDefinition : NSObject {

	NSMutableArray *itemList;
}

@property (assign, readonly) NSMutableArray *itemList;

+(id) readFromFile:(FDFileStream *)stream;

@end
