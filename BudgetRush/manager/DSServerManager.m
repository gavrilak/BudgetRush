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


#pragma mark - token


@end
