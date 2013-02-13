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

@property (retain) FDRange *apRange;
@property (retain) FDRange *dpRange;
@property (retain) FDRange *dxRange;
@property (retain) FDRange *hpRange;
@property (retain) FDRange *mpRange;
@property (retain) FDRange *mvRange;

@property (assign) int transferId;
@property (assign) int fromCreatureDefId;
@property (assign) int toCreatureDefId;
@property (assign) int requireItemId;

+(id) readFromFile:(FDFileStream *)stream;


@end
