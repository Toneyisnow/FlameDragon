//
//  FDDurationActivity.h
//  FlameDragon
//
//  Created by sui toney on 11-11-27.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDActivity.h"


@interface FDDurationActivity : FDActivity {

	int waitTick;

	float duration;
}

-(id) initWithDuration:(float)sec;

@end
