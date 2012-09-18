//
//  DataDepot.h
//  FlameDragon
//
//  Created by sui toney on 11-11-23.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "ItemDefinition.h"
#import "MagicDefinition.h"
#import "CreatureDefinition.h"
#import "AnimationDefinition.h"
#import "LevelUpDefinition.h"
#import "ShopDefinition.h"

@interface DataDepot : NSObject {

	NSMutableDictionary *itemDictionary;
	NSMutableDictionary *magicDictionary;
	NSMutableDictionary *creatureDictionary;
	NSMutableDictionary *animationDictionary;
	NSMutableDictionary *levelUpDictionary;
	NSMutableDictionary *shopDictionary;
	
}

+(DataDepot *) depot;

-(void) loadAllDictionaries;
-(void) loadItemDictionary;
-(void) loadMagicDictionary;
-(void) loadCreatureDictionary;
-(void) loadAnimationDictionary;
-(void) loadLevelUpDictionary;
-(void) loadShopDictionary;

-(ItemDefinition *) getItemDefinition:(int)itemId;
-(MagicDefinition *) getMagicDefinition:(int)magicId;
-(CreatureDefinition *) getCreatureDefinition:(int)creatureDefId;
-(AnimationDefinition *) getAnimationDefinition:(AnimationType)type Id:(int)aniId;
-(LevelUpDefinition *) getLevelUpDefinition:(int)creatureDefId;
-(ShopDefinition *) getShopDefinition:(int)chapterId Type:(DataDepotShopType)shopType;

@end
