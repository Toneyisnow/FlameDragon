//
//  SelectItemTargetState.h
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "DispatcherState.h"
#import "FDFriend.h"


@interface SelectItemTargetState : DispatcherState {

	FDFriend *currentFriend;
	int itemIndex;

}
-(id) initWithLayers:(ActionLayers *)ls Friend:(FDFriend *)frien ItemIndex:(int)m;

@end
