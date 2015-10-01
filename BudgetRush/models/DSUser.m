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
    
    self = [super init];
    if (self) {
        self.usr_id = [[responseObject objectForKey:@"id"]integerValue] ;
        self.name = [[responseObject objectForKey:@"name"]stringValue];
        self.password = [[responseObject objectForKey:@"password"] stringValue];
        
    }
    return self;
}


@end
