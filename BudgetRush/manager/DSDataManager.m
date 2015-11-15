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
#import "DSApiManager.h"

@implementation DSDataManager





- (void) getAccount:(NSInteger) acID onSuccess:(void(^)(DSAccount* account)) success
          onFailure:(void(^)(NSError* error)) failure {

     [[DSApiManager sharedManager] getAccount:acID onSuccess:^(NSDictionary *response) {
         DSAccount* account;
         if ([response isKindOfClass:[NSDictionary class]]) {
             account = [[DSAccount alloc] initWithDictionary:response];
         }
         if (success) {
             success(account);
         }
     } onFailure:^(NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
    
}


- (void) getAccountsOnSuccess:(void(^)(NSArray* accounts)) success
                    onFailure:(void(^)(NSError* error)) failure
{
    
    [[DSApiManager sharedManager] getAccountsOnSuccess:^(NSDictionary *response) {
        
        NSMutableArray *accounts = [NSMutableArray new];
        for (NSDictionary* dict in response ) {
            DSAccount* acc = [[DSAccount alloc] initWithDictionary:dict];
            [accounts addObject:acc];
        }
        if (success)
            success(accounts);
        
    } onFailure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
