//
//  SystemMenuState.h
//  FlameDragon
//
//  Created by sui toney on 11-11-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "DispatcherState.h"


@interface SystemMenuState : DispatcherState {

	CGPoint centralPosition;
	BOOL confirmingEndTurn;
}

-(id) initWithLayers:(ActionLayers *)ls Position:(CGPoint)pos;

-(void) promptEndTurn;
-(void) confirmEndTurn:(NSNumber *)num;

@end
