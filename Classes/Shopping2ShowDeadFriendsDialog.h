//
//  Shopping2ShowDeadFriendsDialog.h
//  FlameDragon
//
//  Created by sui toney on 12-9-13.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "Shopping2PagedDialog.h"

@interface Shopping2ShowDeadFriendsDialog : Shopping2PagedDialog {
	
	NSMutableArray *deadFriends;
}

-(id) initWithFriends:(NSMutableArray *)list pageIndex:(int)pIndex;

@end
