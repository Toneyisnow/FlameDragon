//
//  LinkedDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-5-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "LinkedDialog.h"


@implementation LinkedDialog


-(id) initWithDialog:(ShoppingDialog *)dlg Next:(LinkedDialog *)n
{
	self = [super init];
	
	currentDialog = [dlg retain];
	
	if (n != nil) {
		next = [n retain];
	} else {
		next = nil;
	}

	return self;
}

-(ShoppingDialog *) currentDialog
{
	return currentDialog;
}

-(LinkedDialog *) getNext
{
	return next;
}

-(void) dealloc
{
	[next release];
	[currentDialog release];
	[super dealloc];
}


@end
