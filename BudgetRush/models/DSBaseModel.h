//
//  DSBaseModel.h
//  BudgetRush
//
//  Created by Dima Soladtenko on 08.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DSBaseModel : NSObject

@property (assign,nonatomic) NSInteger ident;

- (instancetype)initWithDictionary:(NSDictionary *) responseObject;

@end

