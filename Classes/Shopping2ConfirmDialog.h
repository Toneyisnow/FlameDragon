//
//  Shopping2ConfirmDialog.h
//  FlameDragon
//
//  Created by sui toney on 12-9-12.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2Dialog.h"


@interface Shopping2ConfirmDialog : Shopping2Dialog {
	
}

-(id) initWithMessage:(NSString *)message;

-(BOOL) hasClickedOnYes:(CGPoint)location;
-(BOOL) hasClickedOnNo:(CGPoint)location;

-(CGPoint) buttonYesLocation;
-(CGPoint) buttonNoLocation;

@end

