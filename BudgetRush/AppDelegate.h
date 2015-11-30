//
//  AppDelegate.h
//  BudgetRush
//
//  Created by Dima Soladtenko on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

[[DSDataManager sharedManager] loginUserEmail:self.fieldEmail.text password:self.fieldPassword.text OnSuccess:^(DSUser *user) {


@end

