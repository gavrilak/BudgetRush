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
    
    self = [super initWithDictionary:responseObject];
    if (self) {
        self.name = [responseObject objectForKey:@"name"];
        self.userIdent = [[[responseObject objectForKey:@"user"] objectForKey:@"id"]integerValue];
        self.currencyIdent = [[[responseObject objectForKey:@"currency"] objectForKey:@"id"] integerValue];
        self.balance = [[responseObject objectForKey:@"balance"] integerValue];
        
        
    }
    return self;
}

@end
