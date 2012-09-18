//
//  MagicBox.h
//  FlameDragon
//
//  Created by sui toney on 11-11-19.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "IMessage.h"
#import "FDSprite.h"
#import "FDCreature.h"
#import "CreatureDato.h"
#import "CreatureDetail.h"

typedef enum MagicOperatingType
{
	MagicOperatingType_Select,
	MagicOperatingType_ShowOnly
	
} MagicOperatingType;

@interface MagicBox : IMessage {

	MagicOperatingType operatingType;
	
	FDCreature *creature;
	int selectedIndex;
	
	FDSprite *indicator;

	CreatureDato *datoBar;
	CreatureDetail *detailsBar;
}

-(id) initWithCreature:(FDCreature *)c Type:(MagicOperatingType)type;

-(void) initData;
-(CGPoint) getMagicPosition:(int)i;

-(void) showIndicator:(int)selected;
-(void) selectItem:(int)selected;

@property (nonatomic) int selectedIndex;



@end
