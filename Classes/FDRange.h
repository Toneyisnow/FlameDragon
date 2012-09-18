//
//  FDRange.h
//  FlameDragon
//
//  Created by sui toney on 11-11-16.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"


@interface FDRange : NSObject {

	int min;
	int max;
}

-(id) initWithMin:(int)m Max:(int)a;

-(int) min;
-(int) max;

@end
