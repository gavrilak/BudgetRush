//
//  DSTOSViewController.h
//  BudgetRush
//
//  Created by Lena on 24.11.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSTOSViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UITextView *textViewTOS;
@property (nonatomic, assign) BOOL showTOS;

@end
