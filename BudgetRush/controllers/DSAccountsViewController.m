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
#import "MGSwipeButton.h"
#import "MGSwipeTableCell.h"
#import "Settings.h"

@interface DSAccountsViewController () <UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate> {

    __weak IBOutlet UIView  *infoView;
    __weak IBOutlet UILabel *_todayLabel;
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UISegmentedControl * _segmentControl;

    NSMutableArray* _accounts ;
    NSInteger _selectedSegment;
}

@end

@implementation DSAccountsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    [self navigationController].topViewController.navigationItem.hidesBackButton = YES;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd MMMM"];
    _todayLabel.text = [NSString stringWithFormat:@"Today %@", [format stringFromDate:[[NSDate alloc] init]]];
    CGRect headerFrame = _tableView.tableHeaderView.frame;
    headerFrame.size.height = 80;
    _tableView.tableHeaderView.frame = headerFrame;
  
  
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self navigationController].topViewController.title = @"My Accounts";
    [self navigationController].topViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAccount)];
     [self loadData];

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
        if ([accounts count] == 0) {
            [UIView animateWithDuration:1.0 animations:^(void) {
                _tableView.alpha = 0;
            }];
        } else {
            _tableView.alpha = 1;
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
    
    MGSwipeTableCell *cell = [_tableView dequeueReusableCellWithIdentifier:ident];
    
    if(!cell){
        cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    cell.textLabel.text = account.name;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"ic_categories%ld",(indexPath.row % 4 )+1]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (_selectedSegment) {
        case 0:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", account.balance];
            break;
        case 1:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", account.expense];
            break;
        case 2:
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", account.income];
            break;
    }
    
    
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
    }
    
    return YES;

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
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
