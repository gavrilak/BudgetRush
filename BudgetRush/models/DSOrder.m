//
//  DSOrder.m
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSOrder.h"

@implementation DSOrder

- (instancetype)initWithDictionary:(NSDictionary *) responseObject {
    
    self = [super initWithDictionary:responseObject];
    if (self) {
        self.amount = [[responseObject objectForKey:@"amount"]decimalValue];
        self.date= [NSDate dateWithTimeIntervalSince1970:[[responseObject objectForKey:@"date"] integerValue ]];
        if ([[responseObject objectForKey:@"type"] isEqualToString:@"ORDER"]) {
            self.type = typeOrder;
        } else {
            self.type = typeTransfer;
        }
        self.acc_id = [[[responseObject objectForKey:@"account"] objectForKey:@"id"]integerValue];
        self.cur_id = [[[[responseObject objectForKey:@"account"] objectForKey:@"currency"] objectForKey:@"id"]integerValue];
        self.con_id = [[[responseObject objectForKey:@"contractor"] objectForKey:@"id"]integerValue];
        self.cat_id = [[[responseObject objectForKey:@"category"] objectForKey:@"id"]integerValue];
        
    }
    return self;
}

@end
