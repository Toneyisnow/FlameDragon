#import "cocos2d.h"


@interface FDPosition : NSObject
{
	CGPoint position;
}

-(id) initX:(int)x Y:(int)y;

+(id) positionX:(int)x Y:(int)y;

-(int) x;
-(int) y;

-(void) updateX:(int)delta;
-(void) updateY:(int)delta;

-(CGPoint) posValue;

-(BOOL) isEqual:(id)anObject;
-(id) copyWithZone:(NSZone *)zone;
-(NSNumber *) hashKey;


+(BOOL) isEqual:(CGPoint)pos1 With:(CGPoint)pos2;

-(BOOL) isEqualToPos:(FDPosition *)pos;
@end