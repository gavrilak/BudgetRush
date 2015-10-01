//
//  DSCurrency.m
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSCurrency.h"

@implementation DSCurrency

- (instancetype)initWithDictionary:(NSDictionary *) responseObject {
    
    self = [super init];
    if (self) {
        self.cur_id = [[responseObject objectForKey:@"id"]integerValue] ;
        self.name = [[responseObject objectForKey:@"name"]stringValue];
        self.shortName = [[responseObject objectForKey:@"shortName"]stringValue];
        self.code = [[responseObject objectForKey:@"code"]integerValue];
        self.symbol = [[responseObject objectForKey:@"symbol"]charValue];
        
    }
    return self;
}

@end
