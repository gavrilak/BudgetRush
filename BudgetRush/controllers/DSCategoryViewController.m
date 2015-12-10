//
//  DSCategoryViewController.m
//  BudgetRush
//
//  Created by Dima Soldatenko on 12/11/15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSCategoryViewController.h"

@interface DSCategoryViewController ()

@end

@implementation DSCategoryViewController

- (void)setup {
    
    self.title = @"Categories";
    
    [self addSection:[BOTableViewSection sectionWithHeaderTitle:@"Profit default Category" handler:^(BOTableViewSection *section) {
        [section addCell:[BOOptionTableViewCell cellWithTitle:@"Profit" key:@"category" handler:^(BOOptionTableViewCell *cell) {
            cell.imageView.image = [UIImage imageNamed:@"ic_categories1"];
        }]];
        
        [section addCell:[BOOptionTableViewCell cellWithTitle:@"Salary" key:@"category" handler:^(BOOptionTableViewCell *cell) {
            cell.imageView.image = [UIImage imageNamed:@"ic_categories2"];
        }]];
        
        [section addCell:[BOOptionTableViewCell cellWithTitle:@"Credit Card" key:@"category" handler:^(BOOptionTableViewCell *cell) {
           cell.imageView.image = [UIImage imageNamed:@"ic_categories3"];
        }]];
        
        [section addCell:[BOOptionTableViewCell cellWithTitle:@"Savings" key:@"category" handler:^(BOOptionTableViewCell *cell) {
          cell.imageView.image = [UIImage imageNamed:@"ic_categories4"];
        }]];
    }]];
}


@end
