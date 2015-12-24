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
#import "MGSwipeButton.h"
#import "MGSwipeTableCell.h"

@interface DSOrdersViewController () <UITableViewDataSource, UITableViewDelegate,MGSwipeTableCellDelegate> {
    
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
    _selectedOrder = nil;
    [[NSUserDefaults standardUserDefaults] setObject: _selectedSegment? @"Income":  @"Expenses"  forKey:@"sumName"];
    [[NSUserDefaults standardUserDefaults] setObject: _account.name == nil ? @"" : _account.name forKey:@"account"];

    [self performSegueWithIdentifier:@"showOrder" sender:self];
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
         [_tableView reloadData];
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
    cell.sumLabel.text = [NSString stringWithFormat:@"%.2f %@",_selectedSegment == 0 ?  -order.sum : order.sum, order.account.currency.shortName];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = colorBlue;
    [cell setSelectedBackgroundView:bgColorView];
    cell.rightSwipeSettings.transition =  MGSwipeTransitionStatic;
    cell.rightExpansion.buttonIndex = 0;
    cell.rightExpansion.fillOnTrigger = YES;
    cell.rightButtons = [self createRightButtons:2];
    cell.delegate = self;
    return cell;
}


-(NSArray *) createRightButtons: (int) number
{
    NSMutableArray * result = [NSMutableArray array];
    NSString* titles[2] = {@"Delete", @"Edit"};
    NSString* imageNames[2] = {@"ic_delete", @"ic_edit"};
    UIColor * colors[2] = {colorBlue, colorRed};
    for (int i = 0; i < number; ++i)
    {
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:titles[i] icon:[UIImage imageNamed:imageNames[i]] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * sender){
            BOOL autoHide = i != 0;
            return autoHide;
        }];
        [button setButtonWidth:100];
        [result addObject:button];
    }
    return result;
}


-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion
{
    NSLog(@"Delegate: button tapped, %@ position, index %d, from Expansion: %@",
          direction == MGSwipeDirectionLeftToRight ? @"left" : @"right", (int)index, fromExpansion ? @"YES" : @"NO");
    
    if (direction == MGSwipeDirectionRightToLeft && index == 0) {
        //delete button
        NSIndexPath * path = [_tableView indexPathForCell:cell];
         DSOrder* order = _selectedSegment == 0 ? [_expenseOrders objectAtIndex:path.row] : [_incomeOrders objectAtIndex:path.row];
        
        [[DSDataManager sharedManager] deleteOrder:order onSuccess:^(id object) {
            [[DSDataManager sharedManager] getAccount:_account.ident onSuccess:^(DSAccount *account) {
                _account = account;
                [self buildHeader];
            } onFailure:^(NSError *error) {
                NSLog(@"Error");
            }];
        } onFailure:nil];
        _selectedSegment == 0 ?  [_expenseOrders removeObjectAtIndex:path.row] : [_incomeOrders removeObjectAtIndex:path.row] ;
        [_tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
        return NO; //Don't autohide to improve delete expansion animation
    } else {
        NSIndexPath * path = [_tableView indexPathForCell:cell];
        _selectedOrder = _selectedSegment == 0 ? [_expenseOrders objectAtIndex:path.row] : [_incomeOrders objectAtIndex:path.row];
        [[NSUserDefaults standardUserDefaults] setObject: @(_selectedOrder.category.ident) forKey:@"categoryID"];
        [[NSUserDefaults standardUserDefaults] setObject: _selectedSegment? @"Income":  @"Expenses"  forKey:@"sumName"];
        [[NSUserDefaults standardUserDefaults] setObject: _account.name == nil ? @"" : _account.name forKey:@"account"];
        [self performSegueWithIdentifier:@"showOrder" sender:self];
        return YES;
    }
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedOrder = _selectedSegment == 0 ? [_expenseOrders objectAtIndex:indexPath.row] : [_incomeOrders objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject: @(_selectedOrder.category.ident) forKey:@"categoryID"];
    [[NSUserDefaults standardUserDefaults] setObject: _selectedSegment? @"Income":  @"Expenses"  forKey:@"sumName"];
    [[NSUserDefaults standardUserDefaults] setObject: _account.name == nil ? @"" : _account.name forKey:@"account"];
    [self performSegueWithIdentifier:@"showOrder" sender:self];
}

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
