//
//  Shopping2ShowProductDialog.h
//  FlameDragon
//
//  Created by sui toney on 12-9-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2Dialog.h"


@interface Shopping2ShowProductDialog : Shopping2Dialog {

	int startX;
	int startY;
	int intervalX;
	int intervalY;
	
	int itemCount;
}

-(id) initWithList:(NSMutableArray *)list;


@end
