//
//  ShoppingShowFriendsDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-9.
//  Copyright 2012 ms. All rights reserved.
//

#import "ShoppingShowFriendsDialog.h"

#import "ButtonFactory.h"
#import "DataDepot.h"

@implementation ShoppingShowFriendsDialog


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
	CCLOG(@"Select Friend Index %d", selected);
	id returnedObject = [NSNumber numberWithInt:selected];
	[self onConfirmedExit:returnedObject];
}


@end
