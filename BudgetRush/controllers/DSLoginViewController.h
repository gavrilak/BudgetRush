//
//  DSLoginViewController.h
//  BudgetRush
//
//  Created by Lena on 24.11.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSLoginViewController : UIViewController

#warning TODO: Это нарушение инкапсуляции. Данные объекты не должны быть публичнми.
@property (weak, nonatomic) IBOutlet UITextField *fieldEmail; 
@property (weak, nonatomic) IBOutlet UITextField *fieldPassword;

#warning TODO: Нет никакой необходимости такие методы выностить в публичный интерфейс
//- (IBAction)loginTouch:(id)sender;

@end
