//
//  DSServerManager.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSAccount.h"
#import "DSCategory.h"
#import "DSContractor.h"
#import "DSCurrency.h"
#import "DSOrder.h"
#import "DSUser.h"
#import "DSAccessToken.h"

@interface DSServerManager : NSObject

+ (DSServerManager *)sharedManager;

- (void) getAccountsOnSuccess:(void(^)(NSArray* accounts)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getAccount:(NSString*) ac_id onSuccess:(void(^)(DSAccount* account)) success
          onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;


- (void) getCategoriesOnSuccess:(void(^)(NSArray* categories)) success
                      onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getCategory:(NSString*) cat_id onSuccess:(void(^)(DSCategory* category)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;


- (void) getContractorsOnSuccess:(void(^)(NSArray* contractors)) success
                       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getContractor:(NSString*) con_id onSuccess:(void(^)(DSContractor* category)) success
             onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;



- (void) getCurrenciesOnSuccess:(void(^)(NSArray* currencies)) success
                      onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getCurrency:(NSString*) cur_id onSuccess:(void(^)(DSCurrency* currency)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;



- (void) getOrdersOnSuccess:(void(^)(NSArray* orders)) success
                  onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getOrder:(NSString*) ord_id onSuccess:(void(^)(DSOrder* order)) success
        onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;



- (void) getUsersOnSuccess:(void(^)(NSArray* users)) success
                 onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getUser:(NSString*) usr_id onSuccess:(void(^)(DSUser* user)) success
       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

@end
