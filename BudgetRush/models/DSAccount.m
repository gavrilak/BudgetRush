//
//  DSAccount.m
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSAccount.h"
#import "DSCurrency.h"

@implementation DSAccount

- (instancetype)initWithDictionary:(NSDictionary *) responseObject {
    
    self = [super initWithDictionary:responseObject];
    if (self) {
        self.name = [responseObject objectForKey:@"name"];
        self.userIdent = [[[responseObject objectForKey:@"user"] objectForKey:@"id"]integerValue];
        self.currency =  [[DSCurrency  alloc] initWithDictionary:[responseObject objectForKey:@"currency"]];
        self.balance = [[responseObject objectForKey:@"balance"] doubleValue];
        self.initBalance = [[responseObject objectForKey:@"initBalance"] doubleValue];
        
    }
    return self;
}

@end
