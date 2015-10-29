//
//  DSServerManager.m
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//
#import "Settings.h"
#import "DSServerManager.h"
#import <AFNetworking.h>
#import "DSAccount.h"
#import "DSCategory.h"
#import "DSContractor.h"
#import "DSCurrency.h"
#import "DSOrder.h"
#import "DSUser.h"
#import "DSAccessToken.h"

#warning TODO: Раз уж мы перешли на NSURLSession, думаю стоит удалить из подов AFNetworking компонент NSURLConnection. В подах есть такая возможность, можно ставить только те компоненты, которые будут использоваться в проекте
#warning TODO: "/v1/" повторяется в каждом запросе. Лучше вынести это в отдельную константу и включить в baseURL. Зачем его повторять? К тому же, в следующем релизе этот путь может поменяться на v2, будешь править все запросы?
#warning TODO: Данный менеджер должен отвечать только за работу с АПИ, т.е. выполнение запросов. Парсинг данных должен осуществляться в другом месте. Советую создать что-то типа DSDataManager, который будет работать с API менеджером и будет парсить данные.

@interface  DSServerManager () {

    DSAccessToken *_accessToken;
    AFHTTPSessionManager *_sessionManager;
}
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
        
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        
        _sessionManager.responseSerializer =  [AFJSONResponseSerializer serializer];
        AFSecurityPolicy* policy = [AFSecurityPolicy policyWithPinningMode: AFSSLPinningModeNone];
        policy.allowInvalidCertificates = YES;
        policy.validatesDomainName = NO;
        _sessionManager.securityPolicy = policy;
    }
    
    return self;
}
#pragma mark - accounts

