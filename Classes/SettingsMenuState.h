//
//  SettingsMenuState.h
//  FlameDragon
//
//  Created by sui toney on 11-11-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "DispatcherState.h"


@interface SettingsMenuState : DispatcherState {

	CGPoint centralPosition;

}

-(id) initWithLayers:(ActionLayers *)ls Position:(CGPoint)pos;

@end
