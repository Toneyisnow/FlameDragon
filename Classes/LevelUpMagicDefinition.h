//
//  LevelUpMagicDefinition.h
//  FlameDragon
//
//  Created by sui toney on 12-12-13.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"

@interface LevelUpMagicDefinition : NSObject {

	int creatureDefId;
	int creatureLevel;
	int magicId;
	
}

+(id) readFromFile:(FDFileStream *)stream;

-(NSNumber *) getKey;

@property (nonatomic) int creatureDefId;
@property (nonatomic) int creatureLevel;
@property (nonatomic) int magicId;

@end
