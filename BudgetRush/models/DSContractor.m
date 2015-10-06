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
    
    self = [super init];
    if (self) {
        self.con_id = [[responseObject objectForKey:@"id"]integerValue] ;
        self.name = [responseObject objectForKey:@"name"];
        self.descr = [responseObject objectForKey:@"description"];
        
    }
    return self;
}

@end
