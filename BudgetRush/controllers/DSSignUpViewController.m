//
//  DSSignUpViewController.m
//  BudgetRush
//
//  Created by Lena on 24.11.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSSignUpViewController.h"
#import "DSDataManager.h"


@interface DSSignUpViewController ()  <UIAlertViewDelegate>

@end

@implementation DSSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    self.navigationItem.title = @"Sign Up";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction) signUpTouch:(id)sender {
    self.view.userInteractionEnabled = NO;
    [[DSDataManager sharedManager] signUpUserEmail:self.fieldEmail.text password:self.fieldPassword.text OnSuccess:^(DSUser *user) {
        [self performSegueWithIdentifier:@"showTabBar" sender:self];
    } onFailure:^(NSError *error) {
         self.view.userInteractionEnabled = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"The email has been used"
                                                        message:@"Try again or register using another email"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    self.fieldPassword.text = @"";
    self.fieldEmail.text = @"";

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
