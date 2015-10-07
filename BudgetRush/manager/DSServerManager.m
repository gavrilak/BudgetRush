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

#warning FIX: Почему бы просто не использовать ivars? Зачем здесь именно свойства?
#warning TODO: Попробуй поработать с AFHTTPSessionManager
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
#warning FIX: Рекомендую создать файл настроек и вынести API URL туда
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://"]];
        
    }
    
    return self;
}

@end
