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

@interface DSAccountViewController ()

@end

@implementation DSAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.navigationBar.topItem.title = @"My Accounts";
    [[NSUserDefaults standardUserDefaults] setObject: [NSDate new] forKey:@"date"];
    [[NSUserDefaults standardUserDefaults] setObject: @"" forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setObject: @"not selected" forKey:@"icon"];
    [[NSUserDefaults standardUserDefaults] setObject: @"not selected" forKey:@"category"];
    [[NSUserDefaults standardUserDefaults] setObject: @"not selected" forKey:@"currency"];
    [[NSUserDefaults standardUserDefaults] setObject: nil forKey:@"balance"];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setup {
    
    
    __unsafe_unretained typeof(self) weakSelf = self;
    [self addSection:[BOTableViewSection sectionWithHeaderTitle:nil handler:^(BOTableViewSection *section) {
        
        
        [section addCell:[BOTextTableViewCell cellWithTitle:@"Name" key:@"name" handler:^(BOTextTableViewCell *cell) {
            cell.textField.placeholder = @"Enter name";
            cell.inputErrorBlock = ^(BOTextTableViewCell *cell, BOTextFieldInputError error) {
                [weakSelf showInputErrorAlert:error];
            };
        }]];
        
        
        [section addCell:[BOTableViewCell cellWithTitle:@"Icon" key:@"icon" handler:^(BOTableViewCell *cell) {
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"not selected";
          
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }]];

        [section addCell:[BOChoiceTableViewCell cellWithTitle:@"Category" key:@"category" handler:^(BOChoiceTableViewCell *cell) {
     
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            NSMutableArray  *catNames = [[NSMutableArray alloc] init];
            for (DSCategory *cat in [DSDataManager sharedManager].categories) {
                
                [catNames addObject:cat.name];
                
            }
            cell.options = catNames;
            
            cell.destinationViewController = [DSCategoryViewController new];
            cell.detailTextLabel.text = @"not selected";
        }]];
        
        [section addCell:[BOChoiceTableViewCell cellWithTitle:@"Currency" key:@"currency" handler:^(BOChoiceTableViewCell *cell) {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            NSMutableArray  *curNames = [[NSMutableArray alloc] init];
            for (DSCurrency *cur in [DSDataManager sharedManager].currencies) {
            
                [curNames addObject:cur.name];
            
            }
            cell.options = curNames;
            //cell.detailTextLabel.text = @"USD";
            cell.destinationViewController = [DSCurrencyViewController new];
            
        }]];

        
       [section addCell:[BODateTableViewCell cellWithTitle:@"Date" key:@"date" handler:nil]];
        
       [section addCell:[BONumberTableViewCell cellWithTitle:@"Balance" key:@"balance" handler:^(BONumberTableViewCell *cell) {
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
    
    DSAccount *account = [DSAccount new];
    account.name =  [[NSUserDefaults standardUserDefaults] stringForKey:@"name"];
    account.currencyIdent = 4;
   [ [DSDataManager sharedManager] createAccount:account onSuccess:^(DSAccount *account) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } onFailure:^(NSError *error) {
         [self.navigationController popViewControllerAnimated:YES];
    } ];
    
   
    
}

- (IBAction) actionCancel:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
