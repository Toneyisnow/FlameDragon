//
//  TurnInfo.h
//  FlameDragon
//
//  Created by sui toney on 11-12-7.
//  Copyright 2011 ms. All rights reserved.
//

#import "IMessage.h"


@interface TurnInfo : IMessage {

	int turnNo;
//	id messageLayer;
	
	int stayTicks;
}

-(id) initWithNo:(int)t;

@end
