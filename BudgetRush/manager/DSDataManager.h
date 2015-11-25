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


@property (strong, nonatomic) DSUser* currentUser;

+ (DSDataManager *)sharedManager;

- (void) getAccount:(NSInteger) acID onSuccess:(void(^)(DSAccount* account)) success
          onFailure:(void(^)(NSError* error)) failure;

- (void) getAccountsOnSuccess:(void(^)(NSArray* accounts)) success
                    onFailure:(void(^)(NSError* error)) failure;

- (void) loginUserEmail:(NSString*) email password:(NSString*) password OnSuccess:(void(^)(id object)) success onFailure:(void(^)(NSError* error)) failure;

- (void) signUpUserEmail:(NSString*) email password:(NSString*) password OnSuccess:(void(^)(id object)) success onFailure:(void(^)(NSError* error)) failure;

- (void) recoveryUserEmail:(NSString*) email OnSuccess:(void(^)(id object)) success
               onFailure:(void(^)(NSError* error)) failure;


@end
