//
//  Shopping2SelectAmorTargetDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-12.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2SelectAmorTargetDialog.h"

#import "DataDepot.h"
#import "ButtonFactory.h"
#import "FDWindow.h"

@implementation Shopping2SelectAmorTargetDialog

-(id) init
{
	self = [super init];
	
	[self addLabel:@"Select One Friend ..." Location:[FDWindow shoppingMessageLocation]];

	return self;
}

-(void) onClicked:(CGPoint)location
{
	int selected = 0;
	
	NSLog(@"Select Target Index %d", selected);	
	id returnedObject = [NSNumber numberWithInt:selected];
	[self onExit:returnedObject];
}

@end

