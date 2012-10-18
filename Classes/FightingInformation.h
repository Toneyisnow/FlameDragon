//
//  FightingInformation.h
//  FlameDragon
//
//  Created by sui toney on 12-10-18.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "AttackInformation.h"

@interface FightingInformation : NSObject {

	//int backgroundImageId;
	
	AttackInformation *attackInfo1;
	AttackInformation *attackInfo2;
	AttackInformation *backInfo1;
	AttackInformation *backInfo2;
	
	
}

-(id) initWithAttackInfo:(AttackInformation *)attack1 attack2Info:(AttackInformation *)attack2 backInfo:(AttackInformation *)back1 back2Info:(AttackInformation *)back2;

-(int) getBackGroundImageId;
-(AttackInformation *) getAttackInfo1;
-(AttackInformation *) getAttackInfo2;
-(AttackInformation *) getBackInfo1;
-(AttackInformation *) getBackInfo2;


@end
