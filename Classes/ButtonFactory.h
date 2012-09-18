//
//  ButtonFactory.h
//  FlameDragon
//
//  Created by sui toney on 12-5-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "ShoppingButton.h"

typedef enum ShoppingButtonType
{
	ShoppingButtonType_BuyAmor,
	ShoppingButtonType_BuyItem,
	ShoppingButtonType_Sell,
	ShoppingButtonType_Exchange,
	ShoppingButtonType_Info,
	ShoppingButtonType_Save,
	ShoppingButtonType_Load,
	ShoppingButtonType_Revive,
	ShoppingButtonType_Transfer,
	ShoppingButtonType_Exit
} ShoppingButtonType;

@interface ButtonFactory : NSObject {

}

+(ShoppingButton *) createButton:(ShoppingButtonType)type;

@end
