//
//  SideBar.m
//  FlameDragon
//
//  Created by sui toney on 11-12-13.
//  Copyright 2011 ms. All rights reserved.
//

#import "SideBar.h"
#import "MessageLayer.h"
#import "FDSpriteStore.h"
#import "Constants.h"
#import "FDImage.h"

@implementation SideBar

/*
-(id) init
{
	self = [super init];
	
	baseSprite = [[FDSpriteStore instance] sprite:@"SideBar.png"];
	[baseSprite setScaleX:[Constants battleMapScale] Y:[Constants battleMapScale]];
	[baseSprite retain];
	
	return self;
}
*/

-(id) initWithField:(BattleField *)field {
    
    self = [super init];
	
	baseSprite = [[FDSpriteStore instance] sprite:@"SideBar.png"];
	[baseSprite setScaleX:[Constants battleMapScale] Y:[Constants battleMapScale]];
	[baseSprite retain];
	
    battleField = field;
    
    NSString *fileName = [NSString stringWithFormat:@"Chapter-%02d.png", [battleField getChapterId]];
    backgroundImage = [[FDImage alloc] initFromFile:fileName];
    
    blockSprite = nil;
    apSprite = nil;
    dpSprite = nil;
    objectSprite = nil;
    creature = nil;
    
	return self;
}

-(void) show:(CCLayer *)layer
{
	[super setLocation:[self getPosRight]];
	[super show:layer];
}

-(void) updateContent {
    
    if (battleField == nil) {
        return;
    }
    
    @try {
    
        [self clearSprite:blockSprite];
        [self clearSprite:apSprite];
        [self clearSprite:dpSprite];
        [self clearSprite:objectSprite];
        blockSprite = nil;
        apSprite = nil;
        dpSprite = nil;
        objectSprite = nil;
        creature = nil;
    
    CGPoint position = [battleField getCursorPos];
    GroundBlock *block = [[battleField getGroundField] blockAtX:position.x Y:position.y];
    if (block == nil) {
        return;
    }
    
    NSString *apString = [NSString stringWithFormat:@"A %@", [self formatNumber:[block attackPoint]]];
    NSString *dpString = [NSString stringWithFormat:@"D %@", [self formatNumber:[block defencePoint]]];
    apSprite = [[FDSprite alloc] initWithString:apString Size:11];
    dpSprite = [[FDSprite alloc] initWithString:dpString Size:11];
    [apSprite setLocation:CGPointMake(48, 20)];
    [dpSprite setLocation:CGPointMake(48, 10)];
    
    CGPoint cursorLocation = [battleField convertPosToLoc:position];
    CGRect rect = CGRectMake(cursorLocation.x - 0.5*[Constants unitSize],
                             [battleField mapSize].height * [Constants unitSize] - cursorLocation.y - 0.5*[Constants unitSize],
                             [Constants unitSize],
                             [Constants unitSize]);
    blockSprite = [[FDSprite alloc] initFromImage:backgroundImage withRect:rect];
    [blockSprite setLocation:CGPointMake(17, 16)];
    
	[baseSprite addSprite:blockSprite zOrder:1];
    [baseSprite addSprite:apSprite zOrder:1];
    [baseSprite addSprite:dpSprite zOrder:1];
    
    creature = [battleField getCreatureByPos:position];
    FDTreasure *treasure = [battleField getTreasureAt:position];
    if (creature != nil) {
        objectSprite = [[FDSprite alloc] initWithSprite:[creature getSprite]];
    } else if (treasure != nil && treasure.treasureType != TreasureType_Hidden && [treasure hasOpened]) {
        objectSprite = [[FDSprite alloc] initWithSprite:[treasure getSprite]];
    }
    
    
    if (objectSprite != nil) {
       [objectSprite setLocation:CGPointMake(17, 16)];
       [baseSprite addSprite:objectSprite zOrder:2];
    }
        
    }
    @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
    }
    
}

-(void) takeTick {
    
    if (creature != nil && objectSprite != nil) {
        
         FDImage *image = [[FDImage alloc] initWithTexture:
                                [[creature getSprite] getSprite].texture];
        [objectSprite setImage:image];
        [image release];
    }
}

-(void) clearSprite:(FDSprite *)sprite {
    
    if (sprite != nil) {
        [sprite removeFromLayer];
        [sprite release];
    }
}

-(NSString *) formatNumber:(int)value {
    
    if (value >= 0) {
        return [NSString stringWithFormat:@"+ %02d", value];
    }
    else {
        return [NSString stringWithFormat:@"-- %02d", -value];
    }
    return nil;
}

-(CGPoint) getPosLeft
{
	return CGPointMake(10 + [baseSprite size].width/2, 10 + [baseSprite size].height/2);
}

-(CGPoint) getPosRight
{
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	
	CGPoint leftpos = [self getPosLeft];
	return CGPointMake(winSize.width - leftpos.x, leftpos.y);
}

-(void) dealloc
{
    if (blockSprite != nil) {
        [blockSprite release];
    }
    
    if (apSprite != nil) {
        [apSprite release];
    }
    if (dpSprite != nil) {
        [dpSprite release];
    }
    
    if (backgroundImage != nil)
    {
        [backgroundImage release];
    }
    
    [super dealloc];
}
@end
