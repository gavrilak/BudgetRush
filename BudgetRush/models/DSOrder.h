//
//  DSOrder.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSBaseModel.h"

enum orderType : NSUInteger {
    typeOrder ,typeTransfer
};

@interface DSOrder : DSBaseModel

@property (assign,nonatomic) NSDecimal amount;
@property (assign,nonatomic) enum orderType type;
@property (strong,nonatomic) NSDate *date;
@property (assign,nonatomic) NSInteger accountIdent;
@property (assign,nonatomic) NSInteger currencyIdent;
@property (assign,nonatomic) NSInteger categoryIdent;
@property (assign,nonatomic) NSInteger contractorIdent;


- (instancetype)initWithDictionary:(NSDictionary *) responseObject;

@end
