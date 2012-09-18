//
//  LinkedDialog.h
//  FlameDragon
//
//  Created by sui toney on 12-5-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "ShoppingDialog.h"


@interface LinkedDialog : NSObject {

	ShoppingDialog *currentDialog;
	LinkedDialog *next;
}

-(id) initWithDialog:(ShoppingDialog *)dlg Next:(LinkedDialog *)n;

-(ShoppingDialog *) currentDialog;
-(LinkedDialog *) getNext;

@end
