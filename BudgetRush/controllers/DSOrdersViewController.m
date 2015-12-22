//
//  DSOrdersViewController.m
//  BudgetRush
//
//  Created by Lena on 30.11.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "Settings.h"
#import "DSOrdersViewController.h"
#import "DsOrderViewController.h"
#import "DSDataManager.h"
#import "DSOrder.h"
#import "DSCategory.h"
#import "DSCurrency.h"
#import "DSOrderTableViewCell.h"

@interface DSOrdersViewController () <UITableViewDataSource, UITableViewDelegate> {
    
    __weak IBOutlet UILabel *_todayLabel;
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UISegmentedControl * _segmentControl;
    __weak IBOutlet UIView  *_segmentView;
    __weak IBOutlet UIImageView *_accountImage;
    __weak IBOutlet UILabel *_nameLabel;
    __weak IBOutlet UILabel *_categoryLabel;
    __weak IBOutlet UILabel *_sumLabel;
    
    DSOrder* _selectedOrder;
    NSMutableArray* _expenseOrders;
    NSMutableArray* _incomeOrders;
    NSInteger _selectedSegment;
}

@end

@implementation DSOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
   _tableView.separatorColor = colorBackgroundBlue;
   _tableView.bounces = NO;

    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd MMM"];
    _todayLabel.text = [NSString stringWithFormat:@"Today %@", [format stringFromDate:[[NSDate alloc] init]]];
    [self buildHeader];
}

- (void) buildHeader {
    
    _nameLabel.text = _account.name;
    _categoryLabel.text = @"#Category";
    _sumLabel.text = [NSString stringWithFormat:@"%.2f %@", _account.balance, _account.currency.shortName];
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self navigationController].topViewController.title = @"Expenses/Income";
    [self navigationController].topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAccount)];
   
    [[DSDataManager sharedManager] getAccount:_account.ident onSuccess:^(DSAccount *account) {
        _account = account;
        [self buildHeader];
    } onFailure:^(NSError *error) {
         NSLog(@"Error");
    }];
    [self loadData];
    
}

- (void) addAccount{
   /* _selectedOrder = nil;
    [[NSUserDefaults standardUserDefaults] setObject: _selectedSegment? @"Income":  @"Expenses"  forKey:@"sumName"];
    [[NSUserDefaults standardUserDefaults] setObject: _account.name == nil ? @"" : _account.name forKey:@"account"];

    [self performSegueWithIdentifier:@"showOrder" sender:self];
    */
}

- (void) loadData {
    [[DSDataManager sharedManager] getOrdersForAcc:_account.ident withFilter:@"EXPENSE" OnSuccess:^(NSArray *orders) {
        _expenseOrders = [orders mutableCopy];
        [_tableView reloadData];
    } onFailure:^(NSError *error) {
        NSLog(@"Error");

    }];
    [[DSDataManager sharedManager] getOrdersForAcc:_account.ident withFilter:@"INCOME" OnSuccess:^(NSArray *orders) {
        _incomeOrders = [orders mutableCopy];
    } onFailure:^(NSError *error) {
        NSLog(@"Error");
        
    }];

}

- (IBAction)changeSegment:(id)sender{
    _selectedSegment = _segmentControl.selectedSegmentIndex;
    [_tableView reloadData];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _selectedSegment == 0 ? [_expenseOrders count] : [_incomeOrders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* ident = @"orderCell";
    
    DSOrder* order = _selectedSegment == 0 ? [_expenseOrders objectAtIndex:indexPath.row] : [_incomeOrders objectAtIndex:indexPath.row];
    
    DSOrderTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:ident];
    
    if(!cell){
        cell = [[DSOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    cell.nameLabel.text = order.category.name;
    cell.iconImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_categories%d",(int)(indexPath.row % 4 )+1]];
    cell.sumLabel.text = [NSString stringWithFormat:@"%.2f %@", order.sum, order.account.currency.shortName];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = colorBlue;
    [cell setSelectedBackgroundView:bgColorView];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}
/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedOrder = _selectedSegment == 0 ? [_expenseOrders objectAtIndex:indexPath.row] : [_incomeOrders objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject: _selectedSegment? @"Income":  @"Expenses"  forKey:@"sumName"];
    [[NSUserDefaults standardUserDefaults] setObject: _account.name == nil ? @"" : _account.name forKey:@"account"];
    [self performSegueWithIdentifier:@"showOrder" sender:self];
}*/

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showOrder"]) {
        DSOrderViewController *orderViewController = segue.destinationViewController;
        orderViewController.order = _selectedOrder;
        orderViewController.isIncome = _selectedSegment;
        orderViewController.account = _account;
        [orderViewController viewDidLoad];
    }
}




@end
