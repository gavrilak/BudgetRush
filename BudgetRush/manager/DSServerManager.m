//
//  DSServerManager.m
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSServerManager.h"
#import <AFNetworking.h>

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
        
    }
    
    return self;
}
#pragma mark - accounts

- (void) getAccountsOnSuccess:(void(^)(NSArray* accounts)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    [self.requestOperationManager
     GET:@"/v1/accounts"
     parameters:nil
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

- (void) getAccount:(NSString*) ac_id onSuccess:(void(^)(DSAccount* account)) success
                   onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     GET:[@"/v1/accounts/" stringByAppendingString:ac_id]
     parameters:nil
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

- (void) postAccount:(DSAccount*) account onSuccess:(void(^)(DSAccount* account)) success   onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithInteger:account.ac_id],@"id",
                                                            account.name,@"name",
                            [NSNumber numberWithInteger:account.user_id],@"user_id",
                        [NSNumber numberWithInteger:account.currency_id],@"currency_id",nil];
    
    
    [self.requestOperationManager
     POST:@"/v1/accounts"
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

- (void) deleteAccount:(NSString*) ac_id onSuccess:(void(^)(id)) success
              onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     DELETE:[@"/v1/accounts" stringByAppendingString:ac_id]
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

#pragma mark - categories

- (void) getCategoriesOnSuccess:(void(^)(NSArray* categories)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    [self.requestOperationManager
     GET:@"/v1/categories"
     parameters:nil
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

- (void) getCategory:(NSString*) cat_id onSuccess:(void(^)(DSCategory* category)) success
          onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     GET:[@"/v1/categories/" stringByAppendingString:cat_id]
     parameters:nil
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

- (void) postCategory:(DSCategory*) category onSuccess:(void(^)(DSCategory* category)) success   onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
     [NSNumber numberWithInteger:category.cat_id],@"id",
                                    category.name,@"name",
     [NSNumber numberWithInteger:category.parent],@"parent", nil];
    
    
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


- (void) deleteCategory:(NSString*) cat_id onSuccess:(void(^)(id)) success
              onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     DELETE:[@"/v1/categories" stringByAppendingString:cat_id]
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
     parameters:nil
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

- (void) getContractor:(NSString*) con_id onSuccess:(void(^)(DSContractor* category)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     GET:[@"/v1/contrsctors/" stringByAppendingString:con_id]
     parameters:nil
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

- (void) postContractor:(DSContractor*) contractor onSuccess:(void(^)(DSContractor* contractor)) success   onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithInteger:contractor.con_id],@"id",
                                                        contractor.name,@"name",
                                                        contractor.descr,@"description",nil];
    
    
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

- (void) deleteContractor:(NSString*) con_id onSuccess:(void(^)(id)) success
              onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     DELETE:[@"/v1/contractors" stringByAppendingString:con_id]
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
     parameters:nil
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

- (void) getCurrency:(NSString*) cur_id onSuccess:(void(^)(DSCurrency* currency)) success
             onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     GET:[@"/v1/currencies/" stringByAppendingString:cur_id]
     parameters:nil
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

- (void) postCurrency:(DSCurrency*) currency onSuccess:(void(^)(DSCurrency* currency)) success   onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            currency.name,@"name",
                            currency.shortName, @"shortName",
                            [NSNumber numberWithInteger:currency.code],@"code",
                            [NSNumber numberWithChar:currency.code],@"symbol",nil];
    
    
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

- (void) deleteCurrency:(NSString*) cur_id onSuccess:(void(^)(id)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     DELETE:[@"/v1/currencies" stringByAppendingString:cur_id]
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
     parameters:nil
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

- (void) getOrder:(NSString*) ord_id onSuccess:(void(^)(DSOrder* order)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     GET:[@"/v1/orders/" stringByAppendingString:ord_id]
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

- (void) deleteOrder:(NSString*) ord_id onSuccess:(void(^)(id)) success
          onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     DELETE:[@"/v1/orders/" stringByAppendingString:ord_id]
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
     parameters:nil
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

- (void) getUser:(NSString*) usr_id onSuccess:(void(^)(DSUser* user)) success
        onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     GET:[@"/v1/users/" stringByAppendingString:usr_id]
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

- (void) postUser:(DSUser*) user onSuccess:(void(^)(DSUser* user)) success   onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            user.name,@"name",
                            user.password,@"password",nil];
    
    
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

- (void) deleteUser:(NSString*) usr_id onSuccess:(void(^)(id)) success
       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    [self.requestOperationManager
     DELETE:[@"/v1/users/" stringByAppendingString:usr_id]
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


@end
