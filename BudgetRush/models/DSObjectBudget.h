//
//  DSObjectBudget.h
//  BudgetRush
//
//  Created by Dima Soladtenko on 08.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#warning: TODO: Не совсем удачное имя класса. Во-первых, лучше соблюдать последовательность "<тип или вид класса>-><сущность>", н-р, NSManagedModel (managed->model), UIAlertView и т.д. К тому же, это базовый класс для моделей. Думаю слово "Model" точно должно присутствовать.

@interface DSObjectBudget : NSObject

//TODO: Согласно конвенциям кодирования ничжнее подчеркивание в названиях свойств не применяется
@property (assign,nonatomic) NSInteger obj_id;

- (instancetype)initWithDictionary:(NSDictionary *) responseObject;

@end
