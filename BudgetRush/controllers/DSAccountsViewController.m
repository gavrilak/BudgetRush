//
//  DSAccountsViewController.m
//  BudgetRush
//
//  Created by Lena on 24.11.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSAccountsViewController.h"
#import "DSAccountViewController.h"
#import "DSOrdersViewController.h"
#import "DSDataManager.h"
#import "DSAccount.h"
#import "DSCurrency.h"
#import "MGSwipeButton.h"
#import "MGSwipeTableCell.h"
#import "Settings.h"
#import "DSAccountTableViewCell.h"

@interface DSAccountsViewController () <UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate> {

    __weak IBOutlet UIView  *_infoView;
    __weak IBOutlet UILabel *_todayLabel;
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UISegmentedControl * _segmentControl;
    __weak IBOutlet UIView  *_segmentView;

    DSAccount *_selectedAccount;
    NSMutableArray* _accounts ;
    NSInteger _selectedSegment;
}

@end

@implementation DSAccountsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    [self navigationController].topViewController.navigationItem.hidesBackButton = YES;
    _tableView.separatorColor = colorBackgroundBlue;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd MMM"];
    _todayLabel.text = [NSString stringWithFormat:@"Today %@", [format stringFromDate:[[NSDate alloc] init]]];
    CGRect headerFrame = _tableView.tableHeaderView.frame;
    headerFrame.size.height = 80;
    _tableView.tableHeaderView.frame = headerFrame;
    _tableView.alpha = 0;
    _segmentView.alpha = 0;
    _infoView.alpha = 0;

    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self navigationController].topViewController.title = @"My Accounts";
    [self navigationController].topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAccount)];
    [_segmentControl setSelectedSegmentIndex:0];
    _selectedSegment = 0;
    [self loadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) addAccount{
    _selectedAccount = nil;
    [self performSegueWithIdentifier:@"showAccount" sender:self];
    
}

- (void) loadData {
    [[DSDataManager sharedManager] getAccountsOnSuccess:^(NSArray *accounts) {
        _accounts = [accounts mutableCopy];
        if ([accounts count] == 0) {
            [UIView animateWithDuration:1.0 animations:^(void) {
                _tableView.alpha = 0;
                _segmentView.alpha = 0;
                _infoView.alpha = 1;
            }];
        } else {
            [UIView animateWithDuration:1.0 animations:^(void) {
                _tableView.alpha = 1;
                _segmentView.alpha = 1;
                _infoView.alpha = 0;
            }];
            [_tableView reloadData];
        }
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
    return [_accounts count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* ident = @"accountCell";
    
    DSAccount* account = [_accounts objectAtIndex:indexPath.row];
    
    DSAccountTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:ident];
    
    if(!cell){
        cell = [[DSAccountTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    cell.nameLabel.text = account.name;
    cell.iconImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_categories%d",(int)(indexPath.row % 4 )+1]];
    cell.categoryLabel.text = @"#Category";
    switch (_selectedSegment) {
        case 0:
            cell.sumLabel.text = [NSString stringWithFormat:@"%.2f %@", account.balance, account.currency.shortName];
            break;
        case 1:
            cell.sumLabel.text = [NSString stringWithFormat:@"%.2f %@", -account.expense, account.currency.shortName];
            break;
        case 2:
            cell.sumLabel.text = [NSString stringWithFormat:@"%.2f %@", account.income, account.currency.shortName];
            break;
    }
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
        [[DSDataManager sharedManager] deleteAccount:[_accounts objectAtIndex:path.row] onSuccess:nil onFailure:nil];
        [_accounts removeObjectAtIndex:path.row];
        [_tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
        return NO; //Don't autohide to improve delete expansion animation
    } else {
         NSIndexPath * path = [_tableView indexPathForCell:cell];
        _selectedAccount = [_accounts objectAtIndex:path.row];
        [self performSegueWithIdentifier:@"showAccount" sender:self];
        return YES;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedAccount = [_accounts objectAtIndex:indexPath.row];
     [self performSegueWithIdentifier:@"showOrders" sender:self];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showAccount"]) {
        DSAccountViewController *accountViewController = segue.destinationViewController;
        accountViewController.account = _selectedAccount;
        [accountViewController viewDidLoad];
    } if ([segue.identifier isEqualToString:@"showOrders"]) {
        DSOrdersViewController *ordersViewController = segue.destinationViewController;
        ordersViewController.account = _selectedAccount;
    }
}


@end
