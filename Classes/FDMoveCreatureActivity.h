//
//  FDMoveCreatureActivity.h
//  FlameDragon
//
//  Created by sui toney on 11-11-6.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDActivity.h"
#import "FDCreature.h"

@interface FDMoveCreatureActivity : FDActivity {
	
	FDCreature *creature;
	
	float speed;
	int dx;
	int dy;
	
	int direction; // 0:left 1:up 2:right 3:down
	
	CGPoint targetLocation;
}

-(id) initWithObject:(FDCreature *)obj ToLocation:(CGPoint)loc Speed:(float)s;


@end
