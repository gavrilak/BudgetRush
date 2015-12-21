//
//  DSOrder.m
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSOrder.h"
#import "DSAccount.h"
#import "DSCategory.h"
#import "DSCurrency.h"
#import "DSContractor.h"

@implementation DSOrder

- (instancetype)initWithDictionary:(NSDictionary *) responseObject {
    
    self = [super initWithDictionary:responseObject];
    if (self) {
        self.sum = [[responseObject objectForKey:@"amount"]doubleValue];
        self.date= [NSDate dateWithTimeIntervalSince1970:[[responseObject objectForKey:@"date"] integerValue ]];
        if ([[responseObject objectForKey:@"type"] isEqualToString:@"ORDER"]) {
            self.type = typeOrder;
        } else {
            self.type = typeTransfer;
        }
        self.account = [[DSAccount alloc] initWithDictionary:[responseObject objectForKey:@"account"]];
        self.category = [[DSCategory alloc] initWithDictionary:[responseObject objectForKey:@"category"] ];
        self.contractor = [[DSContractor alloc] initWithDictionary:[responseObject objectForKey:@"contractor"]];
        
    }
    return self;
}

@end