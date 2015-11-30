//
//  DSAccount.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSBaseModel.h"

@interface DSAccount : DSBaseModel

@property (strong,nonatomic) NSString *name;
@property (assign,nonatomic) NSInteger userIdent;
@property (assign,nonatomic) NSInteger currencyIdent;
@property (assign,nonatomic) NSInteger balance;
@property (assign,nonatomic) NSInteger income;
@property (assign,nonatomic) NSInteger expense;


- (instancetype)initWithDictionary:(NSDictionary *) responseObject;

@end

