//
//  DSCurrency.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSObjectBudget.h"

@interface DSCurrency : DSObjectBudget

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *shortName;
@property (assign,nonatomic) NSInteger code;
@property (strong,nonatomic) NSString *symbol;

- (instancetype)initWithDictionary:(NSDictionary *) responseObject;

@end
