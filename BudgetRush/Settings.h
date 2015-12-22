//
//  Settings.h
//  BudgetRush
//
//  Created by Dima Soldatenko on 12.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>


#define colorBackgroundBlue [UIColor colorWithRed:67/255.0f green:201/255.0f blue:226/255.f alpha:1.0f]
#define colorBackgroundWhite [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.f alpha:1.0f]
#define colorBlue [UIColor colorWithRed:28/255.0f green:113/255.0f blue:174/255.f alpha:1.0f]
#define colorRed [UIColor colorWithRed:228/255.0f green:58/255.0f blue:84/255.f alpha:1.0f]

#define colorBlueFont [UIColor colorWithRed:8/255.0f green:78/255.0f blue:127/255.f alpha:1.0f]
#define colorGreyFont [UIColor colorWithRed:79/255.0f green:79/255.0f blue:79/255.f alpha:1.0f]


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
