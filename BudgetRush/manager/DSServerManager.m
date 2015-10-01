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
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://"]];
        
    }
    
    return self;
}

@end
