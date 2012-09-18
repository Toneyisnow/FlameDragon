//
//  FDPath.h
//  FlameDragon
//
//  Created by sui toney on 11-11-7.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDPosition.h"

@interface FDPath : NSObject {

	NSMutableArray *pointList;
	
	CGPoint position1;
	CGPoint position2;
}

-(id) initWithPos1:(CGPoint)pos1 Pos2:(CGPoint)pos2;

+(id) pathWithPos1:(CGPoint)pos1 Pos2:(CGPoint)pos2;

-(void) addPoint:(CGPoint)pos;
-(void) addPos:(FDPosition *)pos;

-(int) getPosCount;

-(CGPoint) getPos:(int)i;

-(CGPoint) getTargetPos;

-(FDPath *) fillPathWithAllPoints;

@end
