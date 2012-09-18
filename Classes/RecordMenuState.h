//
//  RecordMenuState.h
//  FlameDragon
//
//  Created by sui toney on 11-11-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "DispatcherState.h"


@interface RecordMenuState : DispatcherState {

	CGPoint centralPosition;
	
	BOOL confirmingSave;
	BOOL confirmingLoad;
	BOOL confirmingQuit;

}
-(id) initWithLayers:(ActionLayers *)ls Position:(CGPoint)pos;

-(void) promptSaveGame;
-(void) confirmSaveGame:(NSNumber *)num;
-(void) promptLoadGame;
-(void) confirmLoadGame:(NSNumber *)num;
-(void) promptQuitGame;
-(void) confirmQuitGame:(NSNumber *)num;


@end
