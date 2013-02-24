//
//  FDSprite.m
//  FlameDragon
//
//  Created by sui toney on 11-11-5.
//  Copyright 2011 ms. All rights reserved.
//

#import "FDSprite.h"
#import "Common.h"

@implementation FDSprite

-(id) init
{
	self = [super init];
	ccsprite = nil;
	return self;
}

-(id) initFromFile:(NSString *)fileName
{
	self = [super init];
	
	ccsprite = [[CCSprite alloc] initWithFile:fileName];

	
	// ccsprite.scaleX = 1.02;
	// ccsprite.scaleY = 1.02;
	
	return self;
}

-(id) initFromImage:(FDImage *)image withRect:(CGRect)rect {
    self = [super init];
    
    ccsprite = [[CCSprite alloc] initWithTexture:[image texture] rect:rect];
    return self;
}

-(id) initFromFile:(NSString *)fileName withRect:(CGRect)rect
{
	self = [super init];
	/*
	CCSpriteBatchNode *batch = [CCSpriteBatchNode batchNodeWithFile:fileName capacity:12];
	ccsprite = [CCSprite spriteWithBatchNode:batch rect:rect];
	[ccsprite retain];
	*/
    ccsprite = [[CCSprite alloc] initWithFile:fileName rect:rect];
    
	return self;
}

-(id) initWithString:(NSString *)str Size:(int)size
{
	self = [super init];
	
	//CCLabelTTF *label = [CCLabelTTF labelWithString:str fontName:@"Marker Felt" fontSize:size];
	CCLabelTTF *label = [CCLabelTTF labelWithString:str fontName:@"Arial" fontSize:size];
	label.color = ccc3(200, 200, 200);
	
	ccsprite = [label retain];
	
	return self;
}

-(id) initWithSprite:(FDSprite *) sprite
{
    if (sprite == nil || [sprite getSprite] == nil) {
        return nil;
    }
    
    self = [super init];
	
    ccsprite = [CCSprite spriteWithTexture:[sprite getSprite].texture];
	[ccsprite retain];
    
	return self;
}

-(CCSprite *) getSprite
{
	return ccsprite;
}

-(void) addSprite:(FDSprite *)s zOrder:(int)order
{
	[ccsprite addChild:[s getSprite] z:order tag:0];
}

-(void) removeSprite:(FDSprite *)s
{
	[ccsprite removeChild:[s getSprite] cleanup:FALSE];
}

-(CGPoint) location
{
	return ccsprite.position;
}

-(void) setLocation:(CGPoint)loc
{
	[ccsprite setPosition:loc];
}

-(void) updateZOrder:(int)zorder
{
	[ccsprite.parent reorderChild:ccsprite z:zorder];
}

-(CGSize) size
{
	return ccsprite.boundingBox.size;
}

-(void) setOpacity:(int)o
{
	ccsprite.opacity = o;
}

-(void) setScaleX:(float)x Y:(float)y
{
	ccsprite.scaleX = x;
	ccsprite.scaleY = y;
}

-(CGPoint) getScale
{
	return CGPointMake(ccsprite.scaleX, ccsprite.scaleY);
}

-(void) setAnchorPoint:(CGPoint)pos
{
	ccsprite.anchorPoint = pos;
}

-(void) setColorR:(int)r G:(int)g B:(int)b
{
	[ccsprite setColor:ccc3(r,g,b)];
}

-(void) setVisible:(BOOL)visible
{
	ccsprite.visible = visible;
}

-(void) setSprite:(CCSprite *)s
{
	ccsprite = s;
}

-(void) setImage:(FDImage *)image
{
    [self setImage:image ChangeSize:NO];
	
    /*
    CCTexture2D *texture = [image texture];
	[ccsprite setTexture:texture];
    */
    
	//pixelsWide
	//ccsprite set = texture.boundingBox.size;
	
	//[[ccsprite setTextureRect:d];
	//texture.boundingBox.size = image.boundingBox.size;
}

-(void) setImage:(FDImage *)image ChangeSize:(BOOL)sizeChanged {
   
    CCTexture2D *texture = [image texture];
	[ccsprite setTexture:texture];
    
    if (sizeChanged) {
        CGSize texSize = [texture contentSize];
        [ccsprite setTextureRect:CGRectMake(0, 0, texSize.width, texSize.height)];
    }
}

-(void) setFrame:(NSString *)fileName {
    
    // NSString *fullName = [Common fileFullPath:fileName];
    // [UIImage imageNamed:fileName];
    
    CCSpriteFrameCache *cache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [cache addSpriteFramesWithFile:fileName];
    
    CCSpriteFrame *frame = [cache spriteFrameByName:fileName];
    [ccsprite setDisplayFrame:frame];
}


-(void) addToLayer:(CCLayer *)layer
{
	[layer addChild:ccsprite];
}

-(void) removeFromLayer
{
	[ccsprite removeFromParentAndCleanup:FALSE];
}

-(void) dealloc
{
	[ccsprite release];
	[super dealloc];
}

@end
