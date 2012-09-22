//
//  Shopping2ItemDialog.h
//  FlameDragon
//
//  Created by sui toney on 12-9-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2HomeDialog.h"

@interface Shopping2ItemDialog : Shopping2HomeDialog {

}

-(void) onBuyItem_SelectedItem:(NSNumber *)num;
-(void) onBuyItem_ConfirmedItem:(NSNumber *)num;
-(void) onBuyItem_Done:(NSNumber *)num;

-(void) doBuyItem;

@end
