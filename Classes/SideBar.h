//
//  SideBar.h
//  FlameDragon
//
//  Created by sui toney on 11-12-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "IBar.h"
#import "BattleField.h"

@interface SideBar : IBar {

    BattleField *battleField;
    
    FDImage *backgroundImage;
    FDSprite *blockSprite;
    FDSprite *apSprite;
    FDSprite *dpSprite;
    
    FDCreature *creature;
    FDSprite *objectSprite;
}

-(id) initWithField:(BattleField *)field;

-(CGPoint) getPosLeft;
-(CGPoint) getPosRight;
-(void) updateContent;
-(NSString *) formatNumber:(int)value;

-(void) takeTick;

-(void) clearSprite:(FDSprite *)sprite;

@end
