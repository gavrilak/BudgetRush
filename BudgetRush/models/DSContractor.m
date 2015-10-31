//
//  DSContractor.m
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSContractor.h"

@implementation DSContractor

- (instancetype)initWithDictionary:(NSDictionary *) responseObject {
    
    self = [super initWithDictionary:responseObject];
    if (self) {
        self.name = [responseObject objectForKey:@"name"];
        self.descr = [responseObject objectForKey:@"description"];
        self.userIdent = [[[responseObject objectForKey:@"user"]objectForKey:@"id"]integerValue] ;
    }
    return self;
}

@end
