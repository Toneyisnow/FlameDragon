//
//  CreatureDefinition.h
//  FlameDragon
//
//  Created by sui toney on 11-11-24.
//  Copyright 2011 ms. All rights reserved.
//

#import "cocos2d.h"
#import "FDFileStream.h"
#import "CreatureData.h"

@interface CreatureDefinition : NSObject {

	int identifier;
	NSString *name;
	
	int race;
	int occupation;
	
	CreatureData *data;
	
	/*
	int level;
	//int ex;
	
	int hp;
	int mp;
	
	int ap;
	int dp;
	
	int dx;
	int hit;
	int ev;
	
	int mv;
	int baseExp;
	
	int attackRange;
	
	NSMutableArray *itemList;
	NSMutableArray *magicList;
	*/
}

+(id) readFromFile:(FDFileStream *)stream;

-(int) getId;
-(int) getAnimationId;

-(int) attackRange;

-(NSString *) getRaceString;
-(NSString *) getOccupationString;


@property (nonatomic) int identifier;
@property (nonatomic, retain) NSString *name;
@property (nonatomic) int race;
@property (nonatomic) int occupation;

@property (nonatomic, retain) CreatureData *data;

/*
@property (nonatomic) int level;

@property (nonatomic) int ap;
@property (nonatomic) int dp;
@property (nonatomic) int dx;

@property (nonatomic) int hp;
@property (nonatomic) int mp;
@property (nonatomic) int mv;
@property (nonatomic) int baseExp;

@property (nonatomic, readonly) NSMutableArray *itemList;
@property (nonatomic, readonly) NSMutableArray *magicList;

//@property (nonatomic) int attackRange;
*/

@end
