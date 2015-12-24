//
//  DSLoginViewController.m
//  BudgetRush
//
//  Created by Lena on 24.11.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSLoginViewController.h"
#import "DSTOSViewController.h"
#import "DSDataManager.h"
#import "Settings.h"

@interface DSLoginViewController () <UITextFieldDelegate>
{
    __weak IBOutlet UITextField *_emailTextField;
    __weak IBOutlet UITextField *_passwordTextField;
    
    
}

- (IBAction)loginTouch:(id)sender;

@end

@implementation DSLoginViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    if ([_emailTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = colorGreyFont;
        _emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Email",nil) attributes:@{NSForegroundColorAttributeName: color}];
    }
    if ([_passwordTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = colorGreyFont;
        _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Password",nil) attributes:@{NSForegroundColorAttributeName: color}];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [_emailTextField setLeftViewMode:UITextFieldViewModeAlways];
    [_emailTextField setLeftView:spacerView];
    spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [_passwordTextField setLeftViewMode:UITextFieldViewModeAlways];
    [_passwordTextField setLeftView:spacerView];
}

-(void)dismissKeyboard {
    [_emailTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
     [[self navigationController] setNavigationBarHidden:YES animated:NO];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"showTOS"]) {
        DSTOSViewController*  controller = [segue destinationViewController];
        controller.showTOS = YES;
    }
}


- (IBAction)loginTouch:(id)sender {
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [[DSDataManager sharedManager] loginUserEmail: _emailTextField.text  password: _passwordTextField.text  OnSuccess:^(id object) {
        
        [[NSUserDefaults standardUserDefaults] setObject:_emailTextField.text forKey:kUserName];
        [[NSUserDefaults standardUserDefaults] setObject:_passwordTextField.text  forKey:kUserPass];
        [[NSUserDefaults standardUserDefaults] synchronize];
        _passwordTextField.text = @"";
        _emailTextField.text = @"";
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        [self performSegueWithIdentifier:@"showTabBar" sender:self];
    } onFailure:^(NSError *error) {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",nil)
                                                        message:NSLocalizedString(@"Invalid email or password",nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    _passwordTextField.text = @"";
    _emailTextField.text = @"";
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

@end
