//
//  ShoppingChurchDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-5-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "ShoppingChurchDialog.h"
#import "ButtonFactory.h"

@implementation ShoppingChurchDialog

-(ShoppingButton *) generateButton1
{
	ShoppingButton *button1 = [ButtonFactory createButton:ShoppingButtonType_Info];
	[button1 setLocation:buttonLocation1];
	return button1;
}

-(ShoppingButton *) generateButton2
{
	ShoppingButton *button2 = [ButtonFactory createButton:ShoppingButtonType_Revive];
	[button2 setLocation:buttonLocation2];
	return button2;
}

-(ShoppingButton *) generateButton3
{
	ShoppingButton *button3 = [ButtonFactory createButton:ShoppingButtonType_Transfer];
	[button3 setLocation:buttonLocation3];
	return button3;
}

-(ShoppingButton *) generateButton4
{
	ShoppingButton *button4 = [ButtonFactory createButton:ShoppingButtonType_Exit];
	[button4 setLocation:buttonLocation4];
	//[button4 setCallback:self Method:@selector(onExit)];
	
	return button4;
}


@end
