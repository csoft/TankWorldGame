//
//  AppDelegate.h
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-14.
//  Copyright C-SOFT 2012年. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;



@end
