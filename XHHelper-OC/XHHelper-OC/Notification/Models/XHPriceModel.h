//
//  XHPriceModel.h
//  XHHelper-OC
//
//  Created by vbn on 16/10/9.
//  Copyright © 2016年 vbn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import <UIKit/UIKit.h>

@interface XHPriceModel : NSObject

@property (assign, nonatomic) float oilPrice;

@property (assign, nonatomic) float oldOilPrice;

@property (assign, nonatomic) float agPrice;

@property (assign, nonatomic) float oldAgPrice;

- (UIColor *)getCurrentOilColor;

- (UIColor *)getCurrentAgColor;

@end
