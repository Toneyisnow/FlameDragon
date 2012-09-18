//
//  FDOperationActivity.m
//  FlameDragon
//
//  Created by sui toney on 11-12-8.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDOperationActivity.h"


@implementation FDOperationActivity

-(id) initWithObject:(id) obj Method:(SEL)m Param1:(id)p1 Param2:(id)p2
{
	self = [super init];
	
	//subject = [obj retain];
	//method = [m retain];
	
	subject = obj;
	method = m;
	
	if (p1 != nil) {
		param1 = [p1 retain];
	}
	if (p2 != nil) {
		param2 = [p2 retain];
	}
	
	return self;
}

-(void) initialize
{
	if (subject == nil || method == nil) {
		return;
	}
	
	[subject performSelector:method withObject:param1 withObject:param2];
}

-(void) mainTick:(int)synchronizeTick
{
	hasFinished = TRUE;
}

-(NSString *) callbackMethod
{
	return nil;
	// return [NSString stringWithFormat:@"%s", [method getName]];
}
		
-(void) dealloc
{
	//[subject release];
	//[method release];
	
	if (param1 != nil) {
		[param1 release];
	}
	
	if (param2 != nil) {
		[param2 release];
	}
	
	[super dealloc];
}

@end
