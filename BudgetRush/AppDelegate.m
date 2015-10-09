//
//  AppDelegate.m
//  BudgetRush
//
//  Created by Dima Soladtenko on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "AppDelegate.h"
#import "DSServerManager.h"
#import "AFNetworkActivityLogger.h"
#import "AFHTTPRequestOperationLogger.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   // [[AFNetworkActivityLogger sharedLogger] startLogging];
    [[AFHTTPRequestOperationLogger sharedLogger] startLogging];
    [AFHTTPRequestOperationLogger sharedLogger].level =  AFLoggerLevelDebug;
       [[DSServerManager sharedManager] getTokenForUser:@"admin" andPassword:@"1" onSuccess:^(DSAccessToken *token) {
         //  NSInteger ident = 6;
           
         
        /*   [[DSServerManager sharedManager] getUser:ident onSuccess:^(DSUser *account) {
               NSLog(@"ok");
           } onFailure:^(NSError *error) {
               NSLog(@"No_ok");
           }];
           
           DSUser* usr = [DSUser new];
           usr.obj_id = 6;
           usr.name = @"ios user";
           usr.password = @"storng(passwoR0d";
           usr.role = userRole;
           [[DSServerManager sharedManager] postUser:usr onSuccess:^(DSUser *account) {
                NSLog(@"ok");
           } onFailure:^(NSError *error) {
                NSLog(@"no_ok");
           }];
           [[DSServerManager sharedManager] getUsersOnSuccess:^(NSArray *accounts) {
               NSLog(@"ok");
           } onFailure:^(NSError *error) {
                NSLog(@"No_ok");
           }];
           [[DSServerManager sharedManager] deleteUser:ident onSuccess:^(id success) {
               NSLog(@"ok");
           } onFailure:^(NSError *error) {
                NSLog(@"No_ok");
           }];*/
       /*    NSInteger ident = 6;
           
           
           [[DSServerManager sharedManager] getCurrency:ident onSuccess:^(DSCurrency *account) {
               NSLog(@"ok");
           } onFailure:^(NSError *error) {
               NSLog(@"No_ok");
           }];
           
           DSCurrency* cur = [DSCurrency new];
           cur.obj_id = 5;
           cur.name = @"ios currency after put";
           cur.shortName = @"ios";
           cur.symbol =@"i";
           //cat.currency_id = 1;
           cur.code = 1;
           [[DSServerManager sharedManager] putCurrency:cur onSuccess:^(DSCurrency *account) {
               NSLog(@"ok");
           } onFailure:^(NSError *error) {
               NSLog(@"no_ok");
           }];
           [[DSServerManager sharedManager] getCurrenciesOnSuccess:^(NSArray *accounts) {
               NSLog(@"ok");
           } onFailure:^(NSError *error) {
               NSLog(@"No_ok");
           }];
            [[DSServerManager sharedManager] deleteCurrency:ident onSuccess:^(id success) {
            NSLog(@"ok");
            } onFailure:^(NSError *error) {
            NSLog(@"No_ok");
            }];*/
           NSInteger ident = 6;
           
           
           [[DSServerManager sharedManager] getOrder:ident onSuccess:^(DSOrder *account) {
               NSLog(@"ok");
           } onFailure:^(NSError *error) {
               NSLog(@"No_ok");
           }];
           
           DSOrder* ord = [DSOrder new];
           ord.obj_id = 5;
           ord.type = typeOrder;
           
           ord.amount = [[NSDecimalNumber numberWithInt:1] decimalValue];
           ord.date = [NSDate dateWithTimeIntervalSince1970:978307200 ];
           ord.acc_id = 1;
           ord.cur_id = 1;
           ord.con_id = 1;
           ord.cat_id = 1;
            //cat.currency_id = 1;
    
           [[DSServerManager sharedManager] postOrder:ord onSuccess:^(DSOrder *account) {
               NSLog(@"ok");
           } onFailure:^(NSError *error) {
               NSLog(@"no_ok");
           }];
           [[DSServerManager sharedManager] getOrdersOnSuccess:^(NSArray *accounts) {
               NSLog(@"ok");
           } onFailure:^(NSError *error) {
               NSLog(@"No_ok");
           }];
         /*  [[DSServerManager sharedManager] deleteOrder:ident onSuccess:^(id success) {
               NSLog(@"ok");
           } onFailure:^(NSError *error) {
               NSLog(@"No_ok");
           }];*/
    } onFailure:^(NSError *error) {
        NSLog(@"failure");
    }];
    
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
