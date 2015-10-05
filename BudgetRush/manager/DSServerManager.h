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

- (void) getAccount:(NSInteger) ac_id onSuccess:(void(^)(DSAccount* account)) success
          onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) postAccount:(DSAccount*) account onSuccess:(void(^)(DSAccount* account)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) putAccount:(DSAccount*) account onSuccess:(void(^)(DSAccount* account)) success
          onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) deleteAccount:(NSInteger) ac_id onSuccess:(void(^)(id)) success
             onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;


- (void) getCategoriesOnSuccess:(void(^)(NSArray* categories)) success
                      onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getCategory:(NSInteger) cat_id onSuccess:(void(^)(DSCategory* category)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) postCategory:(DSCategory*) category onSuccess:(void(^)(DSCategory* category)) success
            onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) putCategory:(DSCategory*) category onSuccess:(void(^)(DSCategory* category)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) deleteCategory:(NSInteger) cat_id onSuccess:(void(^)(id)) success
              onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;





- (void) getContractorsOnSuccess:(void(^)(NSArray* contractors)) success
                       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getContractor:(NSInteger) con_id onSuccess:(void(^)(DSContractor* category)) success
             onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) postContractor:(DSContractor*) contractor onSuccess:(void(^)(DSContractor* contractor)) success
              onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) putContractor:(DSContractor*) contractor onSuccess:(void(^)(DSContractor* contractor)) success
             onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) deleteContractor:(NSInteger) con_id onSuccess:(void(^)(id)) success
                onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;



- (void) getCurrenciesOnSuccess:(void(^)(NSArray* currencies)) success
                      onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getCurrency:(NSInteger) cur_id onSuccess:(void(^)(DSCurrency* currency)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) postCurrency:(DSCurrency*) currency onSuccess:(void(^)(DSCurrency* currency)) success
            onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) putCurrency:(DSCurrency*) currency onSuccess:(void(^)(DSCurrency* currency)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) deleteCurrency:(NSInteger) cur_id onSuccess:(void(^)(id)) success
              onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;




- (void) getOrdersOnSuccess:(void(^)(NSArray* orders)) success
                  onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getOrder:(NSInteger) ord_id onSuccess:(void(^)(DSOrder* order)) success
        onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;



- (void) deleteOrder:(NSInteger) ord_id onSuccess:(void(^)(id)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;





- (void) getUsersOnSuccess:(void(^)(NSArray* users)) success
                 onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getUserRoleForName:(NSString*) name onSuccess:(void(^)(NSString* role)) success
                  onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getUser:(NSInteger) usr_id onSuccess:(void(^)(DSUser* user)) success
       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) postUser:(DSUser*) user onSuccess:(void(^)(DSUser* user)) success
        onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) putUser:(DSUser*) user onSuccess:(void(^)(DSUser* user)) success
       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) putUserRole:(DSUser*) user onSuccess:(void(^)(DSUser* user)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) deleteUser:(NSInteger) usr_id onSuccess:(void(^)(id)) success
          onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;
@end
