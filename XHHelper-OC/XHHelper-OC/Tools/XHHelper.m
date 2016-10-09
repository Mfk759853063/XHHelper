//
//  HZHelper.m
//  HZDLHuiXianXia
//
//  Created by hzdlapple2 on 15/4/8.
//  Copyright (c) 2015年 hzdlapple2. All rights reserved.
//

#import "XHHelper.h"
#import "MBProgressHUD.h"
#include <sys/types.h>

#include <sys/sysctl.h>
@implementation XHHelper
#pragma mark - Common
+ (UIWindow *) mainWindow{
    return [[[UIApplication sharedApplication] delegate] window];
//    return [[UIApplication sharedApplication]keyWindow];
}

+ (AppDelegate *)delegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark - GCD

+ (void)runInMainQueue:(void (^)())queue{
    dispatch_async(dispatch_get_main_queue(), queue);
}

+ (void)runInGlobalQueue:(void (^)())queue{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), queue);
}

+ (void)runAfterSecs:(float)secs block:(void (^)())block{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, secs*NSEC_PER_SEC), dispatch_get_main_queue(), block);
}

#pragma mark - Hud

+ (void)showHudWithDuration:(NSString *)message{
    [XHHelper runInMainQueue:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:XHHelper.mainWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = message;
        double delayInSeconds = 1.6;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideAllHUDsForView:XHHelper.mainWindow animated:YES];
        });
    }];
    
}

+ (void)toast:(NSString *)message{
    [XHHelper runInMainQueue:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:XHHelper.mainWindow animated:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:hud action:@selector(removeFromSuperview)];
        [hud addGestureRecognizer:tap];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = message;
        double delayInSeconds = 1.6;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideAllHUDsForView:XHHelper.mainWindow animated:YES];
        });
    }];
    
}

+ (void)toast:(NSString *)message block:(void (^)())block{
    [XHHelper runInMainQueue:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:XHHelper.mainWindow animated:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:hud action:@selector(removeFromSuperview)];
        [hud addGestureRecognizer:tap];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = message;
        double delayInSeconds = 1.6f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideAllHUDsForView:XHHelper.mainWindow animated:YES];
            if(block){
                block();
            }
        });
    }];
}

+ (void)toastLongMessage:(NSString *)message block:(void (^)())block{
    [XHHelper runInMainQueue:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:XHHelper.mainWindow animated:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:hud action:@selector(removeFromSuperview)];
        [hud addGestureRecognizer:tap];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = message;
        double delayInSeconds = 1.6f;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideAllHUDsForView:XHHelper.mainWindow animated:YES];
            if(block){
                block();
            }
        });
    }];
}

+ (void)showHudWithDuration:(NSString *)message :(double)delay{
    [XHHelper runInMainQueue:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:XHHelper.mainWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = message;
        double delayInSeconds = delay;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideAllHUDsForView:XHHelper.mainWindow animated:YES];
        });
    }];
}


+ (void)showHud:(NSString *)message{
    [XHHelper runInMainQueue:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:XHHelper.mainWindow animated:YES];
        hud.labelText = message;
    }];
}

+ (void)showHud:(NSString *)message inView:(UIView *)view{
    [XHHelper runInMainQueue:^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.labelText = message;
    }];
}

+ (void)hideHud{
    [XHHelper runInMainQueue:^{
        [MBProgressHUD hideAllHUDsForView:XHHelper.mainWindow animated:YES];
    }];
}

+(void)hideHudFromView:(UIView*)view{
    [XHHelper runInMainQueue:^{
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
    }];
}


+ (void)hideHudblock:(void (^)())block{
    [XHHelper runInGlobalQueue:^{
        [MBProgressHUD hideAllHUDsForView:XHHelper.mainWindow animated:YES];
        [XHHelper runInMainQueue:^{
            block();
        }];
    }];
    
}

+ (NSString *)getCurrentDeviceMomdel{
    //NSString * strModel  = [UIDevice currentDevice].model 
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    NSString *totle = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    return  totle;
}

+ (BOOL)isIPhone6Plus{
    if ([[self getCurrentDeviceMomdel]isEqualToString:@"iPhone7,1"]) {
        return YES;
    }else{
        return NO;
    }
    return YES;
}

+ (void)removeAllLocalNotifications {
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        [app cancelLocalNotification:oneEvent];
    }
}

+ (void)sendLocalNotificationWithMessage:(NSString *)message date:(NSDate *)date {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification) {
        notification.timeZone = [NSTimeZone defaultTimeZone]; // 使用本地时区
        notification.fireDate = [date dateByAddingTimeInterval:2];
        
        // 设置重复间隔
        notification.repeatInterval = 0;
        
        // 设置提醒的文字内容
        notification.alertBody   = message;
        notification.alertAction = @"确定";
        
        // 通知提示音 使用默认的
        notification.soundName= UILocalNotificationDefaultSoundName;
        // 将通知添加到系统中
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];  
    }
}
@end
