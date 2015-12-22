//
//  DSAccount.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSBaseModel.h"
@class  DSCurrency;

@interface DSAccount : DSBaseModel

@property (strong,nonatomic) NSString *name;
@property (assign,nonatomic) NSInteger userIdent;
@property (assign,nonatomic) NSInteger groupIdent;
@property (strong,nonatomic) DSCurrency *currency;
@property (assign,nonatomic) double balance;
@property (assign,nonatomic) double initBalance;
@property (assign,nonatomic) double income;
@property (assign,nonatomic) double expense;


- (instancetype)initWithDictionary:(NSDictionary *) responseObject;

@end

