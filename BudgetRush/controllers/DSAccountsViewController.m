//
//  DSAccountsViewController.m
//  BudgetRush
//
//  Created by Lena on 24.11.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSAccountsViewController.h"
#import "DSDataManager.h"
#import "DSAccount.h"

@interface DSAccountsViewController () <UITableViewDataSource, UITableViewDelegate> {
    
    NSMutableArray* _accounts ;
}

@end

@implementation DSAccountsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    [self navigationController].topViewController.navigationItem.hidesBackButton = YES;
    [self loadData];
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self navigationController].topViewController.title = @"My Accounts";
    [self navigationController].topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAccount)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) addAccount{
    [self performSegueWithIdentifier:@"showAccount" sender:self];
    
}

- (void) loadData {
    [[DSDataManager sharedManager] getAccountsOnSuccess:^(NSArray *accounts) {
        _accounts = [accounts mutableCopy];
        [self.tableView reloadData];
    } onFailure:^(NSError *error) {
        NSLog(@"Error");
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_accounts count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* ident = @"accountCell";
    
    DSAccount* account = [_accounts objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ident];
    
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    cell.textLabel.text = account.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", account.balance];
    return cell;
}

#pragma mark - UITableViewDelegate
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
