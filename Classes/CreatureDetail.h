//
//  CreatureDetail.h
//  FlameDragon
//
//  Created by sui toney on 11-12-15.
//  Copyright 2011 ms. All rights reserved.
//

#import "IBar.h"
#import "FDCreature.h"

@interface CreatureDetail : IBar {

	FDCreature *creature;
}

-(id) initWithCreature:(FDCreature *)creature;

-(void) initData;
-(void) addInt:(int)value Dimen:(int)dimen Pos:(CGPoint) pos;
-(void) addString:(NSString *)str Pos:(CGPoint) pos;

@end
