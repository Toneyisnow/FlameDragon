//
//  IListener.h
//  FlameDragon
//
//  Created by sui toney on 11-12-11.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"


@interface IListener : NSObject {

	
	
}

-(void) isNotified;
-(NSMutableArray *) saveState;
-(void) loadState:(NSMutableArray *)activeEventIds;

@end
