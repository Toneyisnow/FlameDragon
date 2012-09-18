//
//  ActionMenuState.h
//  FlameDragon
//
//  Created by sui toney on 11-11-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "DispatcherState.h"
#import "FDFriend.h"

@interface ActionMenuState : DispatcherState {

	FDFriend *currentFriend;
	
	BOOL confirmingPickTreasure;
}
-(id) initWithLayers:(ActionLayers *)ls Friend:(FDFriend *)frien;

-(void) checkTreasureAndSleep;
//-(void) sleep;

-(void) confirmPickTreasure:(NSNumber *)num;
-(void) confirmExchangeItem:(NSNumber *)num;

-(void) selectMagic;
-(void) confirmSelectMagic:(NSNumber *)num;

-(void) selectItemToPutBack;
-(void) confirmItemToPutBack:(NSNumber *)num;

//-(id) initWithField:(id<IField,IFieldActionable>) fi Friend:(FDFriend *)frien;

@end
