//
//  FightScene.m
//  FlameDragon
//
//  Created by sui toney on 11-11-24.
//  Copyright 2011 ms. All rights reserved.
//

#import "FightScene.h"
#import "MainGameScene.h"
#import "FDSpriteStore.h"
#import "DataDepot.h"
#import "FDSlideAnimation.h"
#import "FDFightFrameDefinition.h"

@implementation FightScene


-(id) init
{
	self = [super init];
	
	screenSize = [[CCDirector sharedDirector] winSize];
	
	layer = [CCLayer node];
	
	// add layer as a child to scene
	[self addChild: layer];
	
	return self;
}

-(void) setPrevious:(CCScene *)p
{
	previous = p;
}

-(void) setParameter:(int)bId Self:(FDCreature *)cre Targets:(NSMutableArray *)tar FightBack:(BOOL)back
{
	backgroundId = bId;
	creature = cre;
	targets = [tar retain];
	fightBack = back;
	
	subjectAttackAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightAttack Id:[[creature getDefinition] getAnimationId]];
	subjectIdleAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightIdle Id:[[creature getDefinition] getAnimationId]];

	FDCreature *target = [targets objectAtIndex:0];
	targetAttackAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightAttack Id:[[target getDefinition] getAnimationId]];
	targetIdleAni = [[DataDepot depot] getAnimationDefinition:AnimationType_FightIdle Id:[[target getDefinition] getAnimationId]];


}

-(void) start
{	
	tickCount = 0;
	[self schedule: @selector(step:)];
	
	background = [[FDSpriteStore instance] sprite:[NSString stringWithFormat:@"Background-%02d.png", backgroundId]];
	[background addToLayer:layer];
	[background setLocation:CGPointMake(screenSize.width/2, screenSize.height/2)];
	[background retain];
	
	tai = [[FDSpriteStore instance] sprite:[NSString stringWithFormat:@"Tai-%02d.png", backgroundId]];
	[tai addToLayer:layer];
	[tai setLocation:CGPointMake(screenSize.width * 0.7, screenSize.height * 0.25)];
	[tai retain];
	
	
	// Subject
	subject = [[FDSpriteStore instance] sprite:[NSString stringWithFormat:@"Fight-%03d-1-01.png", [[creature getDefinition] getAnimationId]]];
	[subject addToLayer:layer];
	[subject setLocation:CGPointMake(screenSize.width /2, screenSize.height /2)];
	[subject retain];
	
	// Creature Bar
	subjectBar = [[CreatureInfoBar alloc] initWithCreature:creature ClickedOn:CGPointMake(0, 0)]; 
	[subjectBar setHp:creature.hpPrevious Mp:creature.mpPrevious];
	
	// Target Bar
	targetBar = [[CreatureInfoBar alloc] initWithCreature:[targets objectAtIndex:0] ClickedOn:CGPointMake(0, 0)]; 
	FDCreature *target = [targets objectAtIndex:0];
	[targetBar setHp:target.hpPrevious Mp:target.mpPrevious];
	
	if ([creature getCreatureType] == CreatureType_Friend || [creature getCreatureType] == CreatureType_Npc) {
		[subjectBar setLocation:[self friendBarPos]];
		[targetBar setLocation:[self enemyBarPos]];
	}
	else {
		[subjectBar setLocation:[self enemyBarPos]];
		[targetBar setLocation:[self friendBarPos]];
	}
	[subjectBar show:layer];
	[targetBar show:layer];
	
	creatureAnimation = [[FDCombinedAnimation alloc] init];
	int iteration;
	if (fightBack)
	{
		iteration = 8;
	}
	else {
		iteration = 3;
	}

	for (int i = 0; i < iteration; i++) {
		
		FDSlideAnimation *ani;
		if (i == 1) {
				ani = [[FDSlideAnimation alloc] initWithDefinition:subjectAttackAni Sprite:subject];
				[ani onRenderFrame:@selector(onSubjectAttack:) Id:self];
		}
		else {
				ani = [[FDSlideAnimation alloc] initWithDefinition:subjectIdleAni Sprite:subject];
		}
		[creatureAnimation addAnimation:ani];
		[ani release];
	}
	

		
	// Target
	targetObject = [[FDSpriteStore instance] sprite:[NSString stringWithFormat:@"Fight-%03d-1-01.png", [[[targets objectAtIndex:0] getDefinition] getAnimationId]]];
	[targetObject addToLayer:layer];
	[targetObject setLocation:CGPointMake(screenSize.width /2, screenSize.height /2)];
	[targetObject retain];
	
	targetAnimation = [[FDCombinedAnimation alloc] init];
	for (int i = 0; i < iteration; i++) {
		
		FDSlideAnimation *ani;
		if (fightBack && i == 5) {
			ani = [[FDSlideAnimation alloc] initWithDefinition:targetAttackAni Sprite:targetObject];
			[ani onRenderFrame:@selector(onTargetAttack:) Id:self];
		}
		else {
			ani = [[FDSlideAnimation alloc] initWithDefinition:targetIdleAni Sprite:targetObject];
		}
		[targetAnimation addAnimation:ani];
		[ani release];
	}
	
}

-(void) step: (ccTime) delta
{
	// NSLog(@"Scene tick");
	tickCount ++;
	
	[creatureAnimation takeTick:tickCount];
	[targetAnimation takeTick:tickCount];
	
	if ([creatureAnimation hasFinished] && [targetAnimation hasFinished]) {
		
		CCLOG(@"Close this scene.");
		[[CCDirector sharedDirector] popScene];

		// Perform post method
		[object performSelector:postMethod withObject:obj1 withObject:obj2];
	}
	
}

-(void) setPostMethod:(SEL)sel param1:(id)o1 param2:(id)o2 Obj:(id)obj
{
	postMethod = sel;
	obj1 = o1;
	obj2 = o2;
	object = obj;
}

-(void) onSubjectAttack:(FDFrameDefinition *)frame
{
	FDFightFrameDefinition *fightFrame = (FDFightFrameDefinition *)frame;
	if ([fightFrame isHitting]) {
		
		[subjectBar setHp:-1 Mp:creature.data.mpCurrent];
		
		FDCreature *target = [targets objectAtIndex:0];
		[targetBar setHp:target.data.hpCurrent Mp:-1];
	}
}

-(void) onTargetAttack:(FDFrameDefinition *)frame
{
	FDFightFrameDefinition *fightFrame = (FDFightFrameDefinition *)frame;
	if ([fightFrame isHitting]) {
		[subjectBar setHp:creature.data.hpCurrent Mp:-1];
	}
	
}

-(CGPoint) friendBarPos
{
	return CGPointMake(300, 280);
}

-(CGPoint) enemyBarPos
{
	return CGPointMake(110, 55);
	
}

-(void) dealloc
{
	[targets release];
	
	[super dealloc];
}


@end
