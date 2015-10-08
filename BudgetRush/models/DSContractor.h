//
//  DSContractor.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSObjectBudget.h"

@interface DSContractor : DSObjectBudget

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *descr;
@property (assign,nonatomic) NSInteger user_id;

- (instancetype)initWithDictionary:(NSDictionary *) responseObject;

@end
