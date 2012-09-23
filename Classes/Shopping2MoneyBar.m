//
//  Shopping2MoneyBar.m
//  FlameDragon
//
//  Created by sui toney on 12-9-23.
//  Copyright 2012 ms. All rights reserved.
//

#import "Shopping2MoneyBar.h"
#import "Shopping2Layer.h"
#import "Constants.h"
#import "FDWindow.h"
#import "FDSpriteStore.h"

@implementation Shopping2MoneyBar

-(id) initWithRecord:(ChapterRecord *)record
{
	self = [super init];
	
	baseSprite = [[FDSpriteStore instance] sprite:@"Shop_MoneyBar.png"];
	[baseSprite retain];

	chapterRecord = record;
	lastMoneyAmount = chapterRecord.money;
	
	moneySprite = NULL;
	
	return self;
}

-(void) show:(CCLayer *)layer
{
	[baseSprite setScaleX:[Constants villageScale] Y:[Constants villageScale]];
	[baseSprite setLocation:[FDWindow moneyBarLocation]];
	[baseSprite setAnchorPoint:CGPointMake(0, 0)];
	[super show:layer];
	
	[self drawAmout:chapterRecord.money];
	NSLog(@"Money Bar Shown.");
	
	parentLayer = layer;
}

-(void) updateAmount
{
	[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateAmountCompleted) userInfo:nil repeats:FALSE];
	
	//[(Shopping2Layer *)parentLayer updateMoneyBarCompleted];
}

-(void) updateAmountCompleted
{
	[self drawAmout:chapterRecord.money];
	lastMoneyAmount = chapterRecord.money;
	
	[(Shopping2Layer *)parentLayer updateMoneyBarCompleted];
	[NSTimer scheduledTimerWithTimeInterval:0.5 target:(Shopping2Layer *)parentLayer selector:@selector(updateMoneyBarCompleted) userInfo:nil repeats:FALSE];
}

-(void) drawAmout:(int)amount
{
	NSString *str = [NSString stringWithFormat:@"$ %08d", amount];
	
	if (moneySprite != NULL) {
		[baseSprite removeSprite:moneySprite];
	}
	moneySprite = [[FDSprite alloc] initWithString:str Size:10];
	[moneySprite setLocation:CGPointMake(5, 0)];
	[moneySprite setAnchorPoint:CGPointMake(0, 0)];
	[baseSprite addSprite:moneySprite zOrder:1];
	
	 
}
@end
