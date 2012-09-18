//
//  LevelUpDefinition.h
//  FlameDragon
//
//  Created by sui toney on 12-1-19.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDRange.h"
#import "FDFileStream.h"

@interface LevelUpDefinition : NSObject {

	int identifier;
	
	FDRange *hpRange;
	FDRange *mpRange;
	FDRange *apRange;
	FDRange *dpRange;
	FDRange *dxRange;
}

+(id) readFromFile:(FDFileStream *)stream;

-(int) getId;

@property (nonatomic) int identifier;
@property (nonatomic, retain) FDRange *hpRange;
@property (nonatomic, retain) FDRange *mpRange;
@property (nonatomic, retain) FDRange *apRange;
@property (nonatomic, retain) FDRange *dpRange;
@property (nonatomic, retain) FDRange *dxRange;

@end
