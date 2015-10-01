//
//  DSAccessToken.m
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSAccessToken.h"

@implementation DSAccessToken

- (id) initWithServerResponse:(NSDictionary*) responseObject
{
    self = [super init];
    if (self) {
        
        self.token = [responseObject objectForKey:@"access_token"];
        NSTimeInterval interval = [[responseObject objectForKey:@"expires_in"]doubleValue];
        self.expirationDate = [NSDate dateWithTimeIntervalSinceNow:interval];
    }
    return self;
}

@end
