//
//  UIButton+PDTouches.h
//  DemoMutiButtonTouched
//
//  Created by Panda on 16/9/13.
//  Copyright © 2016年 v2panda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (PDTouches)

/**
 *  设置按钮 - 点击间隔时间 默认为0.5秒
 */
@property (nonatomic, assign) NSTimeInterval custom_acceptEventInterval;
/**
 *  设置按钮 - 启用点击检测
 */
@property (nonatomic, assign) BOOL isCheckTouches;

@end
