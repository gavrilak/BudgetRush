//
//  DSOrderTableViewCell.h
//  BudgetRush
//
//  Created by Dima Soldatenko on 12/19/15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MGSwipeTableCell.h>

@interface DSOrderTableViewCell : MGSwipeTableCell

@property (weak, nonatomic) IBOutlet UILabel *sumLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end
