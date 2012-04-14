//
//  AppDelegate.h
//  test
//
//  Created by 学宝 陈 on 12-4-14.
//  Copyright C-SOFT 2012年. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface TankWorldAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;



@end
