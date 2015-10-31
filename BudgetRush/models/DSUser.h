//
//  DSUser.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSBaseModel.h"

enum userRole : NSUInteger {
    userRole , adminRole
};

@interface DSUser : DSBaseModel

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *password;
@property (assign,nonatomic) enum userRole role;

- (instancetype)initWithDictionary:(NSDictionary *) responseObject;

@end