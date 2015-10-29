//
//  DSAccessToken.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#warning TODO: Почему данный класс не может быть наследован от DSObjectBudget? 

@interface DSAccessToken : NSObject

@property (strong, nonatomic) NSString* token;
@property (strong, nonatomic) NSString* refreshToken;
@property (strong, nonatomic) NSDate* expirationDate;


- (id) initWithServerResponse:(NSDictionary*) responseObject;

@end
