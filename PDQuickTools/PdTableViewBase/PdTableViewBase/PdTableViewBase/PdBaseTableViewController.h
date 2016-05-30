//
//  PdBaseTableViewController.h
//  PdTableViewBase
//
//  Created by Panda on 16/5/25.
//  Copyright © 2016年 v2panda. All rights reserved.
//
/**
 *  TableViewController 基础类
 */
#import <UIKit/UIKit.h>
#import "PdBaseTableView.h"

@class PdTableViewDataSource;

@protocol PdBaseTableViewControllerDelegate <NSObject>

@required
- (void)createDataSource;

@end



// 可继承自定义基类
@interface PdBaseTableViewController : UIViewController <PdBaseTableViewDelegate, PdBaseTableViewControllerDelegate>

@property (nonatomic, strong) PdBaseTableView *tableView;
@property (nonatomic, strong) PdTableViewDataSource *dataSource;
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

@end
