//
//  DSCurrencyViewController.m
//  BudgetRush
//
//  Created by Dima Soldatenko on 12/11/15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSCurrencyViewController.h"
#import "DSCurrency.h"
#import "DSDataManager.h"

@interface DSCurrencyViewController ()

@end

@implementation DSCurrencyViewController

- (void)setup {
    
    self.title = @"Choice currency";
    
    [self addSection:[BOTableViewSection sectionWithHeaderTitle:@"USD default cureency" handler:^(BOTableViewSection *section) {
        
        
            for (DSCurrency* cur in [DSDataManager sharedManager].currencies) {
            
            [section addCell:[BOOptionTableViewCell cellWithTitle:cur.name key:@"currency" handler:^(BOOptionTableViewCell *cell) {
            
            }]];
            
        }

        
    }]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
