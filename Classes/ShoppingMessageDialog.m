//
//  ShoppingMessageDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-6-5.
//  Copyright 2012 ms. All rights reserved.
//

#import "ShoppingMessageDialog.h"
#import "FDWindow.h"

@implementation ShoppingMessageDialog


-(id) initWithMessage:(NSString *)message From:(ShoppingDialog *)dialog
{
	self = [super initFrom:dialog];
	
	[self addLabel:message Location:[FDWindow shoppingMessageLocation]];
	
	return self;
}

-(void) onClicked:(CGPoint)location
{
	[self onExit];
}

@end
