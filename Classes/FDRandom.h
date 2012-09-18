//
//  FDRandom.h
//  FlameDragon
//
//  Created by sui toney on 12-1-3.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDRange.h"

@interface FDRandom : NSObject {

	
	
}

+(double) baseRandom;

+(int) from:(int)from to:(int)to;

+(int) fromRange:(FDRange *)range;

+(BOOL) hitWithRate:(int)rate;	// rate: 0 ~ 100

@end
