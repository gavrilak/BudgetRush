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
    
    self = [super initWithDictionary:responseObject];
    if (self) {
        self.name = [responseObject objectForKey:@"name"];
        self.shortName = [responseObject objectForKey:@"shortName"];
        self.code = [[responseObject objectForKey:@"code"]integerValue];
        self.symbol = [responseObject objectForKey:@"symbol"] ;
        
    }
    return self;
}

@end
