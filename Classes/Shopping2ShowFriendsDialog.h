//
//  Shopping2ShowFriendsDialog.h
//  FlameDragon
//
//  Created by sui toney on 12-9-12.
//  Copyright 2012 ms. All rights reserved.
//


#import "cocos2d.h"
#import "Shopping2PagedDialog.h"

@interface Shopping2ShowFriendsDialog : Shopping2PagedDialog {
	
}

-(id) initWithFriends:(NSMutableArray *)list pageIndex:(int)pageIndex;

@end