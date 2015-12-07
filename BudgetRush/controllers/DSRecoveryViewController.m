//
//  DSRecoveryViewController.m
//  BudgetRush
//
//  Created by Lena on 24.11.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSRecoveryViewController.h"
#import "DSDataManager.h"

@interface DSRecoveryViewController () {
   __weak IBOutlet UITextField *_emailTextField;
}

@end

@implementation DSRecoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    self.navigationItem.title = NSLocalizedString(@"Password Recovery",nil);

}



- (IBAction)recoveryTouch:(id)sender {
    
    [self.view setUserInteractionEnabled :NO];
    [[DSDataManager sharedManager] recoveryPassForEmail:_emailTextField.text OnSuccess:^(id object) {
        [self.navigationController popViewControllerAnimated:YES];
    } onFailure:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",nil)
                                                        message:NSLocalizedString(@"Invalid email",nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
 
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    _emailTextField.text = @"";
    
}




@end
