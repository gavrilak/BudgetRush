//
//  DSCurrencyViewController.m
//  BudgetRush
//
//  Created by Dima Soldatenko on 12/11/15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSCurrencyViewController.h"

@interface DSCurrencyViewController ()

@end

@implementation DSCurrencyViewController

- (void)setup {
    
    self.title = @"Choice options";
    
    [self addSection:[BOTableViewSection sectionWithHeaderTitle:nil handler:^(BOTableViewSection *section) {
        [section addCell:[BOOptionTableViewCell cellWithTitle:@"Some description for option 1" key:@"choice_2" handler:^(BOOptionTableViewCell *cell) {
            cell.footerTitle = @"Some footer for option 1";
        }]];
        
        [section addCell:[BOOptionTableViewCell cellWithTitle:@"Some description for option 2" key:@"choice_2" handler:^(BOOptionTableViewCell *cell) {
            cell.footerTitle = @"Some footer for option 2";
        }]];
        
        [section addCell:[BOOptionTableViewCell cellWithTitle:@"Some description for option 3" key:@"choice_2" handler:^(BOOptionTableViewCell *cell) {
            cell.footerTitle = @"Some footer for option 3";
        }]];
        
        [section addCell:[BOOptionTableViewCell cellWithTitle:@"Some description for option 4" key:@"choice_2" handler:^(BOOptionTableViewCell *cell) {
            cell.footerTitle = @"Some footer for option 4";
        }]];
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
