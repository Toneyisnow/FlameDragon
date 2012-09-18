//
//  Shopping2MessageDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-12.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2MessageDialog.h"
#import "FDWindow.h"

@implementation Shopping2MessageDialog


-(id) initWithMessage:(NSString *)message
{
	self = [super init];
	
	[self addLabel:message Location:[FDWindow shoppingMessageLocation]];
	
	return self;
}

-(void) onClicked:(CGPoint)location
{
	[self onExit:[NSNumber numberWithInt:0]];
}

@end