//
//  FDExplodeActivity.h
//  FlameDragon
//
//  Created by sui toney on 11-12-4.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDActivity.h"
#import "FDCreature.h"
#import "FDSlideAnimation.h"
#import "BattleField.h"

@interface FDExplodeActivity : FDActivity {

	FDCreature *creature;
	FDSlideAnimation *animation;
	
	BattleField *field;
}

-(id) initWithObject:(FDCreature *)obj Field:(BattleField *)f;


@end
