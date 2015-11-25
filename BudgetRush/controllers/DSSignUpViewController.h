//
//  DSSignUpViewController.h
//  BudgetRush
//
//  Created by Lena on 24.11.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSSignUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *fieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *fieldPassword;

- (IBAction) signUpTouch:(id)sender;


@end
