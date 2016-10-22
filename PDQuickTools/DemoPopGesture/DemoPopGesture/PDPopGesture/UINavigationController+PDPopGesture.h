//
//  UINavigationController+PDPopGesture.h
//  DemoPopGesture
//
//  Created by Panda on 15/12/13.
//  Copyright © 2015年 Panda. All rights reserved.
//
//  自定义全局侧滑返回手势

#import <UIKit/UIKit.h>

@interface UINavigationController (PDPopGesture)

/**
 *  自定义侧滑返回手势
 */
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *pd_popGestureRecognizer;

/// A view controller is able to control navigation bar's appearance by itself,
/// rather than a global way, checking "pd_prefersNavigationBarHidden" property.
/// Default to YES, disable it if you don't want so.
@property (nonatomic, assign) BOOL pd_viewControllerBasedNavigationBarAppearanceEnabled;
@end


@interface UIViewController (PDPopGesture)
/**
 *  是否显示此手势  默认:NO
 */
@property (nonatomic, assign) BOOL pd_interactivePopDisabled;

/// Indicate this view controller prefers its navigation bar hidden or not,
/// checked when view controller based navigation bar's appearance is enabled.
/// Default to NO, bars are more likely to show.
@property (nonatomic, assign) BOOL pd_prefersNavigationBarHidden;

/// Max allowed initial distance to left edge when you begin the interactive pop
/// gesture. 0 by default, which means it will ignore this limit.
@property (nonatomic, assign) CGFloat pd_interactivePopMaxAllowedInitialDistanceToLeftEdge;

@end