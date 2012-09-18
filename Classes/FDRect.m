//
//  FDRect.m
//  FlameDragon
//
//  Created by sui toney on 11-11-24.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDRect.h"


@implementation FDRect

-(id) initWithX:(int)x Y:(int)y Width:(int)w Height:(int)h
{
	self = [super init];
	
	posX = x;
	posY = y;
	width = w;
	height = h;
	
	return self;
}

-(BOOL) isIn:(CGPoint)pos
{
	return (pos.x >= posX && pos.x <= posX + width - 1 && pos.y >= posY && pos.y <= posY + height -1);
}


@end
