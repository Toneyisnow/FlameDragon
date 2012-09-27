//
//  Shopping2SelectAmorTargetDialog.h
//  FlameDragon
//
//  Created by sui toney on 12-9-12.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "Shopping2PagedDialog.h"

@interface Shopping2SelectAmorTargetDialog : Shopping2PagedDialog {
	
	int itemId;
	NSMutableArray *suitableFriends;
	
}

-(id) initWithFriends:(NSMutableArray *)list itemId:(int)iId pageIndex:(int)pIndex;


@end
