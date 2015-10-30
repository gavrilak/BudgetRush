//
//  DSAccessToken.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSBaseModel.h"


@interface DSAccessToken : DSBaseModel

@property (strong, nonatomic) NSString* token;
@property (strong, nonatomic) NSString* refreshToken;
@property (strong, nonatomic) NSDate* expirationDate;


- (id) initWithServerResponse:(NSDictionary*) responseObject;

@end

