//
//  DSCategory.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSObjectBudget.h"

@interface DSCategory : DSObjectBudget

@property (strong,nonatomic) NSString *name;
@property (assign,nonatomic) NSInteger parent;
@property (assign,nonatomic) NSInteger usr_id;

- (instancetype)initWithDictionary:(NSDictionary *) responseObject;


@end
