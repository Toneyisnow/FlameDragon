//
//  FightingInformation.m
//  FlameDragon
//
//  Created by sui toney on 12-10-18.
//  Copyright 2012 ms. All rights reserved.
//

#import "FightingInformation.h"


@implementation FightingInformation

-(id) initWithAttackInfo:(AttackInformation *)attack1 attack2Info:(AttackInformation *)attack2 backInfo:(AttackInformation *)back1 back2Info:(AttackInformation *)back2
{
	self = [super init];
	
	// backgroundImageId = imageId;
	attackInfo1 = attack1 != nil ? [attack1 retain] : nil;
	attackInfo2 = attack2 != nil ? [attack2 retain] : nil;
	backInfo1 = back1 != nil ? [back1 retain] : nil;
	backInfo2 = back2 != nil ?[back2 retain] : nil;
	
	return self;
}

-(int) getBackGroundImageId
{
	return backgroundImageId;
}

-(AttackInformation *) getAttackInfo1
{
	return attackInfo1;
}

-(AttackInformation *) getAttackInfo2
{
	return attackInfo2;
}

-(AttackInformation *) getBackInfo1
{
	return backInfo1;
}

-(AttackInformation *) getBackInfo2
{
	return backInfo2;
}


-(void) dealloc
{
	if (attackInfo1 != nil) {
		[attackInfo1 release];
	}
	if (attackInfo2 != nil) {
		[attackInfo2 release];
	}
	if (backInfo1 != nil) {
		[backInfo1 release];
	}
	if (backInfo2 != nil) {
		[backInfo2 release];
	}
	
	[super dealloc];
}

@end
