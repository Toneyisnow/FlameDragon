//
//  ShoppingConfirmDialog.h
//  FlameDragon
//
//  Created by sui toney on 12-6-5.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "ShoppingDialog.h"

@interface ShoppingConfirmDialog : ShoppingDialog {

}

-(id) initWithMessage:(NSString *)message From:(ShoppingDialog *)dialog;

@end
