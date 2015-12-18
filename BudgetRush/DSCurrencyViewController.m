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
#import "Settings.h"

@interface DSCurrencyViewController ()

@end

@implementation DSCurrencyViewController

- (void)setup {
    
    self.title = @"Currency";
    self.tableView.bounces = NO;
    self.tableView.separatorColor = colorBackgroundBlue;
    
    DSCurrency *defaultCurrency = [[DSDataManager sharedManager].currencies objectAtIndex:0];
    
    [self addSection:[BOTableViewSection sectionWithHeaderTitle:[NSString stringWithFormat: @"%@ default Currency", defaultCurrency.name] handler:^(BOTableViewSection *section) {
        
        for (DSCurrency* cur in [DSDataManager sharedManager].currencies) {
                [section addCell:[BOOptionTableViewCell cellWithTitle:cur.name key:@"currency" handler:^(BOOptionTableViewCell *cell) {
                cell.selectedColor = colorBlue;
            }]];
            
        }

        
    }]];
}


@end
