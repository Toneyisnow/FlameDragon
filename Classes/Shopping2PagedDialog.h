//
//  Shopping2PagedDialog.h
//  FlameDragon
//
//  Created by sui toney on 12-9-22.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "Shopping2Dialog.h"

@interface Shopping2PagedDialog : Shopping2Dialog {
	
	int pageIndex;

	NSMutableArray *itemList;

}

-(id) initWithList:(NSMutableArray *)list pageIndex:(int)pIndex;

-(void) initComponents;
-(int) getMaxItemCount;

-(void) clickedUp;
-(void) clickedDown;


@end
