//
//  ShoppingHomeDialog.h
//  FlameDragon
//
//  Created by sui toney on 12-5-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "ShoppingDialog.h"

@interface ShoppingHomeDialog : ShoppingDialog {

	CGPoint buttonLocation1;
	CGPoint buttonLocation2;
	CGPoint buttonLocation3;
	CGPoint buttonLocation4;
	
	int lastSelectedItemIndex;
	int lastSelectedCreatureIndex;

}

//-(void) loadButtons;

-(ShoppingButton *) generateButton1;
-(ShoppingButton *) generateButton2;
-(ShoppingButton *) generateButton3;
-(ShoppingButton *) generateButton4;

-(void) onBuyAmor;
-(void) onBuyAmor_SelectedAmor:(NSNumber *)num;
-(void) onBuyAmor_ConfirmedAmor:(NSNumber *)num;
-(void) onBuyAmor_SelectedTarget:(NSNumber *)num;
-(void) onBuyAmor_Done:(NSNumber *)num;

-(void) onSellAmor;
-(void) onSellAmor_SelectedFriend:(NSNumber *)num;
-(void) onSellAmor_SelectedItem:(NSNumber *)num;


@end
