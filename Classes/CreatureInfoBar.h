//
//  CreatureInfoBar.h
//  FlameDragon
//
//  Created by sui toney on 11-12-2.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDCreature.h"
#import "FDSprite.h"
#import "IBar.h"

@interface CreatureInfoBar : IBar {

	FDCreature *creature;
	
	FDSprite *hpBar;
	FDSprite *mpBar;
	FDSprite *hpValue;
	FDSprite *mpValue;
	
    FDSprite *nameSprite;
    FDSprite *levelSprite;
    
	CGPoint clickedLocation;
}

-(id) initWithCreature:(FDCreature *)c ClickedOn:(CGPoint)location;
-(void) setCreature:(FDCreature *)c;

-(void) setHp:(int)hp Mp:(int)mp;

//-(void) showInField:(CCLayer *)l;

@end
