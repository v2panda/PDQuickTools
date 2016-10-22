//
//  PopOneViewController.m
//  DemoPopGesture
//
//  Created by Panda on 15/12/14.
//  Copyright © 2015年 Panda. All rights reserved.
//

#import "PopOneViewController.h"

@interface PopOneViewController ()

@end

@implementation PopOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 替换系统侧滑返回
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
