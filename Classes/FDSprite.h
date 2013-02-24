//
//  FDSprite.h
//  FlameDragon
//
//  Created by sui toney on 11-11-5.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDImage.h"

@interface FDSprite : NSObject {

	CCSprite *ccsprite;
}

-(id) initFromFile:(NSString *)fileName;
-(id) initFromFile:(NSString *)fileName withRect:(CGRect)rect;
-(id) initFromImage:(FDImage *)image withRect:(CGRect)rect;
-(id) initWithString:(NSString *)str Size:(int)size;
-(id) initWithSprite:(FDSprite *) sprite;

-(CCSprite *) getSprite;
-(void) setSprite:(CCSprite *)s;
-(void) setImage:(FDImage *)image;
-(void) setImage:(FDImage *)image ChangeSize:(BOOL)sizeChanged;

-(void) setFrame:(NSString *)fileName;

-(void) setOpacity:(int)o;
-(void) setColorR:(int)r G:(int)g B:(int)b;
-(void) setVisible:(BOOL)visible;

-(void) addSprite:(FDSprite *)s zOrder:(int)order;
-(void) removeSprite:(FDSprite *)s;
-(void) updateZOrder:(int)zorder;

-(void) addToLayer:(CCLayer *)layer;
-(void) removeFromLayer;

-(CGPoint) location;
-(void) setLocation:(CGPoint)loc;

-(CGSize) size;

-(void) setScaleX:(float)x Y:(float)y;
-(void) setAnchorPoint:(CGPoint)pos;

-(CGPoint) getScale;
@end
