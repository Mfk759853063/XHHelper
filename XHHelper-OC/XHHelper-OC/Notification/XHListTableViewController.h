//
//  XHListTableViewController.h
//  XHHelper-OC
//
//  Created by vbn on 16/10/9.
//  Copyright © 2016年 vbn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHPriceModel.h"

@interface XHListTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *list;

// 1 is oil 2 is ag
@property (assign, nonatomic) NSInteger type;

@end
