//
//  DSAccount.m
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSAccount.h"

@implementation DSAccount

- (instancetype)initWithDictionary:(NSDictionary *) responseObject {
    
    self = [super init];
    if (self) {
        self.ac_id = [[responseObject objectForKey:@"id"]integerValue] ;
        self.name = [responseObject objectForKey:@"name"];
        self.user_id = [[[responseObject objectForKey:@"user"] objectForKey:@"id"]integerValue];
        self.currency_id = [[[responseObject objectForKey:@"currency"] objectForKey:@"id"] integerValue];
    }
    return self;
}

@end
