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
    
    self = [super init];
    if (self) {
        self.ord_id = [[responseObject objectForKey:@"id"]integerValue] ;
        self.amount = [[responseObject objectForKey:@"amount"]decimalValue];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd-"];
        self.date= [dateFormat dateFromString:[responseObject objectForKey:@"date"]];
        if ([[[responseObject objectForKey:@"type"]stringValue] isEqualToString:@"ORDER"]) {
            self.type = order;
        } else {
            self.type = transfer_order;
        }
        self.ac_id = [[[responseObject objectForKey:@"account"] objectForKey:@"id"]integerValue];
        self.con_id = [[[responseObject objectForKey:@"contractor"] objectForKey:@"id"]integerValue];
        self.cat_id = [[[responseObject objectForKey:@"category"] objectForKey:@"id"]integerValue];
       
    }
    return self;
}

@end
