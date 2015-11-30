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

@interface DSLoginViewController ()

@end

@implementation DSLoginViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
     [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showTOS"]) {
        DSTOSViewController*  controller = [segue destinationViewController];
        controller.showTOS = YES;
    }
}


- (IBAction)loginTouch:(id)sender {
    
    [self.view setUserInteractionEnabled :NO];
    [[DSDataManager sharedManager] loginUserEmail:self.fieldEmail.text password:self.fieldPassword.text OnSuccess:^(id object) {
        
        [[NSUserDefaults standardUserDefaults] setObject:self.fieldEmail.text forKey:kUserName];
        [[NSUserDefaults standardUserDefaults] setObject:self.fieldEmail.text forKey:kUserPass];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self performSegueWithIdentifier:@"showTabBar" sender:self];
    } onFailure:^(NSError *error) {
        self.view.userInteractionEnabled = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Invalid email or password"
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

@end
