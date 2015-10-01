//
//  DSOrder.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

enum orderType : NSUInteger {
    order ,transfer_order
};

@interface DSOrder : NSObject

@property (assign,nonatomic) NSInteger ord_id;
@property (assign,nonatomic) NSDecimal amount;
@property (assign,nonatomic) enum orderType type;
@property (strong,nonatomic) NSDate *date;
@property (assign,nonatomic) NSInteger ac_id;
@property (assign,nonatomic) NSInteger cat_id;
@property (assign,nonatomic) NSInteger con_id;
@property (assign,nonatomic) NSInteger exp_id;
@property (assign,nonatomic) NSInteger inc_id;

- (instancetype)initWithDictionary:(NSDictionary *) responseObject;

@end
