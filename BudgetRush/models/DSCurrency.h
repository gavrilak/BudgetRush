//
//  DSCurrency.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSCurrency : NSObject

@property (assign,nonatomic) NSInteger cur_id;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *shortName;
@property (assign,nonatomic) NSInteger code;
@property (assign,nonatomic) char symbol;

- (instancetype)initWithDictionary:(NSDictionary *) responseObject;

@end
