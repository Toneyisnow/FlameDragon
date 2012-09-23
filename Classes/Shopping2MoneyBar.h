//
//  Shopping2MoneyBar.h
//  FlameDragon
//
//  Created by sui toney on 12-9-23.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "ChapterRecord.h"
#import "IBar.h"
#import "FDSprite.h"

@interface Shopping2MoneyBar : IBar {

	ChapterRecord *chapterRecord;
	id parentLayer;

	int lastMoneyAmount;
	
	FDSprite *moneySprite;
}

-(id) initWithRecord:(ChapterRecord *)record;

-(void) updateAmount;
-(void) updateAmountCompleted;

-(void) drawAmout:(int)amount;

@end
