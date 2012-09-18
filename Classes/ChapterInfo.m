//
//  ChapterInfo.m
//  FlameDragon
//
//  Created by sui toney on 11-11-22.
//  Copyright 2011 ms. All rights reserved.
//

#import "ChapterInfo.h"
#import "FDSpriteStore.h"
#import "FDLocalString.h"
#import "FDWindow.h"

@implementation ChapterInfo

-(id) init
{
	self = [super init];		
	baseSprite = [[[FDSpriteStore instance] sprite:@"ChapterInfo.png"] retain];
	return self;
}

-(void) setChapterNo:(int)chapterNo TurnNo:(int)turnNo
{
	FDSprite *chapterSprite = [[FDSprite alloc] initWithString:[NSString stringWithFormat:@"%02d", chapterNo] Size:10];
	FDSprite *turnSprite = [[FDSprite alloc] initWithString:[NSString stringWithFormat:@"%03d", turnNo] Size:10];
	
	[chapterSprite setLocation:CGPointMake(75, 158)];
	[turnSprite setLocation:CGPointMake(122, 158)];
	
	[baseSprite addSprite:chapterSprite zOrder:1];
	[baseSprite addSprite:turnSprite zOrder:1];
}

-(void) setConditionWin:(int)winId Lose:(int)loseId
{
	NSString *winConditionStr = [FDLocalString message:winId];
	NSString *loseConditionStr = [FDLocalString message:loseId];
	
	FDSprite *winCondition = [[FDSprite alloc] initWithString:winConditionStr Size:14];
	FDSprite *loseCondition = [[FDSprite alloc] initWithString:loseConditionStr Size:14];
	
	[winCondition setAnchorPoint:CGPointMake(0, 0)];
	[loseCondition setAnchorPoint:CGPointMake(0, 0)];
	
	[winCondition setLocation:CGPointMake(5, 110)];
	[loseCondition setLocation:CGPointMake(5, 55)];
	
	[baseSprite addSprite:winCondition zOrder:1];
	[baseSprite addSprite:loseCondition zOrder:1];
}

-(void) setFriendCount:(int)fCount EnemyCount:(int)eCount NpcCount:(int)nCount
{
	FDSprite *fSprite = [[FDSprite alloc] initWithString:[NSString stringWithFormat:@"%02d", fCount] Size:10];
	FDSprite *eSprite = [[FDSprite alloc] initWithString:[NSString stringWithFormat:@"%02d", eCount] Size:10];
	FDSprite *nSprite = [[FDSprite alloc] initWithString:[NSString stringWithFormat:@"%02d", nCount] Size:10];
	
	[eSprite setLocation:CGPointMake(50, 23)];
	[fSprite setLocation:CGPointMake(112, 23)];
	[nSprite setLocation:CGPointMake(160, 23)];
	
	[baseSprite addSprite:fSprite zOrder:1];
	[baseSprite addSprite:eSprite zOrder:1];
	[baseSprite addSprite:nSprite zOrder:1];
}

-(void) setMoney:(int)quantity
{
	FDSprite *quantitySprite = [[FDSprite alloc] initWithString:[NSString stringWithFormat:@"%08d", quantity] Size:10];
	[quantitySprite setLocation:CGPointMake(90, 6)];
	[baseSprite addSprite:quantitySprite zOrder:1];
}

/*
-(void) show:(CCLayer *)l
{
	
	[baseSprite setLocation:[FDWindow screenCenter]];
	[baseSprite setScaleX:1.5 Y:1.5];
	
	[super show:l];
}
*/

-(void) clickedOn:(CGPoint)location
{
	[self close];
}

@end
