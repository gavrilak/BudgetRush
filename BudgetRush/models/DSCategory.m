//
//  DSCategory.m
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSCategory.h"

@implementation DSCategory

- (instancetype)initWithDictionary:(NSDictionary *) responseObject {
    
    self = [super init];
    if (self) {
        self.cat_id = [[responseObject objectForKey:@"id"]integerValue] ;
        self.name = [[responseObject objectForKey:@"name"]stringValue];
        self.parent = [[responseObject objectForKey:@"parent"]integerValue];

    }
    return self;
}

@end
