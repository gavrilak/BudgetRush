//
//  DSAccount.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#warning TODO: Рекомендую создать базовый класс для всех моделей, определить там метод initWithDictionary: где можно также реализовать парсинг id, так как данное поле присутствует в каждой dto
@interface DSAccount : NSObject

@property (assign,nonatomic) NSInteger ac_id;
@property (strong,nonatomic) NSString *name;
@property (assign,nonatomic) NSInteger user_id;
@property (assign,nonatomic) NSInteger currency_id;


- (instancetype)initWithDictionary:(NSDictionary *) responseObject;

@end
