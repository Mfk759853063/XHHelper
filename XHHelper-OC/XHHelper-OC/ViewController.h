//
//  ViewController.h
//  XHHelper-OC
//
//  Created by vbn on 16/10/9.
//  Copyright © 2016年 vbn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *oilCurrentPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *agCurrentPriceLabel;

@property (weak, nonatomic) IBOutlet UITextField *oilTargetTextField;

@property (weak, nonatomic) IBOutlet UITextField *agTargetTextField;

@property (weak, nonatomic) IBOutlet UISwitch *oilNotificationSwicher;

@property (weak, nonatomic) IBOutlet UISwitch *agNotificationSwicher;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)oilEnableChanged:(id)sender;

- (IBAction)agEnableChanged:(id)sender;

- (IBAction)pushOilList:(id)sender;

- (IBAction)pushAgList:(id)sender;
@end

