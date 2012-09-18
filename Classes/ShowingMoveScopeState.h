//
//  ShowingMoveScopeState.h
//  FlameDragon
//
//  Created by sui toney on 11-11-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "DispatcherState.h"
#import "FDFriend.h"

@interface ShowingMoveScopeState : DispatcherState {

	FDFriend *currentFriend;
	// CGPoint screenLocation;
}

-(id) initWithLayers:(ActionLayers *)ls Friend:(FDFriend *)frien;
//-(id) initWithField:(id<IField,IFieldActionable>) fi Friend:(FDFriend *)frien;

@end
