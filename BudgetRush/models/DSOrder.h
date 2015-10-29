//
//  DSOrder.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSObjectBudget.h"

enum orderType : NSUInteger {
    typeOrder ,typeTransfer
};

@interface DSOrder : DSObjectBudget

@property (assign,nonatomic) NSDecimal amount;
@property (assign,nonatomic) enum orderType type;
@property (strong,nonatomic) NSDate *date;
#warning TODO: Сложно разобрать за что отвечает каждое из этих свойств. Не нужно так сильно сокращать.
@property (assign,nonatomic) NSInteger acc_id;
@property (assign,nonatomic) NSInteger cur_id;
@property (assign,nonatomic) NSInteger cat_id;
@property (assign,nonatomic) NSInteger con_id;
@property (assign,nonatomic) NSInteger exp_id;
@property (assign,nonatomic) NSInteger inc_id;

- (instancetype)initWithDictionary:(NSDictionary *) responseObject;

@end
