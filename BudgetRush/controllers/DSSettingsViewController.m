//
//  DSSettingsViewController.m
//  BudgetRush
//
//  Created by Lena on 24.11.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSSettingsViewController.h"
#import "Settings.h"


@interface DSSettingsViewController ()

@end

@implementation DSSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = colorBackgroundBlue;
    self.tableView.bounces = NO;
    self.view.backgroundColor = colorBackgroundWhite;

}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self navigationController].topViewController.title = @"Settings";
    [self navigationController].topViewController.navigationItem.rightBarButtonItem = nil;

}


- (void)setup {
    
    __unsafe_unretained typeof(self) weakSelf = self;
    [self addSection:[BOTableViewSection sectionWithHeaderTitle:nil handler:^(BOTableViewSection *section) {
        [section addCell:[BOTableViewCell cellWithTitle:@"Currency" key:nil handler:^(BOTableViewCell *cell) {
            cell.detailTextLabel.text = @"USD";
            cell.mainFont = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indicator"]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.mainColor = colorBlueFont;
            cell.selectedColor = colorBlue;
            cell.backgroundColor = [UIColor colorWithWhite:0 alpha: 0.2];
        }]];
        
     /*   [section addCell:[BOTableViewCell cellWithTitle:@"Change passsword" key:nil handler:^(BOTableViewCell *cell) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.mainColor = colorBlueFont;
            cell.selectedColor = colorBlue;
        }]];*/
        [section addCell:[BOButtonTableViewCell cellWithTitle:@"Logout" key:nil handler:^(BOButtonTableViewCell *cell) {
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            cell.mainFont = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"indicator"]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.mainColor = colorBlueFont;
            cell.selectedColor = colorBlue;
            cell.actionBlock = ^{
                [weakSelf presentAlertController];

            };
        }]];
        
    }]];
}

- (void)presentAlertController {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Are you sure you want to Logout?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserName];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserPass];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.navigationController popToRootViewControllerAnimated:YES];

    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
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



@end
