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
        self.usr_id = [[[responseObject objectForKey:@"user"]objectForKey:@"id"]integerValue] ;
        self.name = [responseObject objectForKey:@"name"];
        if ([responseObject objectForKey:@"parent"] != [NSNull null]) {
            self.parent = [[[responseObject objectForKey:@"parent"] objectForKey:@"id"]integerValue];
        }

    }
    return self;
}

@end
