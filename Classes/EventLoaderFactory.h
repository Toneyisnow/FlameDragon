//
//  EventLoaderFactory.h
//  FlameDragon
//
//  Created by sui toney on 12-3-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "EventLoader.h"

@interface EventLoaderFactory : NSObject {

}

+(EventLoader *) createEventLoader:(int)levelNo;


@end
