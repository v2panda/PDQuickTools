//
//  ViewController.m
//  DemoPopGesture
//
//  Created by Panda on 15/12/13.
//  Copyright © 2015年 Panda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"23781-200"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self.navigationItem setBackBarButtonItem:backItem];

}


@end
