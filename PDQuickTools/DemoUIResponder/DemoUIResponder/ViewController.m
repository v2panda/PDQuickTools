//
//  ViewController.m
//  DemoUIResponder
//
//  Created by Panda on 2017/7/28.
//  Copyright © 2017年 v2panda. All rights reserved.
//

#import "ViewController.h"
#import "RHRiskResultCell.h"
#import "UIResponder+Router.h"

#import "ResponderChainHandle.h"

@interface ViewController ()<
UITableViewDataSource,
UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ResponderChainHandle *eventProxy;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}


- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    /*
     do things you want
     */
    NSLog(@"eventName : %@-%@",eventName,userInfo);
    
    [self.eventProxy handleEvent:eventName userInfo:userInfo];

    // 如果需要让事件继续往上传递，则调用下面的语句
    // [super routerEventWithName:eventName userInfo:userInfo];
}

#pragma mark UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RHRiskResultCell *cell = [RHRiskResultCell cellWithTableView:tableView];
    cell.fromVCs = self.navigationController.viewControllers;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 440;
}

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
@end
