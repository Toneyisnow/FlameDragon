//
//  FDRange.m
//  FlameDragon
//
//  Created by sui toney on 11-11-16.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDRange.h"


@implementation FDRange


-(id) initWithMin:(int)m Max:(int)a
{
	self = [super init];
	
	min = m;
	max = a;
	
	return self;
}


-(int) min
{
	return min;
}

-(int) max
{
	return max;
}

@end
