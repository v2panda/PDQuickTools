//
//  BaseNavigationController.h
//  PDScreenShotBackGesture
//
//  Created by Panda on 16/5/16.
//  Copyright © 2016年 v2panda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationController : UINavigationController

@property (strong ,nonatomic) NSMutableArray *arrayScreenshot;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@end
