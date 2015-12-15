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
    
    self = [super initWithDictionary:responseObject];
    if (self) {
        self.name = [responseObject objectForKey:@"name"];
       /* self.userIdent = [[[responseObject objectForKey:@"user"]objectForKey:@"id"]integerValue] ;
        if ([responseObject objectForKey:@"parent"] != [NSNull null]) {
            self.parentIdent = [[[responseObject objectForKey:@"parent"] objectForKey:@"id"]integerValue];
        }*/

    }
    return self;
}

@end
