//
//  COAppDelegate.m
//  CODialog
//
//  Created by Erik Aigner on 12.04.12.
//  Copyright (c) 2012 chocomoko.com. All rights reserved.
//

#import "COAppDelegate.h"

#import "COViewController.h"

@implementation COAppDelegate
@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  self.viewController = [[COViewController alloc] initWithNibName:@"COViewController" bundle:nil];
  self.window.rootViewController = self.viewController;
  [self.window makeKeyAndVisible];
  return YES;
}

@end
