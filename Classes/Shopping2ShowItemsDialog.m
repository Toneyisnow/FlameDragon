//
//  Shopping2ShowItemsDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-12.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2ShowItemsDialog.h"


@implementation Shopping2ShowItemsDialog

-(id) initWithItemList:(NSMutableArray *)itemList
{
	self = [super init];
	
	
	
	[self addLabel:@"List All Items" Location:[FDWindow shoppingMessageLocation]];

	return self;
}

-(void) onClicked:(CGPoint)location
{
	int selected = 1;
	
	NSLog(@"Select Item Index %d", selected);	
	id returnedObject = [NSNumber numberWithInt:selected];
	[self onExit:returnedObject];
}

@end
