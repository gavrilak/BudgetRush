//
//  DSContractor.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSContractor : NSObject

@property (assign,nonatomic) NSInteger con_id;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *descr;

- (instancetype)initWithDictionary:(NSDictionary *) responseObject;

@end
