//
//  ItemDefinition.h
//  FlameDragon
//
//  Created by sui toney on 11-11-23.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDFileStream.h"

typedef enum ItemType
{
	ItemType_Usable,
	ItemType_Equip,
	ItemType_MultiUsable,
	ItemType_NotUsable
} ItemType;

@interface ItemDefinition : NSObject {

	int identifier;
	NSString *name;
	ItemType type;	// It's not used yet, just the class can differenciate them
	int price;
	int sellprice;
}

+(id) readFromFile:(FDFileStream *)stream;
-(NSString *) getAttributeString;
-(BOOL) isMoney;
-(int) getMoneyQuantity;
-(BOOL) isAttackItem;
-(BOOL) isDefendItem;

@property (nonatomic) int identifier;
@property (nonatomic,retain) NSString *name;
@property (nonatomic) int price;
@property (nonatomic) int sellprice;

@end





