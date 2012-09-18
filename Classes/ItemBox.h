//
//  ItemBox.h
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


typedef enum ItemOperatingType
{
	ItemOperatingType_Use,
	ItemOperatingType_Exchange,
	ItemOperatingType_Equip,
	ItemOperatingType_Drop,
	ItemOperatingType_ShowOnly
	
} ItemOperatingType;


@interface ItemBox : IMessage {

	FDCreature *creature;
	int selectedIndex;
	FDSprite *indicator;
	
	ItemOperatingType operting;
	
	CreatureDato *datoBar;
	CreatureDetail *detailsBar;
	
}

-(id) initWithCreature:(FDCreature *)c Type:(ItemOperatingType)type;

-(void) initData;

-(CGPoint) getItemPosition:(int)i;
//-(CGPoint) convertToBoxLocation:(CGPoint)pos;

-(void) selectItem:(int)selected;
-(void) showIndicator:(int)selected;

@property (nonatomic) int selectedIndex;

@end
