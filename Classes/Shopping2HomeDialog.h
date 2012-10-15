//
//  Shopping2HomeDialog.h
//  FlameDragon
//
//  Created by sui toney on 12-5-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "Shopping2Dialog.h"
#import "ShoppingButton.h"

#import "DataDepot.h"
#import "FDLocalString.h"
#import "GameRecord.h"

@interface Shopping2HomeDialog : Shopping2Dialog {
	
	NSMutableArray *buttonArray;

	FDSprite *messageSprite;
	
	int lastSelectedItemIndex;
	int lastSelectedCreatureIndex;
	int lastPageIndex;
}

-(void) initButtons;
-(void) initMessage;
-(void) updateMessage;
-(void) setMessage:(NSString *)msg;

-(void) generateButtonArray;

-(ShoppingButton *) button_Buy;
-(ShoppingButton *) button_Sell;
-(ShoppingButton *) button_GiveItem;
-(ShoppingButton *) button_Equip;
-(ShoppingButton *) button_Info;
-(ShoppingButton *) button_Save;
-(ShoppingButton *) button_Load;
-(ShoppingButton *) button_Revive;
-(ShoppingButton *) button_Transfer;
-(ShoppingButton *) button_Exit;

-(void) showDialog:(Shopping2Dialog *)dia Callback:(SEL)callback;

-(void) onBuy;

-(void) onSell;
-(void) onSell_SelectedFriend:(NSNumber *)num;
-(void) onSell_SelectedItem:(NSNumber *)num;
-(void) onSell_Confirm:(NSNumber *)num;
-(void) doSellItem;

-(void) onGiveItem;
-(void) onGiveItem_Start:(NSNumber *)num;
-(void) onGiveItem_SelectedWhose:(NSNumber *)num;
-(void) onGiveItem_SelectedItem:(NSNumber *)num;
-(void) onGiveItem_ToWhom:(NSNumber *)num;
-(void) onGiveItem_ToTargetSelected:(NSNumber *)num;
-(void) doGiveItem:(int)creatureIndex;

-(void) onInfo;
-(void) onInfo_ShowItems:(NSNumber *)num;
-(void) onInfo_ShowMagics:(NSNumber *)num;

-(void) onSaveGame;

-(void) onLoadGame;

-(void) onExitGame;

-(void) onEquip;
-(void) onEquip_SelectedFriend:(NSNumber *)num;
-(void) doEquip;

-(void) onRevive;

-(void) onTransfer;

-(void) closeCurrentBox;

@end

