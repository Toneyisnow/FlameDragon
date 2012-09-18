//
//  FlameDragonAppDelegate.h
//  FlameDragon
//
//  Created by sui toney on 11-11-1.
//  Copyright ms 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface FlameDragonAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
