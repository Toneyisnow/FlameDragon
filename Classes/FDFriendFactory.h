//
//  FDFriendFactory.h
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDFriend.h"

@interface FDFriendFactory : NSObject {

}

+(FDFriend *) createFriendWithId:(int) identifier;

@end
