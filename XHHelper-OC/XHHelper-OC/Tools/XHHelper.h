//
//  HZHelper.h
//  HZDLHuiXianXia
//
//  Created by hzdlapple2 on 15/4/8.
//  Copyright (c) 2015年 hzdlapple2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface XHHelper : NSObject
+ (UIWindow *) mainWindow;

+ (AppDelegate *)delegate;
/**
 *  在main_queue中执行 queue block
 *
 */
+ (void)runInMainQueue:(void (^)())queue;

/**
 *  在global_queue中执行 queue block
 *
 */
+ (void)runInGlobalQueue:(void (^)())queue;

/**
 *  在main_queue中延时操作
 */
+ (void)runAfterSecs:(float)secs block:(void (^)())block;

+ (void)showHud:(NSString *)message inView:(UIView *)view;
+ (void)showHudWithDuration:(NSString *)message :(double)delay;
+ (void)showHudWithDuration:(NSString *)message __attribute__((deprecated("Use +toast: instead")));
+(void)hideHudFromView:(UIView*)view;
+ (void)toast:(NSString *)message;
+ (void)toast:(NSString *)message block:(void (^)())block;
+ (void)toastLongMessage:(NSString *)message block:(void (^)())block;
+ (void)showHud:(NSString *)message;
+ (void)hideHud;

+ (void)removeAllLocalNotifications;

+ (void)sendLocalNotificationWithMessage:(NSString *)message date:(NSDate *)date;

/**
 *  iPhone6plus
 *
 *  @return 是否
 */
+ (BOOL)isIPhone6Plus;
@end
