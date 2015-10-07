//
//  DSServerManager.m
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSServerManager.h"
#import <AFNetworking.h>

const NSString* rest_id = @"ios_id";
const NSString* rest_key = @"ios_key";

@interface  DSServerManager ()

@property (strong,nonatomic) AFHTTPRequestOperationManager *requestOperationManager;
@property (strong, nonatomic) DSAccessToken *accessToken;

@end


@implementation DSServerManager

+ (DSServerManager *)sharedManager {
    
    static DSServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DSServerManager alloc]init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"https://46.101.220.157:9443"]];
       // self.requestOperationManager.requestSerializer =  [AFJSONRequestSerializer serializer];

        AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode: AFSSLPinningModeNone];
        policy.allowInvalidCertificates = YES;
        policy.validatesDomainName = NO;
        self.requestOperationManager.securityPolicy = policy;
    }
    
    return self;
}
#pragma mark - accounts

- (void) getAccountsOnSuccess:(void(^)(NSArray* accounts)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    [self.requestOperationManager
     GET:@"/v1/accounts"
     parameters:@{@"access_token":self.accessToken.token}
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         NSMutableArray* objectsArray = [NSMutableArray array];
         
         for (NSDictionary* dict in responseObject) {
             DSAccount* acc = [[DSAccount alloc] initWithDictionary:dict];
             [objectsArray addObject:acc];
         }
         
         if (success) {
             success(objectsArray);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
    
}

- (void) getAccount:(NSInteger) ac_id onSuccess:(void(^)(DSAccount* account)) success
                   onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     GET:[NSString stringWithFormat:@"/v1/accounts/%ld" ,ac_id]
     parameters:@{@"access_token":self.accessToken.token}
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         DSAccount* account;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             account = [[DSAccount alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(account);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
}

- (void) postAccount:(DSAccount*) account onSuccess:(void(^)(DSAccount* account)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = @{@"name"        : account.name,
                             @"user"        :@{@"id"     :[NSNumber numberWithInteger:account.user_id]},
                             @"currency"    :@{@"id" :[NSNumber numberWithInteger:account.currency_id]}};

    
    self.requestOperationManager.requestSerializer =  [AFJSONRequestSerializer serializer];
     [self.requestOperationManager
     POST:[NSString stringWithFormat: @"/v1/accounts?access_token=%@",self.accessToken.token ]
     parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSAccount* account;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             account = [[DSAccount alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(account);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
}

- (void) putAccount:(DSAccount*) account onSuccess:(void(^)(DSAccount* account)) success
          onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = @{@"name"        : account.name,
                             @"user"        :@{@"id"     :[NSNumber numberWithInteger:account.user_id]},
                             @"currency"    :@{@"id" :[NSNumber numberWithInteger:account.currency_id]},
                             @"access_token":self.accessToken.token };
    
    
    [self.requestOperationManager
     PUT:[NSString stringWithFormat:@"/v1/accounts/%ld" ,(long)account.ac_id]
     parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSAccount* account;
         
         for (NSDictionary* dict in responseObject) {
             account = [[DSAccount alloc] initWithDictionary:dict];
         }
         
         if (success) {
             success(account);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
    
}


- (void) deleteAccount:(NSInteger) ac_id onSuccess:(void(^)(id)) success
              onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     DELETE:[NSString stringWithFormat:@"/v1/accounts/%ld" ,ac_id]
     parameters:@{@"access_token":self.accessToken.token}
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         if (success) {
             success(@"success");
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
}

#pragma mark - categories

- (void) getCategoriesOnSuccess:(void(^)(NSArray* categories)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    [self.requestOperationManager
     GET:@"/v1/categories"
     parameters:@{@"access_token":self.accessToken.token}
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         NSMutableArray* objectsArray = [NSMutableArray array];
         
         for (NSDictionary* dict in responseObject) {
             DSCategory* cat = [[DSCategory alloc] initWithDictionary:dict];
             [objectsArray addObject:cat];
         }
         
         if (success) {
             success(objectsArray);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
    
}

- (void) getCategory:(NSInteger) cat_id onSuccess:(void(^)(DSCategory* category)) success
          onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     GET:[NSString stringWithFormat:@"/v1/categories/%ld",cat_id]
     parameters:@{@"access_token":self.accessToken.token}
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         DSCategory* category;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             category = [[DSCategory alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(category);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
}

- (void) postCategory:(DSCategory*) category onSuccess:(void(^)(DSCategory* category)) success
                            onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = @{ @"id"     :[NSNumber numberWithInteger:category.cat_id],
                              @"name"   :category.name,
                              @"parent" :[NSNumber numberWithInteger:category.parent]};

    [self.requestOperationManager
     POST:@"/v1/categories"
     parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSCategory* category;
         
         for (NSDictionary* dict in responseObject) {
             category = [[DSCategory alloc] initWithDictionary:dict];
         }
         
         if (success) {
             success(category);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
    
}

- (void) putCategory:(DSCategory*) category onSuccess:(void(^)(DSCategory* category)) success
                            onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = @{ @"id"     :[NSNumber numberWithInteger:category.cat_id],
                              @"name"   :category.name,
                              @"parent" :[NSNumber numberWithInteger:category.parent]};
    
    
    [self.requestOperationManager
     PUT:[NSString stringWithFormat: @"/v1/categories/%ld",category.cat_id]
     parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSCategory* category;
         
         for (NSDictionary* dict in responseObject) {
             category = [[DSCategory alloc] initWithDictionary:dict];
         }
         
         if (success) {
             success(category);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
    
}

- (void) deleteCategory:(NSInteger) cat_id onSuccess:(void(^)(id)) success
              onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     DELETE:[NSString stringWithFormat: @"/v1/categories/%ld",cat_id]
     parameters:nil
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         if (success) {
             success(@"success");
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
}
#pragma mark - contractors

- (void) getContractorsOnSuccess:(void(^)(NSArray* contractors)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    [self.requestOperationManager
     GET:@"/v1/contractors"
     parameters:@{@"access_token":self.accessToken.token}
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         NSMutableArray* objectsArray = [NSMutableArray array];
         
         for (NSDictionary* dict in responseObject) {
             DSContractor* con = [[DSContractor alloc] initWithDictionary:dict];
             [objectsArray addObject:con];
         }
         
         if (success) {
             success(objectsArray);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
    
}

- (void) getContractor:(NSInteger) con_id onSuccess:(void(^)(DSContractor* category)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     GET:[NSString stringWithFormat:@"/v1/contractors/%ld" ,con_id]
     parameters:@{@"access_token":self.accessToken.token}
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         DSContractor* contractor;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             contractor = [[DSContractor alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(contractor);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
}

- (void) postContractor:(DSContractor*) contractor onSuccess:(void(^)(DSContractor* contractor)) success   onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = @{ @"id"           :[NSNumber numberWithInteger:contractor.con_id],
                              @"name"         : contractor.name,
                              @"description"  : contractor.descr};
    
    [self.requestOperationManager
     POST:@"/v1/contractors"
     parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSContractor* contractor;
         
         for (NSDictionary* dict in responseObject) {
             contractor = [[DSContractor alloc] initWithDictionary:dict];
         }
         
         if (success) {
             success(contractor);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
    
}

- (void) putContractor:(DSContractor*) contractor onSuccess:(void(^)(DSContractor* contractor)) success
                                                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = @{ @"id"           :[NSNumber numberWithInteger:contractor.con_id],
                              @"name"         : contractor.name,
                              @"description"  : contractor.descr};
    
    
    [self.requestOperationManager
     PUT:[NSString stringWithFormat :@"/v1/contractors/%ld",contractor.con_id]
     parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSContractor* contractor;
         
         for (NSDictionary* dict in responseObject) {
             contractor = [[DSContractor alloc] initWithDictionary:dict];
         }
         
         if (success) {
             success(contractor);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
    
}


- (void) deleteContractor:(NSInteger) con_id onSuccess:(void(^)(id)) success
              onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     DELETE:[NSString stringWithFormat:@"/v1/contractors/%ld",con_id]
     parameters:nil
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         if (success) {
             success(@"success");
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
}

#pragma mark - currencies

- (void) getCurrenciesOnSuccess:(void(^)(NSArray* currencies)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    [self.requestOperationManager
     GET:@"/v1/currencies"
     parameters:@{@"access_token":self.accessToken.token}
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         NSMutableArray* objectsArray = [NSMutableArray array];
         
         for (NSDictionary* dict in responseObject) {
             DSCurrency* curr = [[DSCurrency alloc] initWithDictionary:dict];
             [objectsArray addObject:curr];
         }
         
         if (success) {
             success(objectsArray);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
    
}

- (void) getCurrency:(NSInteger) cur_id onSuccess:(void(^)(DSCurrency* currency)) success
             onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     GET:[NSString stringWithFormat:@"/v1/currencies/%ld", cur_id]
     parameters:@{@"access_token":self.accessToken.token}
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         DSCurrency* currency;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             currency = [[DSCurrency alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(currency);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
}

- (void) postCurrency:(DSCurrency*) currency onSuccess:(void(^)(DSCurrency* currency)) success
            onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = @{@"name"        : currency.name,
                             @"shortName"   : currency.shortName,
                             @"code"        : [NSNumber numberWithInteger:currency.code],
                             @"symbol"      : currency.symbol};
    
    
    [self.requestOperationManager
     POST:@"/v1/currencies"
     parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSCurrency* currency;
         
         for (NSDictionary* dict in responseObject) {
             currency = [[DSCurrency alloc] initWithDictionary:dict];
         }
         
         if (success) {
             success(currency);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
    
}


- (void) putCurrency:(DSCurrency*) currency onSuccess:(void(^)(DSCurrency* currency)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = @{@"name"        : currency.name,
                             @"shortName"   : currency.shortName,
                             @"code"        : [NSNumber numberWithInteger:currency.code],
                             @"symbol"      : currency.symbol };
    
    
    [self.requestOperationManager
     PUT:[NSString stringWithFormat:@"/v1/currencies/%ld",currency.cur_id]
     parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSCurrency* currency;
         
         for (NSDictionary* dict in responseObject) {
             currency = [[DSCurrency alloc] initWithDictionary:dict];
         }
         
         if (success) {
             success(currency);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
    
}

- (void) deleteCurrency:(NSInteger) cur_id onSuccess:(void(^)(id)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     DELETE:[NSString stringWithFormat:@"/v1/currencies/%ld" ,cur_id]
     parameters:nil
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         if (success) {
             success(@"success");
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
}
#pragma mark - orders

- (void) getOrdersOnSuccess:(void(^)(NSArray* orders)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    [self.requestOperationManager
     GET:@"/v1/orders"
     parameters:@{@"access_token":self.accessToken.token}
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         NSMutableArray* objectsArray = [NSMutableArray array];
         
         for (NSDictionary* dict in responseObject) {
             DSOrder* order = [[DSOrder alloc] initWithDictionary:dict];
             [objectsArray addObject:order];
         }
         
         if (success) {
             success(objectsArray);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
    
}

- (void) getOrder:(NSInteger) ord_id onSuccess:(void(^)(DSOrder* order)) success
        onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     GET:[NSString stringWithFormat:@"/v1/orders/%ld", ord_id]
     parameters:@{@"access_token":self.accessToken.token}
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         DSOrder* order;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             order = [[DSOrder alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(order);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
}

- (void) postOrder:(DSOrder*) order onSuccess:(void(^)(DSCurrency* currency)) success
            onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = @{@"ammount"     : [NSNumber numberWithDouble:[[NSDecimalNumber decimalNumberWithDecimal:order.amount] doubleValue]],
                             @"date"        : order.date,
                             @"symbol"      : @""};
    
    
    [self.requestOperationManager
     POST:@"/v1/currencies"
     parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSCurrency* currency;
         
         for (NSDictionary* dict in responseObject) {
             currency = [[DSCurrency alloc] initWithDictionary:dict];
         }
         
         if (success) {
             success(currency);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
    
}

- (void) putOrder:(NSInteger) ord_id onSuccess:(void(^)(DSOrder* order)) success
        onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     GET:[NSString stringWithFormat:@"/v1/orders/%ld", ord_id]
     parameters:nil
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         DSOrder* order;
         
         for (NSDictionary* dict in responseObject) {
             order = [[DSOrder alloc] initWithDictionary:dict];
         }
         
         if (success) {
             success(order);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
}




- (void) deleteOrder:(NSInteger) ord_id onSuccess:(void(^)(id)) success
          onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     DELETE:[NSString stringWithFormat:@"/v1/orders/%ld", ord_id]
     parameters:nil
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         if (success) {
             success(@"success");
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
}


#pragma mark - users

- (void) getUsersOnSuccess:(void(^)(NSArray* users)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    [self.requestOperationManager
     GET:@"/v1/users"
     parameters:@{@"access_token":self.accessToken.token}
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         NSMutableArray* objectsArray = [NSMutableArray array];
         
         for (NSDictionary* dict in responseObject) {
             DSUser* user = [[DSUser alloc] initWithDictionary:dict];
             [objectsArray addObject:user];
         }
         
         if (success) {
             success(objectsArray);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
    
}

- (void) getUser:(NSInteger) usr_id onSuccess:(void(^)(DSUser* user)) success
        onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     GET:[NSString stringWithFormat:@"/v1/users/%ld", usr_id]
     parameters:@{@"access_token":self.accessToken.token}
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         DSUser* user;
         
         for (NSDictionary* dict in responseObject) {
             user = [[DSUser alloc] initWithDictionary:dict];
         }
         
         if (success) {
             success(user);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
}

- (void) getUserRoleForName:(NSString*) name onSuccess:(void(^)(NSString* role)) success
       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     GET:[@"/v1/users/role/" stringByAppendingString:name]
     parameters:nil
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         NSString* role;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]){
             role = [responseObject objectForKey:@"role"];
         }
         
         if (success) {
             success(role);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
}

- (void) postUser:(DSUser*) user onSuccess:(void(^)(DSUser* user)) success
        onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = @{@"name"     :user.name ,
                             @"password" :user.password };
    
    
    [self.requestOperationManager
     POST:@"/v1/users"
     parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSUser* user;
         
         for (NSDictionary* dict in responseObject) {
             user = [[DSUser alloc] initWithDictionary:dict];
         }
         
         if (success) {
             success(user);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
    
}

- (void) putUser:(DSUser*) user onSuccess:(void(^)(DSUser* user)) success
       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = @{@"name"     :user.name ,
                             @"password" :user.password };
    
    
    [self.requestOperationManager
     PUT:[NSString stringWithFormat:@"/v1/users/%ld" , user.usr_id]
     parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSUser* user;
         
         for (NSDictionary* dict in responseObject) {
             user = [[DSUser alloc] initWithDictionary:dict];
         }
         
         if (success) {
             success(user);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
    
}

- (void) putUserRole:(DSUser*) user onSuccess:(void(^)(DSUser* user)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSString *role  = user.role == userRole ? @"ROLE_USER" : @"ROLE_ADMIN";

    [self.requestOperationManager
     PUT:[NSString stringWithFormat:@"/v1/users/role/%@&%@" , user.name , role]
     parameters:nil
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSUser* user;
         
         for (NSDictionary* dict in responseObject) {
             user = [[DSUser alloc] initWithDictionary:dict];
         }
         
         if (success) {
             success(user);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
    
}


- (void) deleteUser:(NSInteger) usr_id onSuccess:(void(^)(id)) success
       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     DELETE:[NSString  stringWithFormat:@"/v1/users/%ld" , usr_id]
     parameters:nil
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         if (success) {
             success(@"success");
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
}

#pragma mark - token
- (void) getTokenForUser:(NSString *) userName andPassword:(NSString*) password onSuccess:(void(^)(DSAccessToken* token)) success   onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = @{@"client_id"     : rest_id,
                             @"client_secret" : rest_key,
                             @"grant_type"    : @"password",
                             @"username"      : userName ,
                             @"password"      : password };
    
    
    [self.requestOperationManager
     POST:@"/oauth/token"
     parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSAccessToken* token;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             token = [[DSAccessToken alloc] initWithServerResponse:responseObject];
             self.accessToken = token;
         }
         
         if (success) {
             success(token);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
    
}

- (void) refreshToken:(NSString*) token onSuccess:(void(^)(DSAccessToken* token)) success   onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = @{@"client_id"     : rest_id,
                             @"client_secret" : rest_key,
                             @"grant_type"    : @"refresh_token",
                             @"refresh_token" : token };
    
    
    [self.requestOperationManager
     POST:@"/oauth/token"
     parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSAccessToken* token;
         
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
             token = [[DSAccessToken alloc] initWithServerResponse:responseObject];
            self.accessToken = token;
         }
         
         if (success) {
             success(token);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
    
     }];
    
}


@end
