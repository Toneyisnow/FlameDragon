//
//  SelectAttackTargetState.h
//  FlameDragon
//
//  Created by sui toney on 11-11-16.
//  Copyright 2011 ms. All rights reserved.
//

#import "DispatcherState.h"
#import "FDFriend.h"

@interface SelectAttackTargetState : DispatcherState {

	FDFriend *currentFriend;
}

-(id) initWithLayers:(ActionLayers *)ls Friend:(FDFriend *)frien;

@end
