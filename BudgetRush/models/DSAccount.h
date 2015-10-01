//
//  DSAccount.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSAccount : NSObject

@property (assign,nonatomic) NSInteger ac_id;
@property (strong,nonatomic) NSString *name;
@property (assign,nonatomic) NSInteger user_id;
@property (assign,nonatomic) NSInteger currency_id;


- (instancetype)initWithDictionary:(NSDictionary *) responseObject;

@end
