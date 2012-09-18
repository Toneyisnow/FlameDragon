//
//  FightTargetInfo.h
//  FlameDragon
//
//  Created by sui toney on 11-11-24.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"


@interface FightTargetInfo : NSObject {

	
	int creatureAniId;
	int maxHp;
	int previousHp;
	int reducedHp;
	
}

-(id) initWithAniId:(int)aId Max:(int)m Previous:(int)p Reduce:(int)r;

@property (nonatomic) int creatureAniId;
@property (nonatomic) int maxHp;
@property (nonatomic) int previousHp;
@property (nonatomic) int reducedHp;

@end