- (void) getAccountsOnSuccess:(void(^)(NSArray* accounts)) success
                    onFailure:(void(^)(NSError* error)) failure {
    
    
    [_sessionManager
     GET:@"/v1/accounts"
     parameters:@{@"access_token":_accessToken.token}
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         NSMutableArray* objectsArray = [NSMutableArray array];
         
         for (NSDictionary* dict in responseObject) {
             DSAccount* acc = [[DSAccount alloc] initWithDictionary:dict];
             [objectsArray addObject:acc];
         }
         
         if (success) {
             success(objectsArray);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
    
}

- (void) getAccount:(NSInteger) ac_id onSuccess:(void(^)(DSAccount* account)) success
                   onFailure:(void(^)(NSError* error)) failure {
    [_sessionManager
     GET:[NSString stringWithFormat:@"/v1/accounts/%ld" ,ac_id]
     parameters:@{@"access_token":_accessToken.token}
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         DSAccount* account;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             account = [[DSAccount alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(account);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
}

- (void) postAccount:(DSAccount*) account onSuccess:(void(^)(DSAccount* account)) success
           onFailure:(void(^)(NSError* error)) failure {
    
    
    NSDictionary* params = @{@"name"        : account.name,
                             @"user"        :@{@"id" :[NSNumber numberWithInteger:account.user_id]},
                             @"currency"    :@{@"id" :[NSNumber numberWithInteger:account.currency_id]}};

#warning ???: Зачем это делать в каждом запросе? Достаточно один раз при инициализации менеджера
    _sessionManager.requestSerializer =  [AFJSONRequestSerializer serializer];
     [_sessionManager
     POST:[NSString stringWithFormat: @"/v1/accounts?access_token=%@",_accessToken.token ]
     parameters:params
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSAccount* account;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             account = [[DSAccount alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(account);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
}

- (void) putAccount:(DSAccount*) account onSuccess:(void(^)(DSAccount* account)) success
          onFailure:(void(^)(NSError* error)) failure {
    
    
    NSDictionary* params = @{@"name"        : account.name,
                             @"user"        :@{@"id"  :[NSNumber numberWithInteger:account.user_id]},
                             @"currency"    :@{@"id" :[NSNumber numberWithInteger:account.currency_id]}};
    
     _sessionManager.requestSerializer =  [AFJSONRequestSerializer serializer];
    [_sessionManager
     PUT:[NSString stringWithFormat:@"/v1/accounts/%ld?access_token=%@",account.obj_id,_accessToken.token]
     parameters:params
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSAccount* account;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             account = [[DSAccount alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(account);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
    
}


- (void) deleteAccount:(NSInteger) ac_id onSuccess:(void(^)(id success)) success
              onFailure:(void(^)(NSError* error)) failure {
    [_sessionManager
     DELETE:[NSString stringWithFormat:@"/v1/accounts/%ld" ,ac_id]
     parameters:@{@"access_token":_accessToken.token}
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         if (success) {
             success(@"success");
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
}

#pragma mark - categories

- (void) getCategoriesOnSuccess:(void(^)(NSArray* categories)) success
                    onFailure:(void(^)(NSError* error)) failure {
    
    
    [_sessionManager
     GET:@"/v1/categories"
     parameters:@{@"access_token":_accessToken.token}
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         NSMutableArray* objectsArray = [NSMutableArray array];
         
         for (NSDictionary* dict in responseObject) {
             DSCategory* cat = [[DSCategory alloc] initWithDictionary:dict];
             [objectsArray addObject:cat];
         }
         
         if (success) {
             success(objectsArray);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
    
}

- (void) getCategory:(NSInteger) cat_id onSuccess:(void(^)(DSCategory* category)) success
          onFailure:(void(^)(NSError* error)) failure {
    [_sessionManager
     GET:[NSString stringWithFormat:@"/v1/categories/%ld",cat_id]
     parameters:@{@"access_token":_accessToken.token}
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         DSCategory* category;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             category = [[DSCategory alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(category);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
}

- (void) postCategory:(DSCategory*) category onSuccess:(void(^)(DSCategory* category)) success
                            onFailure:(void(^)(NSError* error)) failure {
    
    
    NSDictionary* params = @{ @"name"   :category.name,
                              @"user"   :@{@"id"  :[NSNumber numberWithInteger:category.user_id]},
                              @"parent" :category.parent_id == 0 ? [NSNull null] : [NSNumber numberWithInteger:category.parent_id]};
    

    _sessionManager.requestSerializer =  [AFJSONRequestSerializer serializer];
    [_sessionManager
     POST: [NSString stringWithFormat:@"/v1/categories?access_token=%@",_accessToken.token ]
     parameters:params
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSCategory* category;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             category = [[DSCategory alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(category);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
    
}

- (void) putCategory:(DSCategory*) category onSuccess:(void(^)(DSCategory* category)) success
                            onFailure:(void(^)(NSError* error)) failure {
    
    NSDictionary* params = @{ @"name"   :category.name,
                              @"user"   :@{@"id"  :[NSNumber numberWithInteger:category.user_id]},
                              @"parent" :category.parent_id == 0 ? [NSNull null] : [NSNumber numberWithInteger:category.parent_id]};
    
    _sessionManager.requestSerializer =  [AFJSONRequestSerializer serializer];
    [_sessionManager
     PUT:[NSString stringWithFormat:@"/v1/categories/%ld?access_token=%@",category.obj_id,_accessToken.token]
     parameters:params
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSCategory* category;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             category = [[DSCategory alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(category);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
    
}

- (void) deleteCategory:(NSInteger) cat_id onSuccess:(void(^)(id success)) success
              onFailure:(void(^)(NSError* error)) failure {
    [_sessionManager
     DELETE:[NSString stringWithFormat: @"/v1/categories/%ld",cat_id]
     parameters:@{@"access_token":_accessToken.token}
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         if (success) {
             success(@"success");
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
}
#pragma mark - contractors

- (void) getContractorsOnSuccess:(void(^)(NSArray* contractors)) success
                    onFailure:(void(^)(NSError* error)) failure {
    
    
    [_sessionManager
     GET:@"/v1/contractors"
     parameters:@{@"access_token":_accessToken.token}
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         NSMutableArray* objectsArray = [NSMutableArray array];
         
         for (NSDictionary* dict in responseObject) {
             DSContractor* con = [[DSContractor alloc] initWithDictionary:dict];
             [objectsArray addObject:con];
         }
         
         if (success) {
             success(objectsArray);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
    
}

- (void) getContractor:(NSInteger) con_id onSuccess:(void(^)(DSContractor* category)) success
           onFailure:(void(^)(NSError* error)) failure {
    [_sessionManager
     GET:[NSString stringWithFormat:@"/v1/contractors/%ld" ,con_id]
     parameters:@{@"access_token":_accessToken.token}
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         DSContractor* contractor;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             contractor = [[DSContractor alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(contractor);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
}

- (void) postContractor:(DSContractor*) contractor onSuccess:(void(^)(DSContractor* contractor)) success   onFailure:(void(^)(NSError* error)) failure {
    
    
    NSDictionary* params = @{ @"name"         : contractor.name,
                              @"description"  : contractor.descr,
                              @"user"         :@{@"id"  :[NSNumber numberWithInteger:contractor.user_id]}};
    
    _sessionManager.requestSerializer =  [AFJSONRequestSerializer serializer];
    [_sessionManager
     POST: [NSString stringWithFormat:@"/v1/contractors?access_token=%@",_accessToken.token ]
     parameters:params
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSContractor* contractor;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             contractor = [[DSContractor alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(contractor);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
    
}

- (void) putContractor:(DSContractor*) contractor onSuccess:(void(^)(DSContractor* contractor)) success
                                                    onFailure:(void(^)(NSError* error)) failure {
    
    
    NSDictionary* params =@{ @"name"         : contractor.name,
                             @"description"  : contractor.descr,
                             @"user"         :@{@"id"  :[NSNumber numberWithInteger:contractor.user_id]}};
    
    _sessionManager.requestSerializer =  [AFJSONRequestSerializer serializer];
    [_sessionManager
     PUT:[NSString stringWithFormat:@"/v1/contractors/%ld?access_token=%@",contractor.obj_id,_accessToken.token]
     parameters:params
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSContractor* contractor;
         
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
             contractor = [[DSContractor alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(contractor);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
    
}


- (void) deleteContractor:(NSInteger) con_id onSuccess:(void(^)(id success)) success
              onFailure:(void(^)(NSError* error)) failure {
    [_sessionManager
     DELETE:[NSString stringWithFormat:@"/v1/contractors/%ld",con_id]
     parameters:@{@"access_token":_accessToken.token}
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         if (success) {
             success(@"success");
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
}

#pragma mark - currencies

- (void) getCurrenciesOnSuccess:(void(^)(NSArray* currencies)) success
                    onFailure:(void(^)(NSError* error)) failure {
    
    
    [_sessionManager
     GET:@"/v1/currencies"
     parameters:@{@"access_token":_accessToken.token}
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         NSMutableArray* objectsArray = [NSMutableArray array];
         
         for (NSDictionary* dict in responseObject) {
             DSCurrency* curr = [[DSCurrency alloc] initWithDictionary:dict];
             [objectsArray addObject:curr];
         }
         
         if (success) {
             success(objectsArray);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
    
}

- (void) getCurrency:(NSInteger) cur_id onSuccess:(void(^)(DSCurrency* currency)) success
             onFailure:(void(^)(NSError* error)) failure {
    [_sessionManager
     GET:[NSString stringWithFormat:@"/v1/currencies/%ld", cur_id]
     parameters:@{@"access_token":_accessToken.token}
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         DSCurrency* currency;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             currency = [[DSCurrency alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(currency);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
}

- (void) postCurrency:(DSCurrency*) currency onSuccess:(void(^)(DSCurrency* currency)) success
            onFailure:(void(^)(NSError* error)) failure {
    
    
    NSDictionary* params = @{@"name"        : currency.name,
                             @"shortName"   : currency.shortName,
                             @"code"        : [NSNumber numberWithInteger:currency.code],
                             @"symbol"      : currency.symbol};
    
    _sessionManager.requestSerializer =  [AFJSONRequestSerializer serializer];
    [_sessionManager
     POST:[NSString stringWithFormat:@"/v1/currencies?access_token=%@",_accessToken.token ]
     parameters:params
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSCurrency* currency;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             currency = [[DSCurrency alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(currency);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
    
}


- (void) putCurrency:(DSCurrency*) currency onSuccess:(void(^)(DSCurrency* currency)) success
           onFailure:(void(^)(NSError* error)) failure {
    
    
    NSDictionary* params =@{@"name"        : currency.name,
                            @"shortName"   : currency.shortName,
                            @"code"        : [NSNumber numberWithInteger:currency.code],
                            @"symbol"      : currency.symbol};
    
    _sessionManager.requestSerializer =  [AFJSONRequestSerializer serializer];
    [_sessionManager
     PUT:[NSString stringWithFormat:@"/v1/currencies/%ld?access_token=%@",currency.obj_id,_accessToken.token]
     parameters:params
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSCurrency* currency;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             currency = [[DSCurrency alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(currency);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
    
}

- (void) deleteCurrency:(NSInteger) cur_id onSuccess:(void(^)(id success)) success
           onFailure:(void(^)(NSError* error)) failure {
    [_sessionManager
     DELETE:[NSString stringWithFormat:@"/v1/currencies/%ld" ,cur_id]
     parameters:@{@"access_token":_accessToken.token}
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         if (success) {
             success(@"success");
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
}
#pragma mark - orders

- (void) getOrdersOnSuccess:(void(^)(NSArray* orders)) success
                    onFailure:(void(^)(NSError* error)) failure {
    
    
    [_sessionManager
     GET:@"/v1/orders"
     parameters:@{@"access_token":_accessToken.token}
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         NSMutableArray* objectsArray = [NSMutableArray array];
         
         for (NSDictionary* dict in responseObject) {
             DSOrder* order = [[DSOrder alloc] initWithDictionary:dict];
             [objectsArray addObject:order];
         }
         
         if (success) {
             success(objectsArray);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
    
}

- (void) getOrder:(NSInteger) ord_id onSuccess:(void(^)(DSOrder* order)) success
        onFailure:(void(^)(NSError* error)) failure {
    [_sessionManager
     GET:[NSString stringWithFormat:@"/v1/orders/%ld", ord_id]
     parameters:@{@"access_token":_accessToken.token}
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         DSOrder* order;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             order = [[DSOrder alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(order);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
}

- (void) postOrder:(DSOrder*) order onSuccess:(void(^)(DSOrder* order)) success
            onFailure:(void(^)(NSError* error)) failure {
    
    
    NSDictionary* params = @{@"amount"     : [NSNumber numberWithDouble:[[NSDecimalNumber decimalNumberWithDecimal:order.amount] doubleValue]],
                             @"type"        : order.type == typeOrder ? @"ORDER" : @"TRANSFER_ORDER",
                             @"date"        : [NSNumber numberWithInteger:[order.date timeIntervalSince1970]],
                             @"contractor"  :@{@"id"  :[NSNumber numberWithInteger:order.con_id]},
                             @"account"     :@{@"id"  :[NSNumber numberWithInteger:order.acc_id]},
                             @"category"    :@{@"id"  :[NSNumber numberWithInteger:order.cat_id]}};
    
    _sessionManager.requestSerializer =  [AFJSONRequestSerializer serializer];
    [_sessionManager
     POST:[NSString stringWithFormat:@"/v1/orders?access_token=%@",_accessToken.token ]
     parameters:params
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSOrder* order;
         
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
             order = [[DSOrder alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(order);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
    
}

- (void) putOrder:(DSOrder*) order onSuccess:(void(^)(DSOrder* order)) success
                                    onFailure:(void(^)(NSError* error)) failure {
    
    
    NSDictionary* params = @{@"amount"     : [NSNumber numberWithDouble:[[NSDecimalNumber decimalNumberWithDecimal:order.amount] doubleValue]],
                             @"type"        : order.type == typeOrder ? @"ORDER" : @"TRANSFER_ORDER",
                             @"date"        : [NSNumber numberWithInteger:[order.date timeIntervalSince1970]],
                             @"contractor"  :@{@"id"  :[NSNumber numberWithInteger:order.con_id]},
                             @"account"     :@{@"id"  :[NSNumber numberWithInteger:order.acc_id]},
                             @"category"    :@{@"id"  :[NSNumber numberWithInteger:order.cat_id]}};

    
    _sessionManager.requestSerializer =  [AFJSONRequestSerializer serializer];
    [_sessionManager
     PUT:[NSString stringWithFormat:@"/v1/orders/%ld?access_token=%@",order.obj_id,_accessToken.token]
     parameters:params
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         DSOrder* order;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             order = [[DSOrder alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(order);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
}




- (void) deleteOrder:(NSInteger) ord_id onSuccess:(void(^)(id success)) success
          onFailure:(void(^)(NSError* error)) failure {
    [_sessionManager
     DELETE:[NSString stringWithFormat:@"/v1/orders/%ld", ord_id]
     parameters:@{@"access_token":_accessToken.token}
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         if (success) {
             success(@"success");
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
}


#pragma mark - users

- (void) getUsersOnSuccess:(void(^)(NSArray* users)) success
                    onFailure:(void(^)(NSError* error)) failure {
    
    
    [_sessionManager
     GET:@"/v1/users"
     parameters:@{@"access_token":_accessToken.token}
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         NSMutableArray* objectsArray = [NSMutableArray array];
         
         for (NSDictionary* dict in responseObject) {
             DSUser* user = [[DSUser alloc] initWithDictionary:dict];
             [objectsArray addObject:user];
         }
         
         if (success) {
             success(objectsArray);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
    
}

- (void) getUser:(NSInteger) usr_id onSuccess:(void(^)(DSUser* user)) success
                                onFailure:(void(^)(NSError* error)) failure {
    [_sessionManager
     GET:[NSString stringWithFormat:@"/v1/users/%ld", usr_id]
     parameters:@{@"access_token":_accessToken.token}
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         DSUser* user;
         
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
             user = [[DSUser alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(user);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
}



- (void) postUser:(DSUser*) user onSuccess:(void(^)(DSUser* user)) success
        onFailure:(void(^)(NSError* error)) failure {
    
    
    NSDictionary* params = @{@"name"     :user.name ,
                             @"role"     :user.role == userRole ? @"ROLE_USER" : @"ROLE_ADMIN",
                             @"password" :user.password};
    _sessionManager.requestSerializer =  [AFJSONRequestSerializer serializer];
    [_sessionManager
     POST:@"/v1/users"
     parameters:params
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSUser* user;
         
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
             user = [[DSUser alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(user);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
    
}

- (void) putUser:(DSUser*) user onSuccess:(void(^)(DSUser* user)) success
                                onFailure:(void(^)(NSError* error)) failure {
    
    
    NSDictionary* params = @{@"name"     :user.name ,
                             @"password" :user.password ,
                             @"role"     :user.role == userRole ? @"ROLE_USER" : @"ROLE_ADMIN"};
    
    _sessionManager.requestSerializer =  [AFJSONRequestSerializer serializer];
    [_sessionManager
     PUT:[NSString stringWithFormat:@"/v1/users/%ld?access_token=%@",user.obj_id,_accessToken.token]
     parameters:params
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSUser* user;
         
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
             user = [[DSUser alloc] initWithDictionary:responseObject];
         }
         
         if (success) {
             success(user);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
    
}

- (void) deleteUser:(NSInteger) usr_id onSuccess:(void(^)(id success)) success
                        onFailure:(void(^)(NSError* error)) failure {
    [_sessionManager
     DELETE:[NSString  stringWithFormat:@"/v1/users/%ld" , usr_id]
     parameters:@{@"access_token":_accessToken.token}
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         
         if (success) {
             success(@"success");
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
}

#pragma mark - token
- (void) getTokenForUser:(NSString *) userName andPassword:(NSString*) password onSuccess:(void(^)(DSAccessToken* token)) success     onFailure:(void(^)(NSError* error)) failure {
    
    
    NSDictionary* params = @{@"client_id"     : rest_id,
                             @"client_secret" : rest_key,
                             @"grant_type"    : @"password",
                             @"username"      : userName ,
                             @"password"      : password };
    
     _sessionManager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [_sessionManager
     POST:@"/oauth/token"
     parameters:params
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSAccessToken* token;
         
         if ([responseObject isKindOfClass:[NSDictionary class]]) {
             token = [[DSAccessToken alloc] initWithServerResponse:responseObject];
             _accessToken = token;
         }
         
         if (success) {
             success(token);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
     }];
    
}

- (void) refreshToken:(NSString*) token onSuccess:(void(^)(DSAccessToken* token)) success
                                        onFailure:(void(^)(NSError* error)) failure {
    
    
    NSDictionary* params = @{@"client_id"     : rest_id,
                             @"client_secret" : rest_key,
                             @"grant_type"    : @"refresh_token",
                             @"refresh_token" : token };
    
     _sessionManager.requestSerializer =  [AFHTTPRequestSerializer serializer];
    [_sessionManager
     POST:@"/oauth/token"
     parameters:params
     success:^(NSURLSessionDataTask *task, NSDictionary* responseObject) {
         NSLog(@"JSON: %@", responseObject);
         DSAccessToken* token;
         
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
             token = [[DSAccessToken alloc] initWithServerResponse:responseObject];
            _accessToken = token;
         }
         
         if (success) {
             success(token);
         }
         
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"Error: %@", error);
         
         if (failure) {
             failure(error);
         }
    
     }];
    
}


@end
