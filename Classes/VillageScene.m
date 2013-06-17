//
//  VillageScene.m
//  FlameDragon
//
//  Created by sui toney on 12-4-27.
//  Copyright 2012 ms. All rights reserved.
//

#import "VillageScene.h"
#import "DataDepot.h"
#import "VillageNonLayer.h"

@implementation VillageScene

@synthesize mainLayer;

-(void) loadWithRecord:(ChapterRecord *) record
{
    ShopDefinition *shop = [[DataDepot depot] getShopDefinition:record.chapterId Type:DataDepotShopType_AmorShop];
 
    if (shop != nil)
    {
        mainLayer = [VillageLayer node];
    }
    else
    {
        mainLayer = [VillageNonLayer node];
    }
    
	mainLayer.isTouchEnabled = TRUE;
	
	[self addChild:mainLayer];
	
	[mainLayer loadWithRecord:record];
	[self schedule: @selector(step:)];
}

-(void) step: (ccTime) delta
{
	//NSLog(@"step");
	[mainLayer takeTick];
}


@end
