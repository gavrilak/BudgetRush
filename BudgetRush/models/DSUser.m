//
//  DSUser.m
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSUser.h"

@implementation DSUser

- (instancetype)initWithDictionary:(NSDictionary *) responseObject {
    
    self = [super initWithDictionary:responseObject];
    if (self) {
        self.name = [responseObject objectForKey:@"name"];
        self.password = [responseObject objectForKey:@"password"];
        
    }
    return self;
}


@end
