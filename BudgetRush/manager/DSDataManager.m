//
//  DSDataManager.m
//  BudgetRush
//
//  Created by Dima on 31.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//
#import "Settings.h"
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

-(void) getCategoryAndCurrency {
   [self getCurrenciesOnSuccess:^(NSArray *currencies) {
        self.currencies = [currencies mutableCopy];
    } onFailure:^(NSError *error) {
        NSLog(@"Error");
    }];
    [self getCateroriesOnSuccess:^(NSArray *categories) {
        self.categories = [categories mutableCopy];
    } onFailure:^(NSError *error) {
        NSLog(@"Error");
    }];
    [[DSApiManager sharedManager] getGroupsOnSuccess:^(NSDictionary *response) {
        for (NSDictionary* dict in response ) {
            for (NSDictionary* user in [dict objectForKey:@"users"]) {
                if ([[user objectForKey:@"name"] isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:kUserName]]) {
                    self.groupIdent = [[dict objectForKey:@"id"] integerValue];
                }
            }
        }
    } onFailure:^(NSError *error) {
        NSLog(@"Error");
    }];
    
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
                             @"group"       :@{@"id"  :[NSNumber numberWithInteger:self.groupIdent]},
                             @"currency"    :@{@"id" :[NSNumber numberWithInteger:account.currency.ident]},
                             @"initBalance" :[NSNumber numberWithDouble:account.initBalance] };
    
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

