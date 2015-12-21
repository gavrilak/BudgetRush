//
//  DSOrder.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSBaseModel.h"
@class  DSCategory;
@class  DSAccount;
@class  DSCurrency;
@class  DSContractor;

enum orderType : NSUInteger {
    typeOrder ,typeTransfer
};

@interface DSOrder : DSBaseModel

@property (assign,nonatomic) double sum;
@property (assign,nonatomic) enum orderType type;
@property (strong,nonatomic) NSDate *date;
@property (strong,nonatomic) DSAccount  *account;
@property (strong,nonatomic) DSCategory *category;
@property (strong,nonatomic) DSContractor *contractor;
@property (strong,nonatomic) NSString *descr;


- (instancetype)initWithDictionary:(NSDictionary *) responseObject;

@end
