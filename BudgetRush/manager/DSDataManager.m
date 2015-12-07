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

- (NSString*) getTOS {
    NSString *filePath = [[NSBundle mainBundle] pathForResource: NSLocalizedString(@"TOS&PP",nil) ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error;
    if (data != nil) {
        NSMutableArray* tos = [NSMutableArray arrayWithArray:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error]];
        return [[tos objectAtIndex:0] objectForKey:@"TOS"];
    } else {
        return @"";
    }
    
}

- (NSString*) getPP {
    NSString *filePath = [[NSBundle mainBundle] pathForResource: NSLocalizedString(@"TOS&PP",nil)  ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error;
    if (data != nil) {
        NSMutableArray* tos = [NSMutableArray arrayWithArray:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error]];
        return [[tos objectAtIndex:0] objectForKey:@"PP"];
    } else {
        return @"";
    }

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


- (void) createAccount:(DSAccount*) account onSuccess:(void(^)(DSAccount* account)) success
          onFailure:(void(^)(NSError* error)) failure {
    
    NSDictionary* params = @{@"name"        : account.name,
                             @"group"        :@{@"id"  :[NSNumber numberWithInteger:1]},
                             @"currency"    :@{@"id" :[NSNumber numberWithInteger:account.currencyIdent]}};
    
    [[DSApiManager sharedManager] postAccount:params onSuccess:^(NSDictionary *response) {
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



- (void) getExpenseForAccID:(NSInteger) acID onSuccess:(void(^)(NSDictionary* result)) success
                  onFailure:(void(^)(NSError* error)) failure {
    
    
    [[DSApiManager sharedManager] getExpenseForAccID:acID onSuccess:^(NSDictionary *response) {
        if (success) {
            success(response);
        }
    } onFailure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

- (void) getIncomeForAccID:(NSInteger) acID onSuccess:(void(^)(NSDictionary* result)) success
                  onFailure:(void(^)(NSError* error)) failure {
    
    
    [[DSApiManager sharedManager] getIncomeForAccID:acID onSuccess:^(NSDictionary *response) {
        if (success) {
            success(response);
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
            [[DSApiManager sharedManager] getExpenseForAccID:acc.ident onSuccess:^(NSDictionary *response) {
                acc.expense = [[response objectForKey:@"amount"] integerValue];
            } onFailure:^(NSError *error) {
                NSLog(@"Error ");
            }];
            
            [[DSApiManager sharedManager] getIncomeForAccID:acc.ident onSuccess:^(NSDictionary *response) {
                acc.income = [[response objectForKey:@"amount"] integerValue];
            } onFailure:^(NSError *error) {
                NSLog(@"Error ");
            }];

            
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


    NSDictionary* params = @{@"name"     : email,
                             @"email"    : email,
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

- (void) recoveryPassForEmail:(NSString*) email OnSuccess:(void(^)(id object)) success
                 onFailure:(void(^)(NSError* error)) failure {
    
    [[DSApiManager sharedManager] recoveryPasswordForEmail:email onSuccess:^(id object) {
        if (success) {
            success(@"");
        }
    } onFailure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


@end
