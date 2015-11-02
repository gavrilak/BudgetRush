//
//  DSDataManager.m
//  BudgetRush
//
//  Created by Dima on 31.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSDataManager.h"
#import "DSAccount.h"
#import "DSCategory.h"
#import "DSContractor.h"
#import "DSOrder.h"
#import "DSCurrency.h"
#import "DSServerManager.h"

@implementation DSDataManager


+ (NSMutableArray*) getAccountsFromDict: (NSDictionary*) dictionary {
    NSMutableArray* objectsArray = [NSMutableArray array];
    
    for (NSDictionary* dict in dictionary ) {
        DSAccount* acc = [[DSAccount alloc] initWithDictionary:dict];
        [objectsArray addObject:acc];
    }
    return objectsArray;
}


+ (DSAccount*) getAccountFromDict: (NSDictionary*) dictionary{
    DSAccount* account;
    
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        account = [[DSAccount alloc] initWithDictionary:dictionary];
    }
    
    return account;
}





- (void) getAccountsOnSuccess:(void(^)(NSArray* accounts)) success
                    onFailure:(void(^)(NSError* error)) failure
{
    
    [[DSServerManager sharedManager] getAccountsOnSuccess:^(NSDictionary *response) {
        
        NSArray *accounts = nil; //Parse dict to NSObjects
        
        if (success)
            success(accounts);
        
    } onFailure:^(NSError *error) {
        //
    }];
    
}

@end
