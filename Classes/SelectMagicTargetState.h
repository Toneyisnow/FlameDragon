//
//  SelectMagicTargetState.h
//  FlameDragon
//
//  Created by sui toney on 11-11-16.
//  Copyright 2011 ms. All rights reserved.
//

#import "DispatcherState.h"
#import "FDFriend.h"


@interface SelectMagicTargetState : DispatcherState {

	FDFriend *currentFriend;
	int magicIndex;
	
}

-(id) initWithLayers:(ActionLayers *)ls Friend:(FDFriend *)frien MagicIndex:(int)m;


@end
