//
//  TabBarViewController.m
//  PDScreenShotBackGesture
//
//  Created by Panda on 16/5/16.
//  Copyright © 2016年 v2panda. All rights reserved.
//

#import "TabBarViewController.h"
#import "RecommendViewController.h"
#import "BaseNavigationController.h"


@interface TabBarViewController ()

@end
#define RGB(r, g, b)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.opaque = NO;
    self.tabBar.tintColor = RGB(244, 89, 27);
    [self initChildViewControllers];
    
}

- (void)initChildViewControllers
{
    NSMutableArray *childVCArray = [[NSMutableArray alloc] initWithCapacity:4];
    
    RecommendViewController *mainVC = [[RecommendViewController alloc] init];
    mainVC.navigationItem.title = @"推荐";
    [mainVC.tabBarItem setTitle:@"推荐"];
    [mainVC.tabBarItem setImage:[UIImage imageNamed:@"推荐未选中"]];
    [mainVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"推荐选中"]];
    BaseNavigationController *mainNavC = [[BaseNavigationController alloc] initWithRootViewController:mainVC];
    [childVCArray addObject:mainNavC];
    
    self.viewControllers = childVCArray;
    
}




@end
