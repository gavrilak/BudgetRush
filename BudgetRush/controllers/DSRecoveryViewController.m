//
//  DSRecoveryViewController.m
//  BudgetRush
//
//  Created by Lena on 24.11.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSRecoveryViewController.h"
#import "DSDataManager.h"

@interface DSRecoveryViewController ()

@end

@implementation DSRecoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    self.navigationItem.title = @"Password Recovery";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (IBAction)recoveryTouch:(id)sender {
    
    [self.view setUserInteractionEnabled :NO];
    [[DSDataManager sharedManager] recoveryPassForEmail:self.fieldEmail.text OnSuccess:^(id object) {
        [self.navigationController popViewControllerAnimated:YES];
    } onFailure:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Invalid email"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
  /* [[DSDataManager sharedManager]  recoveryPassForEmail:self.fieldEmail.text  onSuccess:^(id object) {
        [self na
    } onFailure:^(NSError *error) {
   
    }];*/
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
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
