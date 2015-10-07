//
//  DSServerManager.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#warning //FIX: Не стоит эти импорты размещать здесь. Как следствие, все эти модели будут доступны всем, кто заимпортит данный хедер
#import "DSAccount.h"
#import "DSCategory.h"
#import "DSContractor.h"
#import "DSCurrency.h"
#import "DSOrder.h"
#import "DSUser.h"
#import "DSAccessToken.h"

@interface DSServerManager : NSObject

+ (DSServerManager *)sharedManager;

@end