- (void) updateAccount:(DSAccount*) account onSuccess:(void(^)(DSAccount* account)) success
             onFailure:(void(^)(NSError* error)) failure {
    NSDictionary* params = @{@"name"        : account.name,
                             @"group"       :@{@"id"  :[NSNumber numberWithInteger:self.groupIdent]},
                             @"currency"    :@{@"id" :[NSNumber numberWithInteger:account.currency.ident]},
                             @"initBalance" :[NSNumber numberWithDouble:account.initBalance] };
    
    [[DSApiManager sharedManager] putAccount:account.ident withParams:params onSuccess:^(NSDictionary *response) {
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

- (void) deleteAccount:(DSAccount*) account onSuccess:(void(^)(id object)) success
             onFailure:(void(^)(NSError* error)) failure {
    
    [[DSApiManager sharedManager] deleteAccount:account.ident onSuccess:^(id object) {
        if (success) {
            success(object);
        }
    } onFailure:^(NSError *error) {
        if (failure) {
            failure(error);
        }

    }];
    
}

- (void) getExpenseForAccID:(NSInteger) acID onSuccess:(void(^)(NSArray* result)) success
                  onFailure:(void(^)(NSError* error)) failure {
    
    
    [[DSApiManager sharedManager] getStatisticsForAccID:acID withFilter:@"EXPENSE" onSuccess:^(NSArray*response) {
        if (success) {
            success(response);
        }
    } onFailure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

- (void) getIncomeForAccID:(NSInteger) acID onSuccess:(void(^)(NSArray* result)) success
                  onFailure:(void(^)(NSError* error)) failure {
    
    
     [[DSApiManager sharedManager] getStatisticsForAccID:acID withFilter:@"INCOME" onSuccess:^(NSArray*response) {
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
            [[DSApiManager sharedManager] getStatisticsForAccID:acc.ident withFilter:@"EXPENSE" onSuccess:^(NSArray*response) {

                 if ([response count] > 0 ) {
                     NSDictionary *dict = [response  objectAtIndex:0];
                     acc.expense  =  [[dict  objectForKey:@"amount"] doubleValue];
                 }
                
            } onFailure:^(NSError *error) {
                NSLog(@"Error ");
            }];
            
           [[DSApiManager sharedManager] getStatisticsForAccID:acc.ident withFilter:@"INCOME" onSuccess:^(NSArray*response) {
                if ([response count] > 0 ) {
                    NSDictionary *dict = [response  objectAtIndex:0];
                    acc.income  =  [[dict  objectForKey:@"amount"] doubleValue];
                }
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


- (void) getCurrenciesOnSuccess:(void(^)(NSArray* currencies)) success
                      onFailure:(void(^)(NSError* error)) failure {
    
    [[DSApiManager sharedManager] getCurrenciesOnSuccess:^(NSDictionary *response) {
        
        NSMutableArray *currencies = [NSMutableArray new];
        for (NSDictionary* dict in response ) {
            DSCurrency* cur = [[DSCurrency alloc] initWithDictionary:dict];
            
            [currencies addObject:cur];
        }
        if (success)
            success(currencies);
        
    } onFailure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
    
}

- (void) getCateroriesOnSuccess:(void(^)(NSArray* categories)) success
                      onFailure:(void(^)(NSError* error)) failure {
    [[DSApiManager sharedManager] getCategoriesOnSuccess:^(NSDictionary *response) {
        
        NSMutableArray *categories = [NSMutableArray new];
        for (NSDictionary* dict in response ) {
            DSCategory* cur = [[DSCategory alloc] initWithDictionary:dict];
            
            [categories addObject:cur];
        }
        if (success)
            success(categories);
        
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


- (void) getOrdersForAcc:(NSInteger) accID withFilter:(NSString*) filter  OnSuccess:(void(^)(NSArray* orders)) success onFailure:(void(^)(NSError* error)) failure {
    
    [[DSApiManager sharedManager] getOrdersForAccId:accID withFilter:filter onSuccess:^(NSDictionary *responseObject) {
        NSMutableArray *orders = [NSMutableArray new];
        for (NSDictionary* dict in responseObject ) {
            DSOrder* order = [[DSOrder alloc] initWithDictionary:dict];
            [orders addObject:order];
        }
        if (success)
            success(orders);
    } onFailure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

- (void) createOrder:(DSOrder*) order onSuccess:(void(^)(DSOrder* order)) success
             onFailure:(void(^)(NSError* error)) failure {
    
    NSLog (@"%f", [order.date timeIntervalSince1970]);
    NSDictionary* params = @{@"amount"     : [NSNumber numberWithDouble:order.sum],
                             @"type"        : order.type == typeOrder ? @"ORDER" : @"TRANSFER_ORDER",
                             @"date"        : [NSNumber numberWithLongLong:([order.date timeIntervalSince1970] *1000)],
                             @"account"     :@{@"id"  :[NSNumber numberWithInteger:order.account.ident]},
                             @"category"    :@{@"id"  :[NSNumber numberWithInteger:order.category.ident]}};
    
    [[DSApiManager sharedManager] postOrder:params onSuccess:^(NSDictionary *response) {
        DSOrder* order;
        if ([response isKindOfClass:[NSDictionary class]]) {
            order = [[DSOrder alloc] initWithDictionary:response];
        }
        if (success) {
            success(order);
        }
    } onFailure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

- (void) updateOrder:(DSOrder*) order onSuccess:(void(^)(DSOrder* order)) success
             onFailure:(void(^)(NSError* error)) failure {
    
    NSDictionary* params = @{@"amount"     : [NSNumber numberWithDouble:order.sum],
                             @"type"        : order.type == typeOrder ? @"ORDER" : @"TRANSFER_ORDER",
                             @"date"        : [NSNumber numberWithLongLong:([order.date timeIntervalSince1970]*1000)],
                             @"account"     :@{@"id"  :[NSNumber numberWithInteger:order.account.ident]},
                             @"category"    :@{@"id"  :[NSNumber numberWithInteger:order.category.ident]}};
    
    [[DSApiManager sharedManager] putOrder:order.ident withParams:params onSuccess:^(NSDictionary *response) {
        DSOrder* order;
        if ([response isKindOfClass:[NSDictionary class]]) {
            order = [[DSOrder alloc] initWithDictionary:response];
        }
        if (success) {
            success(order);
        }
    } onFailure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

- (void) deleteOrder:(DSOrder*) order onSuccess:(void(^)(id object)) success
             onFailure:(void(^)(NSError* error)) failure {
    
    [[DSApiManager sharedManager] deleteOrder:order.ident onSuccess:^(id object) {
        if (success) {
            success(object);
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
       [self getCategoryAndCurrency];
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
