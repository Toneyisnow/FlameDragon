//
//  Shopping2ShowFriendsDialog.m
//  FlameDragon
//
//  Created by sui toney on 12-9-12.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2ShowFriendsDialog.h"
#import "DataDepot.h"
#import "SWScrollView.h"

@implementation Shopping2ShowFriendsDialog


-(id) init
{
	self = [super init];
	
	//[self addLabel:@"List All Friends ..." Location:[FDWindow shoppingMessageLocation]];
	
	SWScrollView *view = [SWScrollView viewWithViewSize: CGSizeMake(300, 120)];
	view.position = ccp(10, 20);
	view.contentOffset = ccp(0, 0);
	view.direction = SWScrollViewDirectionVertical;
	view.clipsToBounds = YES;
	
	
	CCSprite *sprite1 = [CCSprite spriteWithFile:@"Icon-001-02.png"];
	CCSprite *sprite2 = [CCSprite spriteWithFile:@"Icon-002-02.png"];
	CCSprite *sprite3 = [CCSprite spriteWithFile:@"Icon-003-02.png"];
	CCSprite *sprite4 = [CCSprite spriteWithFile:@"Icon-004-02.png"];
	
	view.contentSize = CGSizeMake(300, 350);
	
	sprite1.position = ccp(10, 0);
	sprite2.position = ccp(10, 30);
	sprite3.position = ccp(10, 60);
	sprite4.position = ccp(10, 90);
	
	[view addChild:sprite1];
	[view addChild:sprite2];
	[view addChild:sprite3];
	[view addChild:sprite4];
	[[baseSprite getSprite] addChild:view];
	
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
