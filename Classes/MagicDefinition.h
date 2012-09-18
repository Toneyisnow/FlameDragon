//
//  MagicDefinition.h
//  FlameDragon
//
//  Created by sui toney on 11-11-23.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDRange.h"
#import "FDFileStream.h"

typedef enum MagicType
{
	MagicType_Attack = 1,
	MagicType_Recover = 2
} MagicType;

@interface MagicDefinition : NSObject {

	int identifier;
	NSString *name;
	MagicType magicType;
	
	int effectScope;	// usally 
	int effectRange;	// 
	int hittingRate;
	int mpCost;
	FDRange *quantityRange;
}

+(id) readFromFile:(FDFileStream *)stream;

-(void) takeEffect:(id)obj;

@property (nonatomic, retain) NSString *name;
@property (nonatomic) MagicType magicType;

@property (nonatomic) int identifier;
@property (nonatomic) int effectScope;
@property (nonatomic) int effectRange;
@property (nonatomic) int hittingRate;
@property (nonatomic) int mpCost;

@property (nonatomic, retain) FDRange *quantityRange;

@end
