//
//  DSCategoryViewController.m
//  BudgetRush
//
//  Created by Dima Soldatenko on 12/11/15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSCategoryViewController.h"
#import "DSCategory.h"
#import "DSDataManager.h"

@interface DSCategoryViewController ()

@end

@implementation DSCategoryViewController

- (void)setup {
    
    self.title = @"Choise category";
    
    [self addSection:[BOTableViewSection sectionWithHeaderTitle:@"Profit default Category" handler:^(BOTableViewSection *section) {
        
        
        for (DSCategory* cat in [DSDataManager sharedManager].categories) {
            int r = (rand() % 4)+1;
            
            [section addCell:[BOOptionTableViewCell cellWithTitle:cat.name key:@"category" handler:^(BOOptionTableViewCell *cell) {
                cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_categories%d",r]];
            }]];
            
        }
        
     }]];
}


@end
