//
//  DSObjectBudget.m
//  BudgetRush
//
//  Created by Dima Soladtenko on 08.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSObjectBudget.h"

@implementation DSObjectBudget

- (instancetype)initWithDictionary:(NSDictionary *) responseObject {
    
    self = [super init];
    if (self) {
         self.obj_id = [[responseObject objectForKey:@"id"]integerValue] ;
    }
    return self;
    
}
@end
