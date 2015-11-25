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
#import "DSUser.h"
#import "DSCurrency.h"
#import "DSApiManager.h"

@implementation DSDataManager


+ (DSDataManager *)sharedManager {
    
    static DSDataManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DSDataManager alloc]init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
  
    }
    
    return self;
}



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

- (void) signUpUserEmail:(NSString*) email password:(NSString*) password OnSuccess:(void(^)(id object)) success
               onFailure:(void(^)(NSError* error)) failure {


    NSDictionary* params = @{@"name"     : email ,
                             @"role"     : @"ROLE_USER",
                             @"password" : password};
    
    [[DSApiManager sharedManager] postUser:params onSuccess:^(NSDictionary *response) {
        NSLog(@"JSON: %@", response);
        
        if ([response isKindOfClass:[NSDictionary class]]) {
            _currentUser = [[DSUser alloc] initWithDictionary:response];
        }
        
        if (success) {
            success(@"");
        }

    } onFailure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}


- (void) loginUserEmail:(NSString*) email password:(NSString*) password OnSuccess:(void(^)(id object)) success
               onFailure:(void(^)(NSError* error)) failure {
    
    
   [[DSApiManager sharedManager] getTokenForUser:email andPassword:password onSuccess:^(DSAccessToken *token) {
       if (success) {
           success(@"");
       }
   } onFailure:^(NSError *error) {
       if (failure) {
           failure(error);
       }
   }];
        
    
}



- (void) recoveryUserEmail:(NSString*) email OnSuccess:(void(^)(id object)) success
                 onFailure:(void(^)(NSError* error)) failure {
    
}


@end
