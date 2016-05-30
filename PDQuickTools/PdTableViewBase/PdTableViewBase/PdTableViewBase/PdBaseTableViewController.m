//
//  PdBaseTableViewController.m
//  PdTableViewBase
//
//  Created by Panda on 16/5/25.
//  Copyright © 2016年 v2panda. All rights reserved.
//

#import "PdBaseTableViewController.h"

@interface PdBaseTableViewController ()

@end

@implementation PdBaseTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createDataSource];
    }
    return self;
}

// 这个方法实际上要被子类重写，生成对应类型的 data source
- (void)createDataSource {
    @throw [NSException exceptionWithName:@"Cann't use this method"
                                   reason:@"You can only call this method in subclass"
                                 userInfo:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
}

- (void)createTableView {
    if (!self.tableView) {
        self.tableView = [[PdBaseTableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
        self.tableView.pdDelegate = self;
        self.tableView.pdDataSource = self.dataSource;
        [self.view addSubview:self.tableView];
    }
}



@end
