//
//  XHPriceModel.m
//  XHHelper-OC
//
//  Created by vbn on 16/10/9.
//  Copyright © 2016年 vbn. All rights reserved.
//

#import "XHPriceModel.h"

@implementation XHPriceModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"oilPrice":@[@"oil_price"],
             @"oldOilPrice":@[@"last_oil_price"],
             @"agPrice":@[@"ag_price"],
             @"oldAgPrice":@[@"last_ag_price"]};
}

- (UIColor *)getCurrentAgColor {
    if (self.agPrice < self.oldAgPrice ) {
        return [UIColor greenColor];
    } else if (self.agPrice > self.oldAgPrice ) {
        return [UIColor redColor];
    }
    return [UIColor redColor];
}

- (UIColor *)getCurrentOilColor {
    if (self.oilPrice < self.oldOilPrice ) {
        return [UIColor greenColor];
    } else if (self.oilPrice > self.oldOilPrice ) {
        return [UIColor redColor];
    }
    return [UIColor redColor];
}


@end
