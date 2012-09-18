//
//  FDFriend.h
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDCreature.h"

@interface FDFriend : FDCreature {

	//int identifier;		// 1-32 indicates the guy
	
	CGPoint lastPosition;
	
}

-(id) initWithDefinition:(int)identity Id:(int)i;
-(id) initWithDefinition:(int)identity Id:(int)i Data:(CreatureData *)dat;
-(id) initWithSavedState:(int)record;

-(CGPoint) getLastPosition;

@end
