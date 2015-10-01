//
//  DSCategory.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSCategory : NSObject

@property (assign,nonatomic) NSInteger cat_id;
@property (strong,nonatomic) NSString *name;
@property (assign,nonatomic) NSInteger parent;


- (instancetype)initWithDictionary:(NSDictionary *) responseObject;


@end
