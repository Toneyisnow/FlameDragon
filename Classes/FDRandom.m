//
//  FDRandom.m
//  FlameDragon
//
//  Created by sui toney on 12-1-3.
//  Copyright 2012 ms. All rights reserved.
//

#import "FDRandom.h"


@implementation FDRandom


+(double) baseRandom
{
	int val = arc4random() % 100;
	return (double)val / 100.0;
}

+(int) from:(int)from to:(int)to
{
	if (from == to) {
		return from;
	}
	
	return from + ([FDRandom baseRandom] * (to - from + 1));
}

+(int) fromRange:(FDRange *)range
{
	return [FDRandom from:[range min] to:[range max]];
}

+(BOOL) hitWithRate:(int)rate		// rate: 0 ~ 100
{
	int seed = [FDRandom from:0	to:100];
	
	return (seed < rate);
}

@end
