//
//  AppDelegate.m
//  BudgetRush
//
//  Created by Dima Soladtenko on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "AppDelegate.h"
#import "Settings.h"
#import "DSDataManager.h"
#import "AFNetworkActivityLogger.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
  
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-2000, -2000) forBarMetrics:UIBarMetricsDefault];
    // Override point for customization after application launch.
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];

    NSString* user = [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
    NSString* pass = [[NSUserDefaults standardUserDefaults] objectForKey:kUserPass];
    
    
    

 
    
    if(user!=nil) {
    [[DSDataManager sharedManager] loginUserEmail:user password:pass OnSuccess:^(id object) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
       UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];

        UIViewController *tabViewController = [storyboard instantiateViewControllerWithIdentifier:@"tabBarVC"];
        [navigationController setViewControllers:@[viewController,tabViewController] animated:YES];

        _window.rootViewController = navigationController;
        [_window makeKeyAndVisible];

    } onFailure:^(NSError *error) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
        
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
         [navigationController setViewControllers:@[viewController] animated:YES];
        
        _window.rootViewController = navigationController;
        [_window makeKeyAndVisible];

    }];
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        
        UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
         [navigationController setViewControllers:@[viewController] animated:YES];
        
        _window.rootViewController = navigationController;
        [_window makeKeyAndVisible];

    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
