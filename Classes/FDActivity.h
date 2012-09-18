//
//  FDActivity.h
//  FlameDragon
//
//  Created by sui toney on 11-11-6.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"

@interface FDActivity : NSObject {

	bool isInitialized;
	bool hasFinished;

	int sequence;
	
	SEL postMethod;
	id obj1;
	id obj2;
	id object;

	FDActivity *nextActivity;
}

@property (nonatomic) int sequence;

-(void) initialize;
-(void) mainTick:(int)synchronizeTick;
-(void) takeTick:(int)synchronizeTick;



-(BOOL) hasFinished;
-(BOOL) isInitialized;

-(void) setNext:(FDActivity *)next;
-(void) appendToLast:(FDActivity *)last;
-(void) appendToNext:(FDActivity *)next;

-(FDActivity *) getNext;

-(void) setPostMethod:(SEL)sel param1:(id)o1 param2:(id)o2 Obj:(id)obj;
-(void) postActivity;

-(BOOL) blocksInteraction;

-(NSString *) debugInfo;

@end
