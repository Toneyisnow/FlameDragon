//
//  ItemsMenuState.h
//  FlameDragon
//
//  Created by sui toney on 11-11-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "DispatcherState.h"
#import "FDFriend.h"
#import "ItemBox.h"

@interface ItemsMenuState : DispatcherState {
	
	FDFriend *currentFriend;
	ItemOperatingType operating;	
	
}

-(id) initWithLayers:(ActionLayers *)ls Friend:(FDFriend *)frien;

-(void) selectItemToUse;
-(void) confirmItemToUse:(NSNumber *)num;

-(void) selectItemToEquip;
-(void) confirmItemToEquip:(NSNumber *)num;

-(void) selectItemToDrop;
-(void) confirmItemToDrop:(NSNumber *)num;

-(void) selectItemToExchange;
-(void) confirmItemToExchange:(NSNumber *)num;

@end
