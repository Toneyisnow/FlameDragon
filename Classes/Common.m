//
//  Common.m
//  FlameDragon
//
//  Created by sui toney on 11-11-3.
//  Copyright 2011 ms. All rights reserved.
//

#import "Common.h"


@implementation Common

+(NSString *) ToString:(char *)ch
{
	return [NSString stringWithFormat:@"%s", ch];
}

+(NSString *) ToString:(int)val Digit:(int)digit
{

	return nil;
}

+(NSString *) GetDocumentDir {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}


+(NSString *) fileFullPath:(NSString *)fileName
{
	//return [[self GetDocumentDir] stringByAppendingString:fileName];
	
	return [NSString stringWithFormat:@"%@/%@", [self GetDocumentDir], fileName];
}

+(int) maxBetween:(int)val1 and:(int)val2
{
	if (val1 > val2) {
		return val1;
	}
	return val2;
	
}

+(int) minBetween:(int)val1 and:(int)val2
{
	if (val1 < val2) {
		return val1;
	}
	return val2;
	
}

+(double) getAbs:(double) d1
{
	if (d1 < 0) {
		return -d1;
	}
	return d1;
}

@end
