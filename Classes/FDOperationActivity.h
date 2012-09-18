//
//  FDOperationActivity.h
//  FlameDragon
//
//  Created by sui toney on 11-12-8.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDActivity.h"

@interface FDOperationActivity : FDActivity {

	id subject;
	SEL method;
	id param1;
	id param2;
}

-(id) initWithObject:(id) obj Method:(SEL)m Param1:(id)p1 Param2:(id)p2;


-(NSString *) callbackMethod;

@end
