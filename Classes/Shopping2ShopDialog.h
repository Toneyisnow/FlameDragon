//
//  Shopping2ShopDialog.h
//  FlameDragon
//
//  Created by sui toney on 12-9-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2HomeDialog.h"


@interface Shopping2ShopDialog : Shopping2HomeDialog {

	
}

-(DataDepotShopType) getShopType;


-(void) onBuy_Selected:(NSNumber *)num;
-(void) onBuy_Confirmed:(NSNumber *)num;

-(void) onBuyAmor_SelectedTarget:(NSNumber *)num;
-(void) onBuyAmor_Done:(NSNumber *)num;
-(void) doBuyItem:(BOOL)equip;

-(void) onBuyItem_Done:(NSNumber *)num;

@end
