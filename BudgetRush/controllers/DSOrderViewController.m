//
//  DSOrderViewController.m
//  BudgetRush
//
//  Created by Dima on 30.11.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSOrderViewController.h"
#import "DSCategoryViewController.h"
#import "DSDataManager.h"
#import "DSOrder.h"
#import "DSCategory.h"
#import "DSCurrency.h"
#import "Settings.h"


@implementation DSOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    self.view.backgroundColor = colorBackgroundWhite;
    self.navigationController.navigationBar.topItem.title = @"New transaction";
    self.tableView.separatorColor = colorBackgroundBlue;
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [[NSUserDefaults standardUserDefaults] setDouble: _order == nil ? 0 : _order.sum  forKey:@"sum"];
    [[NSUserDefaults standardUserDefaults] setObject: _isIncome ? @"Income":  @"Expenses"  forKey:@"sumName"];
    [[NSUserDefaults standardUserDefaults] setObject:_order == nil ? @"" : _order.category.name forKey:@"category"];
    [[NSUserDefaults standardUserDefaults] setObject: _order != nil ? _order.date : [NSDate new] forKey:@"date"];
    [[NSUserDefaults standardUserDefaults] setObject: @"not selected" forKey:@"icon"];
    [[NSUserDefaults standardUserDefaults] setObject: _accName forKey:@"account"];
    [[NSUserDefaults standardUserDefaults] setObject: _order == nil ? @"" : _order.descr forKey:@"descr"];
    
}

- (void)setup {
    
    __unsafe_unretained typeof(self) weakSelf = self;
    [self addSection:[BOTableViewSection sectionWithHeaderTitle:@"" handler:^(BOTableViewSection *section) {
        
        
        [section addCell:[BONumberTableViewCell cellWithTitle:@"" key:@"sum" handler:^(BONumberTableViewCell *cell) {
            cell.mainColor = colorBlueFont;
            cell.selectedColor = colorBlue;
            cell.secondaryFont = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
            cell.textField.placeholder = @"$0.0";
            cell.numberOfDecimals = 2;
            cell.inputErrorBlock = ^(BOTextTableViewCell *cell, BOTextFieldInputError error) {
                [weakSelf showInputErrorAlert:error];
            };
        }]];
        
        
        [section addCell:[BOTableViewCell cellWithTitle:@"Sum" key:@"sumName" handler:^(BOTableViewCell *cell) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.mainColor = colorBlueFont;
            cell.selectedColor = colorBlue;
            cell.secondaryFont = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }]];

        [section addCell:[BOChoiceTableViewCell cellWithTitle:@"Category" key:@"category" handler:^(BOChoiceTableViewCell *cell) {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.mainColor = colorBlueFont;
            cell.selectedColor = colorBlue;
            cell.secondaryFont = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
            NSMutableArray  *catNames = [[NSMutableArray alloc] init];
            for (DSCategory *cat in [DSDataManager sharedManager].categories) {
                [catNames addObject:cat.name];
            }
            cell.options = catNames;
            cell.destinationViewController = [DSCategoryViewController new];
            cell.detailTextLabel.text = @"not selected";
        }]];
        
        [section addCell:[BODateTableViewCell cellWithTitle:@"Date" key:@"date" handler:^(BODateTableViewCell *cell) {
            cell.mainColor = colorBlueFont;
            cell.selectedColor = colorBlue;
            cell.secondaryFont = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
        }]];
        
        
        [section addCell:[BOTableViewCell cellWithTitle:@"Icon" key:@"icon" handler:^(BOTableViewCell *cell) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"not selected";
            cell.mainColor = colorBlueFont;
            cell.selectedColor = colorBlue;
            cell.secondaryFont = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }]];
        
      
        
    }]];
}

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showInputErrorAlert:(BOTextFieldInputError)error {
    NSString *message;
    
    switch (error) {
        case BOTextFieldInputTooShortError:
            message = @"The text is too short";
            break;
            
        case BOTextFieldInputNotNumericError:
            message = @"Please input a valid number";
            break;
            
        default:
            break;
    }
    
    if (message) {
        [self presentAlertControllerWithTitle:@"Error" message:message];
    }
}

- (IBAction) actionSave:(id)sender {
    
    BOChoiceTableViewCell *currencyCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    NSInteger selectedCategory =  [currencyCell.setting.value integerValue];
    
    DSCategory* category = [[DSDataManager sharedManager].categories objectAtIndex:selectedCategory];
    
    
    if (_order == nil) {
        
        DSOrder *order = [DSOrder new];
        order.descr =  [[NSUserDefaults standardUserDefaults] stringForKey:@"descr"];
        order.category = category;
        order.sum = [[NSUserDefaults standardUserDefaults] doubleForKey:@"sum"];
        [[DSDataManager sharedManager] createOrder:order onSuccess:^(DSOrder *order) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } onFailure:^(NSError *error) {
            [self.navigationController popViewControllerAnimated:YES];
        } ];
    } else {
        _order.descr =  [[NSUserDefaults standardUserDefaults] stringForKey:@"descr"];
        _order.category = category;
        _order.sum = [[NSUserDefaults standardUserDefaults] doubleForKey:@"sum"];
        [[DSDataManager sharedManager] updateOrder:_order onSuccess:^(DSOrder *order) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } onFailure:^(NSError *error) {
            [self.navigationController popViewControllerAnimated:YES];
        } ];
        
        
    }
    
    
}

- (IBAction) actionCancel:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.f;
}


@end
