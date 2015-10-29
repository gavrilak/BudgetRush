//
//  Settings.h
//  BudgetRush
//
//  Created by Dima Soladtenko on 12.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *const rest_id = @"ios_id";
NSString *const rest_key = @"ios_key";

#warning TODO: Я бы разделил протокол, порт, аддресс на разные константы. На практике часто приходится собирать сборки, которые работают с разными серверами. Легче будет переключаться
#warning TODO: Например,

//static NSString *const PVURLProtocol = @"https";
//#ifdef RELEASE
//static NSString *const PVServerURL = @"apple.com";
//#else
//static NSString *const PVServerURL = @"google.com";
//#endif
//static NSString *const PVAPIPath = @"/v1/";

NSString *const baseUrl = @"https://46.101.220.157:9443";