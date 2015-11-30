//
//  Settings.h
//  BudgetRush
//
//  Created by Dima Soldatenko on 12.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const rest_id = @"ios_id";
static NSString *const rest_key = @"ios_key";

static NSString *const kUserName = @"kUserName";
static NSString *const kUserPass = @"kUserPass";


static NSString *const PVURLProtocol = @"https";
#ifdef RELEASE
static NSString *const PVServerURL = @"";
#else
static NSString *const PVServerURL = @"46.101.220.157";
#endif
static NSString *const PVServerPort =@"9443";
static NSString *const PVAPIPath = @"/v1/";
