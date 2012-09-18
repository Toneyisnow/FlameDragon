//
//  IField.h
//  FlameDragon
//
//  Created by sui toney on 11-11-8.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDCreature.h"
#import "FDMenuItem.h"

@protocol IField

-(FDCreature *) getCreatureByPos:(CGPoint)pos;
-(FDMenuItem *) getMenuItemByPos:(CGPoint)pos;

-(NSMutableArray *) getObjectsByPos:(CGPoint)pos;

-(CGPoint) getObjectPos:(FDBattleObject *)obj;

@end
