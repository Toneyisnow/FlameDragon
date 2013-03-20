//
//  ItemDefinition.h
//  FlameDragon
//
//  Created by sui toney on 11-11-23.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDFileStream.h"
#import "FDLocalString.h"

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
	
	int category;	// For Attack Item: 1：剑 2：斧 3：矛 4：弓 5：爪 6：机械
					// For Defend Item: 1：皮甲 2：锁甲 3：铠甲 4：袍 5：斗服 6：装甲
}

+(id) readFromFile:(FDFileStream *)stream;
-(NSString *) getAttributeString;
-(BOOL) isMoney;

// Deprecated
// -(int) getMoneyQuantity;

-(BOOL) isAttackItem;
-(BOOL) isDefendItem;

@property (nonatomic) int identifier;
@property (nonatomic,retain) NSString *name;
@property (nonatomic) int price;
@property (nonatomic) int sellprice;
@property (nonatomic) int category;

@end





