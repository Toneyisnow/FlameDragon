//
//  ExchangeItemTargetState.h
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "DispatcherState.h"
#import "FDFriend.h"


@interface ExchangeItemTargetState : DispatcherState {
	
	FDFriend *currentFriend;
	int itemIndex;
	
	FDCreature *target;
}
-(id) initWithLayers:(ActionLayers *)ls Friend:(FDFriend *)frien ItemIndex:(int)m;

-(void) selectItemToExchangeBack;
-(void) confirmItemToExchangeBack:(NSNumber *)num;


@end
