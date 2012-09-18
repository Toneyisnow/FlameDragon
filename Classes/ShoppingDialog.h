//
//  ShoppingDialog.h
//  FlameDragon
//
//  Created by sui toney on 12-5-11.
//  Copyright 2012 ms. All rights reserved.
//

#import "cocos2d.h"
#import "IBar.h"
#import "ShoppingButton.h"
#import "ChapterRecord.h"
#import "ItemDefinition.h"

@interface ShoppingDialog : IBar {

	ChapterRecord *chapterRecord;
	
	NSMutableArray *buttonArray;
	
	id responder;
	SEL exitCallback;
	
	SEL pushCallback;
	
	id selectedCallback;
	SEL selectedMethod;

	//id returnedObject;
}

@property (nonatomic, assign) id responder;
@property (assign) SEL exitCallback;
@property (assign) SEL pushCallback;

-(id) initFrom:(ShoppingDialog *)origin;

-(void) addButton:(ShoppingButton *)button;
-(void) clickedOn:(CGPoint)location;

-(void) addLabel:(NSString *)str Location:(CGPoint)location;

-(BOOL) isClicked:(CGPoint)loc;

-(void) setRecord:(ChapterRecord *)r;

-(void) setCallback:(id)obj PushMethod:(SEL)pm ExitMethod:(SEL)em;

-(void) setSelectedCallback:(id)obj Method:(SEL)method;

//-(void) setPushCallback:(id)obj Method:(SEL)m;
-(void) onPush:(ShoppingDialog *)dialog;
//-(void) setExitCallback:(id)obj Method:(SEL)m;
-(void) onExit;
-(void) onCancel;

-(void) onClicked:(CGPoint)location;

-(void) onConfirmedExit:(id)returnedObject;

-(ItemDefinition *) getItemDefinition:(int)shopIndex Type:(int)shopType Index:(int)index;
//-(NSMutableArray *) getProductList:(int)shopIndex Type:(int)shopType;

@end
