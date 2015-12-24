//
//  DSRecoveryViewController.m
//  BudgetRush
//
//  Created by Lena on 24.11.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//
#import "Settings.h"
#import "DSRecoveryViewController.h"
#import "DSDataManager.h"
#import "DSTOSViewController.h"

@interface DSRecoveryViewController () <UITextFieldDelegate>
{
   __weak IBOutlet UITextField *_emailTextField;
}

@end

@implementation DSRecoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    self.navigationItem.title = NSLocalizedString(@"Password Recovery",nil);
    if ([_emailTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = colorGreyFont;
        _emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Email",nil) attributes:@{NSForegroundColorAttributeName: color}];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [_emailTextField setLeftViewMode:UITextFieldViewModeAlways];
    [_emailTextField setLeftView:spacerView];
   
}

-(void)dismissKeyboard {
    [_emailTextField resignFirstResponder];
}




- (IBAction)recoveryTouch:(id)sender {
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [[DSDataManager sharedManager] recoveryPassForEmail:_emailTextField.text OnSuccess:^(id object) {
        [self.navigationController popViewControllerAnimated:YES];
         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    } onFailure:^(NSError *error) {
         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error",nil)
                                                        message:NSLocalizedString(@"Invalid email",nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"OK",nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
 
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showTOS"]) {
        DSTOSViewController*  controller = [segue destinationViewController];
        controller.showTOS = YES;
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    _emailTextField.text = @"";
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}


@end
