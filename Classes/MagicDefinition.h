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
	MagicType_Recover = 2,
	MagicType_Offensive = 3,
	MagicType_Defensive = 4
	
} MagicType;

@interface MagicDefinition : NSObject {

	int identifier;
	NSString *name;
	MagicType magicType;
	
	int effectScope;	// usally 
	int effectRange;	// 
	int hittingRate;
	int mpCost;
    int allowAfterMove;
    int aiConsiderRate;
	FDRange *quantityRange;
    int apInvolvedRate;
    BOOL isCross;
}

+(id) readFromFile:(FDFileStream *)stream;

-(void) takeOffensiveEffect:(id)obj;
-(void) takeDefensiveEffect:(id)obj;
-(BOOL) hasDefensiveEffectOn:(id)obj;

-(int) baseExperience;

-(BOOL) hasAnimation;

-(BOOL) canFireAfterMove;

@property (nonatomic, retain) NSString *name;
@property (nonatomic) MagicType magicType;

@property (nonatomic) int identifier;
@property (nonatomic) int effectScope;
@property (nonatomic) int effectRange;
@property (nonatomic) int hittingRate;
@property (nonatomic) int mpCost;
@property (nonatomic) int allowAfterMove;
@property (nonatomic) BOOL isCross;

@property (nonatomic) int aiConsiderRate;

@property (nonatomic, retain) FDRange *quantityRange;
@property (nonatomic) int apInvolvedRate;

@end
