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

- (void) getAccount:(NSInteger) acID onSuccess:(void(^)(DSAccount* account)) success
          onFailure:(void(^)(NSError* error)) failure;

- (void) getAccountsOnSuccess:(void(^)(NSArray* accounts)) success
                    onFailure:(void(^)(NSError* error)) failure;


@end
