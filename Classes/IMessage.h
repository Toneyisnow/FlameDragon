//
//  IMessage.h
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
//#import "MessageLayer.h"
#import "IBar.h"

@interface IMessage : IBar {

	id layer;

	id object;
	SEL method;

	id returnValue;
}

-(void) setCallback:(id)o Method:(SEL)m;

@end
