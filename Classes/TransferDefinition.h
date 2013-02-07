//
//  TransferDefinition.h
//  FlameDragon
//
//  Created by sui toney on 13-2-6.
//  Copyright 2013 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDFileStream.h"
#import "FDRange.h"

@interface TransferDefinition : NSObject {

	int transferId;
	int fromCreatureDefId;
	int toCreatureDefId;
	
	int requireItemId;
	
	FDRange *apRange;
	FDRange *dpRange;
	FDRange *dxRange;
	FDRange *hpRange;
	FDRange *mpRange;
	FDRange *mvRange;
	
}

@property (assign) FDRange *apRange;
@property (assign) FDRange *dpRange;
@property (assign) FDRange *dxRange;
@property (assign) FDRange *hpRange;
@property (assign) FDRange *mpRange;
@property (assign) FDRange *mvRange;

@property (assign) int transferId;
@property (assign) int fromCreatureDefId;
@property (assign) int toCreatureDefId;
@property (assign) int requireItemId;

+(id) readFromFile:(FDFileStream *)stream;


@end
