//
//  ShoppingSelectAmorTargetDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-8.
//  Copyright 2012 ms. All rights reserved.
//

#import "ShoppingSelectAmorTargetDialog.h"

#import "DataDepot.h"
#import "ButtonFactory.h"

@implementation ShoppingSelectAmorTargetDialog

-(id) init
{
	self = [super init];
	
	CGPoint buttonLocation1 = CGPointMake([baseSprite size].width - 120, 20);
	ShoppingButton *button1 = [ButtonFactory createButton:ShoppingButtonType_BuyAmor];
	[button1 setLocation:buttonLocation1];
	
	[self addButton:button1];
	
	return self;
}

-(void) onClicked
{
	int selected = 1;
	
	NSLog(@"Select Target Index %d", selected);	
	id returnedObject = [NSNumber numberWithInt:selected];
	[self onConfirmedExit:returnedObject];
}

@end
