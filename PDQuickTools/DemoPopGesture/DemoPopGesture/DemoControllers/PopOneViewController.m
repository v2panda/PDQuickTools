//
//  PopOneViewController.m
//  DemoPopGesture
//
//  Created by Panda on 15/12/14.
//  Copyright © 2015年 Panda. All rights reserved.
//

#import "PopOneViewController.h"
#import "UINavigationController+PDPopGesture.h"

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
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CGFLOAT_MIN * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIViewController *vc = [self.navigationController.viewControllers lastObject];
        if (!vc.pd_prefersNavigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO animated:NO];
        }
    });
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
