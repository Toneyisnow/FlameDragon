//
//  Shopping2ShowItemsDialog.h
//  FlameDragon
//
//  Created by sui toney on 12-9-12.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "Shopping2PagedDialog.h"
#import	"ItemDefinition.h"
@interface Shopping2ShowItemsDialog : Shopping2PagedDialog {
		
	int startX;
	int startY;
	int intervalX;
	int intervalY;
	
}


-(id) initWithItemList:(NSMutableArray *)itemList pageIndex:(int)pageIndex;

-(int) getPrice:(ItemDefinition *)item;

@end
