//
//  Shopping2ChurchDialog.h
//  FlameDragon
//
//  Created by sui toney on 12-9-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2HomeDialog.h"


@interface Shopping2ChurchDialog : Shopping2HomeDialog {

	int transferFee;
}

-(void) onRevive_SelectedFriend:(NSNumber *)num;
-(void) onRevive_Confirmed:(NSNumber *)num;
-(void) doRevive;

-(void) onTransfer_SelectedFriend:(NSNumber *)num;
-(void) onTransfer_Confirm:(NSNumber *)num;
-(void) doTransfer;


@end
