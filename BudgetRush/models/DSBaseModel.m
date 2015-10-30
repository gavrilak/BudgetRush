//
//  DSBaseModel.m
//  BudgetRush
//
//  Created by Dima Soladtenko on 08.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import "DSBaseModel.h"

@implementation DSBaseModel

- (instancetype)initWithDictionary:(NSDictionary *) responseObject {
    
    self = [super init];
    if (self) {
        self.ident = [[responseObject objectForKey:@"id"]integerValue] ;
    }
    return self;
    
}
@end
