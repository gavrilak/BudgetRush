//
//  DSObjectBudget.h
//  BudgetRush
//
//  Created by Dima Soladtenko on 08.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSObjectBudget : NSObject

@property (assign,nonatomic) NSInteger obj_id;

- (instancetype)initWithDictionary:(NSDictionary *) responseObject;

@end
