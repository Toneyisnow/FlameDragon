//
//  Shopping2ConfirmDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-12.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2ConfirmDialog.h"
#import "FDWindow.h"

@implementation Shopping2ConfirmDialog

-(id) initWithMessage:(NSString *)message
{
	self = [super init];
	
	NSRange start = [message rangeOfString:@"#"];
	if (start.location != NSNotFound) {
		
		NSString *message1 = [message substringWithRange:NSMakeRange(0, start.location)];
		NSString *message2 = [message substringWithRange:NSMakeRange(start.location + 1, [message length] - start.location - 1)];
	
		[self addLabel:message1 Location:[FDWindow shoppingMessageLocation]];
		[self addLabel:message2 Location:[FDWindow shoppingMessageLocation2]];
		
	}
	else {
		[self addLabel:message Location:[FDWindow shoppingMessageLocation]];
	}
	
	return self;
}

-(void) onClicked:(CGPoint)location
{
	int returnValue = 1;
	
	[self onExit:[NSNumber numberWithInt:returnValue]];
}

@end
