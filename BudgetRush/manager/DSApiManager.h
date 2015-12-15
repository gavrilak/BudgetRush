//
//  DSApiManager.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
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


@interface DSApiManager : NSObject

+ (DSApiManager *)sharedManager;

- (void) getAccountsOnSuccess:(void(^)(NSDictionary* response)) success
                    onFailure:(void(^)(NSError* error)) failure;

- (void) getAccount:(NSInteger) acID onSuccess:(void(^)(NSDictionary* response)) success
          onFailure:(void(^)(NSError* error)) failure;


- (void) getExpenseForAccID:(NSInteger) acID onSuccess:(void(^)(NSArray* response)) success
                  onFailure:(void(^)(NSError* error)) failure;

- (void) getIncomeForAccID:(NSInteger) acID onSuccess:(void(^)(NSArray* response)) success
                 onFailure:(void(^)(NSError* error)) failure;


- (void) postAccount:(NSDictionary*) params onSuccess:(void(^)(NSDictionary* response)) success onFailure:(void(^)(NSError* error)) failure;

- (void) putAccount:(NSInteger) accountID  withParams:(NSDictionary*) params onSuccess:(void(^)(NSDictionary* response)) success onFailure:(void(^)(NSError* error)) failure;

- (void) deleteAccount:(NSInteger) accountID onSuccess:(void(^)(id object)) success
             onFailure:(void(^)(NSError* error)) failure;

- (void) getCategoriesOnSuccess:(void(^)(NSDictionary* responseObject)) success
                      onFailure:(void(^)(NSError* error)) failure;

- (void) getCategory:(NSInteger) cat_id onSuccess:(void(^)(DSCategory* category)) success
           onFailure:(void(^)(NSError* error)) failure;

- (void) postCategory:(DSCategory*) category onSuccess:(void(^)(DSCategory* category)) success
            onFailure:(void(^)(NSError* error)) failure;

- (void) putCategory:(DSCategory*) category onSuccess:(void(^)(DSCategory* category)) success
           onFailure:(void(^)(NSError* error)) failure;

- (void) deleteCategory:(NSInteger) cat_id onSuccess:(void(^)(id success)) success
              onFailure:(void(^)(NSError* error)) failure;

- (void) getContractorsOnSuccess:(void(^)(NSArray* contractors)) success
                       onFailure:(void(^)(NSError* error)) failure;

- (void) getContractor:(NSInteger) con_id onSuccess:(void(^)(DSContractor* category)) success
             onFailure:(void(^)(NSError* error)) failure;

- (void) postContractor:(DSContractor*) contractor onSuccess:(void(^)(DSContractor* contractor)) success
              onFailure:(void(^)(NSError* error)) failure;

- (void) putContractor:(DSContractor*) contractor onSuccess:(void(^)(DSContractor* contractor)) success
             onFailure:(void(^)(NSError* error)) failure;

- (void) deleteContractor:(NSInteger) con_id onSuccess:(void(^)(id success)) success
                onFailure:(void(^)(NSError* error)) failure;



- (void) getCurrenciesOnSuccess:(void(^)(NSDictionary* responseObject)) success
                      onFailure:(void(^)(NSError* error)) failure;

- (void) getCurrency:(NSInteger) cur_id onSuccess:(void(^)(DSCurrency* currency)) success
           onFailure:(void(^)(NSError* error)) failure;

- (void) postCurrency:(DSCurrency*) currency onSuccess:(void(^)(DSCurrency* currency)) success
            onFailure:(void(^)(NSError* error)) failure;

- (void) putCurrency:(DSCurrency*) currency onSuccess:(void(^)(DSCurrency* currency)) success
           onFailure:(void(^)(NSError* error)) failure;

- (void) deleteCurrency:(NSInteger) cur_id onSuccess:(void(^)(id success)) success
              onFailure:(void(^)(NSError* error)) failure;




- (void) getOrdersOnSuccess:(void(^)(NSArray* orders)) success
                  onFailure:(void(^)(NSError* error)) failure;

- (void) getOrder:(NSInteger) ord_id onSuccess:(void(^)(DSOrder* order)) success
        onFailure:(void(^)(NSError* error)) failure;

- (void) postOrder:(DSOrder*) order onSuccess:(void(^)(DSOrder* order)) success
            onFailure:(void(^)(NSError* error)) failure;

- (void) putOrder:(DSOrder*) order onSuccess:(void(^)(DSOrder* order)) success
           onFailure:(void(^)(NSError* error)) failure;

- (void) deleteOrder:(NSInteger) ord_id onSuccess:(void(^)(id success)) success
           onFailure:(void(^)(NSError* error)) failure;





- (void) getUsersOnSuccess:(void(^)(NSArray* users)) success
                 onFailure:(void(^)(NSError* error)) failure;

- (void) getUser:(NSInteger) usr_id onSuccess:(void(^)(DSUser* user)) success
       onFailure:(void(^)(NSError* error)) failure;

- (void) postUser:(NSDictionary*) user onSuccess:(void(^)(NSDictionary *response)) success
        onFailure:(void(^)(NSError* error)) failure ;

- (void) putUser:(DSUser*) user onSuccess:(void(^)(DSUser* user)) success
       onFailure:(void(^)(NSError* error)) failure;

- (void) deleteUser:(NSInteger) usr_id onSuccess:(void(^)(id success)) success
          onFailure:(void(^)(NSError* error)) failure;

- (void) recoveryPasswordForEmail:(NSString*) email onSuccess:(void(^)(id object)) success
                        onFailure:(void(^)(NSError* error)) failure;

- (void) getTokenForUser:(NSString *) userName andPassword:(NSString*) password onSuccess:(void(^)(DSAccessToken* token)) success   onFailure:(void(^)(NSError* error)) failure;

- (void) refreshToken:(NSString*) token onSuccess:(void(^)(DSAccessToken* token)) success   onFailure:(void(^)(NSError* error)) failure;
@end
