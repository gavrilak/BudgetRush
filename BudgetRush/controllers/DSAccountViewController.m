//
//  DSAccountViewController.m
//  BudgetRush
//
//  Created by Lena on 24.11.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSAccountViewController.h"
#import "DSCategoryViewController.h"
#import "DSCurrencyViewController.h"
#import "DSDataManager.h"
#import "DSAccount.h"
#import "DSCurrency.h"
#import "DSCategory.h"
#import "Settings.h"

@interface DSAccountViewController ()

@end

@implementation DSAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    self.view.backgroundColor = colorBackgroundWhite;
    self.navigationController.navigationBar.topItem.title = @"My Accounts";
    self.tableView.separatorColor = colorBackgroundBlue;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [[NSUserDefaults standardUserDefaults] setObject: [NSDate new] forKey:@"date"];
    [[NSUserDefaults standardUserDefaults] setObject: _account == nil ? @"" : _account.name forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setObject: @"not selected" forKey:@"icon"];
    [[NSUserDefaults standardUserDefaults] setObject: @"" forKey:@"category"];
    [[NSUserDefaults standardUserDefaults] setObject: _account == nil ? @0 : @(_account.currency.ident - 1) forKey:@"currency"];
    if (_account != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:  @(_account.initBalance)  forKey:@"balance"];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:  @(0) forKey:@"balance"];
    }
    
}



- (void)setup {
    
    __unsafe_unretained typeof(self) weakSelf = self;
    [self addSection:[BOTableViewSection sectionWithHeaderTitle:@"" handler:^(BOTableViewSection *section) {
        
        
        [section addCell:[BOTextTableViewCell cellWithTitle:@"Name" key:@"name" handler:^(BOTextTableViewCell *cell) {
            cell.textField.placeholder = @"Enter name";
             cell.mainFont = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
            cell.mainColor = colorBlueFont;
            cell.selectedColor = colorBlue;
            cell.secondaryFont = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
            cell.secondaryColor = colorGreyFont;
            cell.inputErrorBlock = ^(BOTextTableViewCell *cell, BOTextFieldInputError error) {
                [weakSelf showInputErrorAlert:error];
            };
        }]];
        
        
        [section addCell:[BOTableViewCell cellWithTitle:@"Icon" key:@"icon" handler:^(BOTableViewCell *cell) {
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indicator"]];
            cell.detailTextLabel.text = @"not selected";
            cell.mainColor = colorBlueFont;
            cell.mainFont = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
            cell.selectedColor = colorBlue;
            cell.secondaryFont = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
            cell.secondaryColor = colorGreyFont;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
             cell.backgroundColor = [UIColor colorWithWhite:0 alpha: 0.1];
            
        }]];

        [section addCell:[BOChoiceTableViewCell cellWithTitle:@"Category" key:@"category" handler:^(BOChoiceTableViewCell *cell) {
     
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indicator"]];
            cell.mainColor = colorBlueFont;
             cell.mainFont = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
            cell.selectedColor = colorBlue;
            cell.secondaryFont = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
            cell.secondaryColor = colorGreyFont;
            NSMutableArray  *catNames = [[NSMutableArray alloc] init];
            for (DSCategory *cat in [DSDataManager sharedManager].categories) {
                [catNames addObject:cat.name];
            }
            cell.options = catNames;
            cell.destinationViewController = [DSCategoryViewController new];
            cell.detailTextLabel.text = @"not selected";
             cell.backgroundColor = [UIColor colorWithWhite:0 alpha: 0.1];
        }]];
        
        [section addCell:[BOChoiceTableViewCell cellWithTitle:@"Currency" key:@"currency" handler:^(BOChoiceTableViewCell *cell) {
            
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indicator"]];
            cell.mainColor = colorBlueFont;
            cell.mainFont = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
            cell.selectedColor = colorBlue;
            cell.secondaryFont = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
            cell.secondaryColor = colorGreyFont;
            NSMutableArray  *curNames = [[NSMutableArray alloc] init];
            for (DSCurrency *cur in [DSDataManager sharedManager].currencies) {
                [curNames addObject:cur.name];
            
            }
            cell.options = curNames;
            cell.destinationViewController = [DSCurrencyViewController new];
            
        }]];

        
        [section addCell:[BODateTableViewCell cellWithTitle:@"Date" key:@"date" handler:^(BODateTableViewCell *cell) {
       
            cell.dateFormat = @"dd MMM yyyy"; 
            cell.mainColor = colorBlueFont;
            cell.mainFont = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
            cell.selectedColor = colorBlue;
            cell.secondaryFont = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
            cell.secondaryColor = colorGreyFont;
            
            
        }]];
        
       [section addCell:[BONumberTableViewCell cellWithTitle:@"Balance" key:@"balance" handler:^(BONumberTableViewCell *cell) {
           cell.mainColor = colorBlueFont;
           cell.mainFont = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
           cell.selectedColor = colorBlue;
           cell.secondaryFont = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
           cell.secondaryColor = colorGreyFont;
            cell.textField.placeholder = @"$0.0";
            cell.numberOfDecimals = 2;
            cell.inputErrorBlock = ^(BOTextTableViewCell *cell, BOTextFieldInputError error) {
                [weakSelf showInputErrorAlert:error];
            };
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
   NSInteger selectedCurrency =  [currencyCell.setting.value integerValue];
    
    DSCurrency* currency = [[DSDataManager sharedManager].currencies objectAtIndex:selectedCurrency];
    
    
    if (_account == nil) {
    
        DSAccount *account = [DSAccount new];
        account.name =  [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
        account.currency = currency;
        account.initBalance = [[NSUserDefaults standardUserDefaults] doubleForKey:@"balance"];
        [[DSDataManager sharedManager] createAccount:account onSuccess:^(DSAccount *account) {
        
            [self.navigationController popViewControllerAnimated:YES];
        
        } onFailure:^(NSError *error) {
            [self.navigationController popViewControllerAnimated:YES];
        } ];
    } else {
        _account.name =  [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
        _account.currency = currency;
        _account.initBalance = [[NSUserDefaults standardUserDefaults] doubleForKey:@"balance"];
        [[DSDataManager sharedManager] updateAccount:_account onSuccess:^(DSAccount *account) {
            
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
    return 34.f;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.backgroundView.backgroundColor = colorBackgroundWhite;
}

@end
