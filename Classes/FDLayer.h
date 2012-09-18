//
//  FDLayer.h
//  FlameDragon
//
//  Created by sui toney on 12-8-13.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "IMessage.h"

@interface FDLayer : CCLayer {
	
	CGSize winSize;
	
	CGPoint screenCenterLocation;
	CGPoint downCenterLocation;
	CGPoint upCenterLocation;
	
	IMessage *message;
}

-(void) updateScreen:(int)synchronizeTick;

-(CGSize) getWinSize;
-(CGPoint) getScreenCenterLoc;
-(CGPoint) getDownCenterLoc;
-(CGPoint) getUpCenterLoc;
-(CGPoint) getUpLeftLoc;
-(CGPoint) getUpRightLoc;

-(void) setMessageTo:(IMessage *)msg;
-(void) clearMessage;
-(IMessage *) getMessage;


@end
