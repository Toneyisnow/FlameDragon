//
//  ShoppingBarDialog.h
//  FlameDragon
//
//  Created by sui toney on 12-5-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "ShoppingHomeDialog.h"

@interface ShoppingBarDialog : ShoppingHomeDialog {

	int lastSelectedIndex;
}

-(void) onSaveGame;
-(void) onLoadGame;

-(void) confirmSaveGame:(NSNumber *)indexObj;
-(void) confirmLoadGame:(NSNumber *)indexObj;

-(void) doSaveGame:(NSNumber *)indexObj;
-(void) doLoadGame:(NSNumber *)indexObj;

-(void) doExitGame:(NSNumber *)indexObj;

@end
