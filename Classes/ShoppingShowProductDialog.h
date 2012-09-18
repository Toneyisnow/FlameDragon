//
//  ShoppingShowProductDialog.h
//  FlameDragon
//
//  Created by sui toney on 12-5-15.
//  Copyright 2012 ms. All rights reserved.
//

#import "ShoppingDialog.h"


@interface ShoppingShowProductDialog : ShoppingDialog {

	int startX;
	int startY;
	int intervalX;
	int intervalY;
	
	int itemCount;
}

-(id) initWithList:(NSMutableArray *)list From:(ShoppingDialog *)dia;

@end
