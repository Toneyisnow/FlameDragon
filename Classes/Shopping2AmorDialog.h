//
//  Shopping2AmorDialog.h
//  FlameDragon
//
//  Created by sui toney on 12-9-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2HomeDialog.h"


@interface Shopping2AmorDialog : Shopping2HomeDialog {

	
}

-(void) onBuyAmor_SelectedAmor:(NSNumber *)num;
-(void) onBuyAmor_ConfirmedAmor:(NSNumber *)num;
-(void) onBuyAmor_SelectedTarget:(NSNumber *)num;
-(void) onBuyAmor_Done:(NSNumber *)num;
-(void) doBuyAmor:(BOOL)equip;

@end
