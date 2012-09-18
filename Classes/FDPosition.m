#import "FDPosition.h"

@implementation FDPosition

-(id) initX:(int)x Y:(int)y
{
	self = [super init];
	
	position = CGPointMake(x, y);
	
	return self;
}

+(id) positionX:(int)x Y:(int)y
{
	return [[self alloc] initX:x Y:y];
}

-(int) x
{
	return (int)position.x;
}
-(int) y
{
	return (int)position.y;
}

-(void) updateX:(int)delta
{
	position = CGPointMake(position.x + delta, position.y);
}

-(void) updateY:(int)delta
{
	position = CGPointMake(position.x, position.y + delta);
}

-(CGPoint) posValue
{
	return position;
}

-(NSNumber *) hashKey
{
	return [NSNumber numberWithInt:(position.x + 100 * position.y)];
}

-(BOOL) isEqual:(id)anObject
{
	return [self isEqualToPos:(FDPosition *)anObject];
}

-(id) copyWithZone:(NSZone *)zone
{
	return [self retain];
}

-(BOOL) isEqualToPos:(FDPosition *)pos
{
	return [FDPosition isEqual:[self posValue] With:[pos posValue]];
}

+(BOOL) isEqual:(CGPoint)pos1 With:(CGPoint)pos2
{
	return (pos1.x == pos2.x && pos1.y == pos2.y);
}

@end