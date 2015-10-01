//
//  DSServerManager.h
//  BudgetRush
//
//  Created by Dima on 01.10.15.
//  Copyright © 2015 Dima Soldatenko. All rights reserved.
//

#import <Foundation/Foundation.h>
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
