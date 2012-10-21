//
//  MagicalInformation.h
//  FlameDragon
//
//  Created by sui toney on 12-10-20.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "AttackInformation.h"

@interface MagicalInformation : NSObject {

	NSMutableArray *informationList;
}

-(void) addInformation:(AttackInformation *)info;
-(NSArray *) getInformations;

@end
