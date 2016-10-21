//
//  ViewController.m
//  XHHelper-OC
//
//  Created by vbn on 16/10/9.
//  Copyright © 2016年 vbn. All rights reserved.
//

#import "ViewController.h"
#import "XHPricePullService.h"
#import "XHHelper.h"
#import "XHListTableViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *priceList;

@property (strong, nonatomic) XHPriceModel *currentPrice;

@property (assign, nonatomic) BOOL oilCanNotification;

@property (assign, nonatomic) BOOL agCanNotification;

@property (strong, nonatomic) XHListTableViewController *listVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setup];
}

- (void)setup {
    
    self.priceList = @[].mutableCopy;
    
    XHPricePullService *service = [[XHPricePullService alloc] init];
    [service setFetchDataCallback:^(XHPriceModel *price,NSError *error) {
        if (!error) {
            self.currentPrice = price;
            CGFloat oilDiff = fabs(self.currentPrice.oilPrice - [self.oilTargetTextField.text floatValue]);
            CGFloat agDiff = fabs(self.currentPrice.agPrice - [self.agTargetTextField.text floatValue]);
            if (self.oilCanNotification && oilDiff <= 0.2) {
                NSString *message = [NSString stringWithFormat:@"油已到达目标点位%@",self.oilTargetTextField.text];
                [XHHelper sendLocalNotificationWithMessage:message date:[NSDate date]];
                self.oilCanNotification = NO;
                self.oilTargetTextField.enabled = YES;
                [self.oilNotificationSwicher setOn:NO];
            }
            if (self.agCanNotification && agDiff <= 0.002) {
                NSString *message = [NSString stringWithFormat:@"银已到达目标点位%@",self.agTargetTextField.text];
                [XHHelper sendLocalNotificationWithMessage:message date:[NSDate date]];
                self.agCanNotification = NO;
                self.agTargetTextField.enabled = YES;
                [self.agNotificationSwicher setOn:NO];
            }
            
            [self.priceList insertObject:price atIndex:0];
            if (self.priceList.count >= 99999) {
                [self.priceList removeLastObject];
            }
            [self renderUI];
        } else {
            [XHHelper toast:@"获取数据失败"];
        }
    }];
    [service startService];
}

- (void)renderUI {
    self.oilCurrentPriceLabel.text = [NSString stringWithFormat:@"%.2f",self.currentPrice.oilPrice];
    UIColor *color = [self.currentPrice getCurrentOilColor];
    if (color) {
        self.oilCurrentPriceLabel.textColor = color;
    }
    
    self.agCurrentPriceLabel.text = [NSString stringWithFormat:@"%.3f",self.currentPrice.agPrice];
    color = [self.currentPrice getCurrentAgColor];
    if (color) {
        self.agCurrentPriceLabel.textColor = color;
    }
}

- (IBAction)oilEnableChanged:(UISwitch *)sender {
    [self.view endEditing:YES];
    if (sender.isEnabled && [self.oilTargetTextField.text floatValue] != 0) {
        self.oilCanNotification = YES;
//        self.oilTargetTextField.enabled = NO;
    } else {
        self.oilCanNotification = NO;
//        self.oilTargetTextField.enabled = YES;
        [XHHelper removeAllLocalNotifications];
        [sender setOn:NO];
    }
}

- (IBAction)agEnableChanged:(UISwitch *)sender {
    [self.view endEditing:YES];
    if (sender.isEnabled && [self.agTargetTextField.text floatValue] != 0) {
        self.agCanNotification = YES;
//        self.agTargetTextField.enabled = NO;
    } else {
        self.agCanNotification = NO;
//        self.agTargetTextField.enabled = YES;
        [XHHelper removeAllLocalNotifications];
        [sender setOn:NO];
    }
}

- (IBAction)pushOilList:(id)sender {
    self.listVC = [[XHListTableViewController alloc] init];
    self.listVC.type =  1;
    self.listVC.list = self.priceList;
    [self.navigationController pushViewController:self.listVC animated:YES];
}

- (IBAction)pushAgList:(id)sender {
    self.listVC = [[XHListTableViewController alloc] init];
    self.listVC.type =  2;
    self.listVC.list = self.priceList;
    [self.navigationController pushViewController:self.listVC animated:YES];
}

#pragma mark - setter

- (void)setPriceList:(NSMutableArray *)priceList {
    _priceList = priceList;
    self.listVC.list = priceList;
}

@end
