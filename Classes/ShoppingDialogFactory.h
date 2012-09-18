//
//  ShoppingDialogFactory.h
//  FlameDragon
//
//  Created by sui toney on 12-5-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "ShoppingDialog.h"

typedef enum ShoppingDialogType
{
	ShoppingDialogType_Amor,
	ShoppingDialogType_Item,
	ShoppingDialogType_Bar,
	ShoppingDialogType_Church,
	ShoppingDialogType_BuyAmor
	
} ShoppingDialogType;


@interface ShoppingDialogFactory : NSObject {

}

+(ShoppingDialog *) createDialog;


@end
