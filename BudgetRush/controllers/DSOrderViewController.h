//
//  DSOrderViewController.h
//  BudgetRush
//
//  Created by Dima on 30.11.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Bohr/Bohr.h>
@class DSOrder;
@class DSAccount;

@interface DSOrderViewController  : BOTableViewController

@property (nonatomic, strong) DSOrder* order;
@property (nonatomic, assign) NSInteger isIncome;
@property (nonatomic, strong) DSAccount* account;

@end
