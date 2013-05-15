//
//  FDActivity.m
//  FlameDragon
//
//  Created by sui toney on 11-11-6.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDActivity.h"


@implementation FDActivity

@synthesize sequence;

-(id) init
{
	self = [super init];
	
	isInitialized = FALSE;
	hasFinished = FALSE;
	nextActivity = nil;
	
	sequence = 0;
	
	return self;
}

-(void) initialize
{
}

-(void) mainTick:(int)synchronizeTick
{
}

-(void) takeTick:(int)synchronizeTick
{
	if (!isInitialized) {
		[self initialize];
		isInitialized = TRUE;
	}
	
	[self mainTick:synchronizeTick];
}

-(void) setNext:(FDActivity *)next
{
	nextActivity = [next retain];
}

-(FDActivity *) getNext
{
	return nextActivity;
}

-(void) setPostMethod:(SEL)sel param1:(id)o1 param2:(id)o2 Obj:(id)obj
{
	postMethod = sel;
	obj1 = o1;
	obj2 = o2;
	object = obj;
}

-(void) postActivity
{
	if (postMethod != nil && [object respondsToSelector:postMethod])
	{
		[object performSelector:postMethod withObject:obj1 withObject:obj2];
	}
	else {
		CCLOG(@"Cannot do post Activity: post Method cannot be found.");
	}

}

-(void) appendToLast:(FDActivity *)last
{
	FDActivity *l = self;
	while ([l getNext] != nil) {
		l = [l getNext];
	}
	[l setNext:last];
	last.sequence = l.sequence + 1;
}

-(void) appendToNext:(FDActivity *)next
{
	FDActivity *l = self;
	while ([l getNext] != nil && [l getNext].sequence <= sequence) {
		l = [l getNext];
	}
	
	[next setNext:[l getNext]];
	[l setNext:next];
	next.sequence = l.sequence;
}

-(BOOL) isInitialized
{
	return isInitialized;
}

-(BOOL) hasFinished
{
	return hasFinished;
}

-(BOOL) blocksInteraction
{
	// By default, all the activity should be interaction blocking
	return TRUE;
}

-(NSString *) debugInfo
{
	return [NSString stringWithFormat:@"Activity: %@, sequence:%d", [self class], sequence];
}

-(void) dealloc
{
	[nextActivity release];
	[super dealloc];
}

@end
