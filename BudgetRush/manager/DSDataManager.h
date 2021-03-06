//
//  DSDataManager.h
//  BudgetRush
//
//  Created by Dima on 31.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DSAccount;
@class DSCategory;
@class DSContractor;
@class DSCurrency;
@class DSOrder;
@class DSUser;
@class DSAccessToken;

@interface DSDataManager : NSObject

@property (assign, nonatomic) NSInteger groupIdent;
@property (strong, nonatomic) DSUser* currentUser;
@property (strong, nonatomic) NSMutableArray* categories;
@property (strong, nonatomic) NSMutableArray* currencies;

+ (DSDataManager *)sharedManager;

- (NSString*) getTOS;

- (NSString*) getPP;

- (void) getAccount:(NSInteger) acID onSuccess:(void(^)(DSAccount* account)) success
          onFailure:(void(^)(NSError* error)) failure;

- (void) getAccountsOnSuccess:(void(^)(NSArray* accounts)) success
                    onFailure:(void(^)(NSError* error)) failure;

- (void) createAccount:(DSAccount*) account onSuccess:(void(^)(DSAccount* account)) success
             onFailure:(void(^)(NSError* error)) failure;

- (void) updateAccount:(DSAccount*) account onSuccess:(void(^)(DSAccount* account)) success
             onFailure:(void(^)(NSError* error)) failure;

- (void) deleteAccount:(DSAccount*) account onSuccess:(void(^)(id object)) success
             onFailure:(void(^)(NSError* error)) failure;

- (void) getExpenseForAccID:(NSInteger) acID onSuccess:(void(^)(NSArray* result)) success
                  onFailure:(void(^)(NSError* error)) failure;

- (void) getIncomeForAccID:(NSInteger) acID onSuccess:(void(^)(NSArray* result)) success
                  onFailure:(void(^)(NSError* error)) failure;

- (void) getCurrenciesOnSuccess:(void(^)(NSArray* currencies)) success
                    onFailure:(void(^)(NSError* error)) failure;

- (void) getCateroriesOnSuccess:(void(^)(NSArray* categories)) success
                    onFailure:(void(^)(NSError* error)) failure;


- (void) getOrdersForAcc:(NSInteger) accID withFilter:(NSString*) filter  OnSuccess:(void(^)(NSArray* orders)) success onFailure:(void(^)(NSError* error)) failure;

- (void) createOrder:(DSOrder*) order onSuccess:(void(^)(DSOrder* order)) success
           onFailure:(void(^)(NSError* error)) failure;

- (void) updateOrder:(DSOrder*) order onSuccess:(void(^)(DSOrder* order)) success
           onFailure:(void(^)(NSError* error)) failure;

- (void) deleteOrder:(DSOrder*) order onSuccess:(void(^)(id object)) success
           onFailure:(void(^)(NSError* error)) failure;


- (void) loginUserEmail:(NSString*) email password:(NSString*) password OnSuccess:(void(^)(id object)) success onFailure:(void(^)(NSError* error)) failure;

- (void) signUpUserEmail:(NSString*) email password:(NSString*) password OnSuccess:(void(^)(id object)) success onFailure:(void(^)(NSError* error)) failure;

- (void) recoveryPassForEmail:(NSString*) email OnSuccess:(void(^)(id object)) success
                    onFailure:(void(^)(NSError* error)) failure ;


@end
