//
//  DSTOSViewController.m
//  BudgetRush
//
//  Created by Lena on 24.11.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSTOSViewController.h"
#import "DSDataManager.h"

@interface DSTOSViewController () {

   __weak IBOutlet UILabel *_titleLabel;
   __weak IBOutlet UITextView *_tosTextView;

}

@end



@implementation DSTOSViewController

- (void)viewDidLoad {
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    [super viewDidLoad];
    if (self.showTOS) {
        self.navigationItem.title = NSLocalizedString(@"Terms of Service",nil);
        _titleLabel.text = NSLocalizedString(@"The Big Wallet Terms of Service and Cookies Use", nil);
        _tosTextView.text = [[DSDataManager sharedManager] getTOS];
        
    } else {
        self.navigationItem.title = NSLocalizedString(@"Privacy Policy",nil);
        _titleLabel.text = NSLocalizedString(@"The Big Wallet Privacy Policy", nil);
        _tosTextView.text = [[DSDataManager sharedManager] getPP];
    }
}


@end
