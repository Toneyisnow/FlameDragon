//
//  Shopping2ShowDeadFriendsDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-13.
//  Copyright 2012 ms. All rights reserved.
//


#import "Shopping2ShowDeadFriendsDialog.h"

@implementation Shopping2ShowDeadFriendsDialog


-(id) init
{
	self = [super init];
	
	[self addLabel:@"List All Dead Friends ..." Location:[FDWindow shoppingMessageLocation]];
	
	
	return self;
}

-(void) onClicked:(CGPoint)location
{
	int selected = 0;
	
	NSLog(@"Select Friend Index %d", selected);	
	id returnedObject = [NSNumber numberWithInt:selected];
	[self onExit:returnedObject];
}


@end