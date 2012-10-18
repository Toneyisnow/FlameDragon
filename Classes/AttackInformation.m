//
//  AttackInformation.m
//  FlameDragon
//
//  Created by sui toney on 12-10-18.
//  Copyright 2012 ms. All rights reserved.
//

#import "AttackInformation.h"


@implementation AttackInformation


-(id) initWithBefore:(int)b after:(int)a isCritical:(BOOL)c
{
	self = [super init];
	
	beforeValue = b;
	afterValue = a;
	isCritical = c;
	
	return self;
}

-(int) getBefore
{
	return beforeValue;
}

-(int) getAfter
{
	return afterValue;
}

-(BOOL) isCritical
{
	return isCritical;
}

@end
