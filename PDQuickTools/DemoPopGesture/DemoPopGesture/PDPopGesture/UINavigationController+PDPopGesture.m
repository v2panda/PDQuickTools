//
//  UINavigationController+PDPopGesture.m
//  DemoPopGesture
//
//  Created by Panda on 15/12/13.
//  Copyright © 2015年 Panda. All rights reserved.
//

#import "UINavigationController+PDPopGesture.h"
#import <objc/runtime.h>

#pragma mark - _PDPopGestureRecognizerDelegate
@interface _PDPopGestureRecognizerDelegate : NSObject <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UINavigationController *navigationController;

@end

@implementation _PDPopGestureRecognizerDelegate
/**
 *  设置手势执行的条件
 *
 *  @param gestureRecognizer UIPanGestureRecognizer
 *
 *  @return BOOL
 */
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    // 当为根控制器时手势不执行
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    
    // 设置页面是否显示手势 默认NO
    UIViewController *topViewController = self.navigationController.viewControllers.lastObject;
    if (topViewController.pd_interactivePopDisabled) {
        return NO;
    }
    
    // 手势滑动距左边框距离超过maxAllowedInitialDistance 手势不执行
    CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGFloat maxAllowedInitialDistance = topViewController.pd_interactivePopMaxAllowedInitialDistanceToLeftEdge;
    if (maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance) {
        return NO;
    }
    
    // 当push、pop动画时，手势不执行
    if ([[self.navigationController valueForKey:@"_isTransitioning"]boolValue]) {
        return NO;
    }
    
    // 向左(反方向)拖动，手势不执行
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    return YES;
}

@end

#pragma mark - UIViewController (PDPopGesturePrivate)
typedef void (^_PDViewControllerWillAppearInjectBlock)(UIViewController *viewController, BOOL animated);

@interface UIViewController (PDPopGesturePrivate)

@property (nonatomic, copy) _PDViewControllerWillAppearInjectBlock pd_willAppearInjectBlock;

@end

@implementation UIViewController (PDPopGesturePrivate)
/**
 *  Method Swizzling替换viewWillAppear
 */
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(pd_viewWillAppear:);
        // 从类中取方法
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        /*
            检查pd_viewWillAppear方法是否存在
            若存在,则class_addMethod返回失败,调用method_exchangeImplementations
         */
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            //  addMethod会让目标类的方法指向新的实现，使用replaceMethod再将新的方法指向原先的实现，这样就完成了交换操作
            //  后面的方法替换前面的方法
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else{
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)pd_viewWillAppear:(BOOL)animated
{
    [self pd_viewWillAppear:animated];
    if (self.pd_willAppearInjectBlock) {
        self.pd_willAppearInjectBlock(self,animated);
    }
}
/**
 *  pd_willAppearInjectBlock的setter&getter
 */
- (_PDViewControllerWillAppearInjectBlock)pd_willAppearInjectBlock
{
    // _cmd表示当前方法的Selector
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setPd_willAppearInjectBlock:(_PDViewControllerWillAppearInjectBlock)pd_willAppearInjectBlock
{
    // 将self(类本身)与pd_willAppearInjectBlock关联到一起
    objc_setAssociatedObject(self, @selector(pd_willAppearInjectBlock), pd_willAppearInjectBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end


#pragma mark - UINavigationController和UIViewController分类的实现
@implementation UINavigationController (PDPopGesture)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        Class class = [self class];
        
        SEL originalSelector = @selector(pushViewController:animated:);
        SEL swizzledSelector = @selector(pd_pushViewController:animated:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)pd_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //  判断pd_fullscreenPopGestureRecognizer是否在UINavigationController的gestureRecognizers的数组中
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.pd_popGestureRecognizer]) {
        // 替换自定义的侧滑手势
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.pd_popGestureRecognizer];
        /*
         新建一个UIPanGestureRecognizer，让它的触发和系统的这个手势相同，
         这就需要利用runtime获取系统手势的target和action。
         */
        //  用KVC取出target和action
        NSArray *internalTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        
        //  将自定义的代理（手势执行条件）传给手势的delegate
        self.pd_popGestureRecognizer.delegate = self.pd_popGestureRecognizerDelegate;
        //  将target和action传给手势
        [self.pd_popGestureRecognizer addTarget:internalTarget action:internalAction];
        
        //  关闭系统的返回 设置为NO
        self.interactivePopGestureRecognizer.enabled = NO;
        
    }
    //  设置是否需要显示navigation bar
    [self pd_setupViewControllerBasedNavigationBarAppearanceIfNeeded:viewController];
    
    //  执行原本的方法
    if (![self.viewControllers containsObject:viewController]) {
        [self pd_pushViewController:viewController animated:animated];
    }
}

- (void)pd_setupViewControllerBasedNavigationBarAppearanceIfNeeded:(UIViewController *)appearingViewController
{
    //  默认是YES
    if (!self.pd_viewControllerBasedNavigationBarAppearanceEnabled) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    _PDViewControllerWillAppearInjectBlock block = ^(UIViewController *viewController, BOOL animated) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            
            [strongSelf setNavigationBarHidden:viewController.pd_prefersNavigationBarHidden animated:animated];
        }
    };
    
    
    //  前面定义的ViewController私有的Category添加的属性block
    appearingViewController.pd_willAppearInjectBlock = block;
    UIViewController *disappearingViewController = self.viewControllers.lastObject;
    if (disappearingViewController && !disappearingViewController.pd_willAppearInjectBlock) {
        disappearingViewController.pd_willAppearInjectBlock = block;
    }
}

//  隐式声明 只写了get方法
- (_PDPopGestureRecognizerDelegate *)pd_popGestureRecognizerDelegate
{
    _PDPopGestureRecognizerDelegate *delegate = objc_getAssociatedObject(self, _cmd);
    
    if (!delegate) {
        delegate = [[_PDPopGestureRecognizerDelegate alloc] init];
        delegate.navigationController = self;
        //  设置self(UINavigationController)和delegate关联
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}

// get set方法
- (UIPanGestureRecognizer *)pd_popGestureRecognizer
{
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    
    if (!panGestureRecognizer) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        
        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGestureRecognizer;
}

- (BOOL)pd_viewControllerBasedNavigationBarAppearanceEnabled
{
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) {
        return number.boolValue;
    }
    self.pd_viewControllerBasedNavigationBarAppearanceEnabled = YES;
    return YES;
}

- (void)setPd_viewControllerBasedNavigationBarAppearanceEnabled:(BOOL)enabled
{
    SEL key = @selector(pd_viewControllerBasedNavigationBarAppearanceEnabled);
    objc_setAssociatedObject(self, key, @(enabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


@implementation UIViewController (PDPopGesture)
- (BOOL)pd_interactivePopDisabled
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setPd_interactivePopDisabled:(BOOL)disabled
{
    objc_setAssociatedObject(self, @selector(pd_interactivePopDisabled), @(disabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pd_prefersNavigationBarHidden
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setPd_prefersNavigationBarHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, @selector(pd_prefersNavigationBarHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGFloat)pd_interactivePopMaxAllowedInitialDistanceToLeftEdge
{
#if CGFLOAT_IS_DOUBLE
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
#else
    return [objc_getAssociatedObject(self, _cmd) floatValue];
#endif
}

- (void)setPd_interactivePopMaxAllowedInitialDistanceToLeftEdge:(CGFloat)distance
{
    SEL key = @selector(pd_interactivePopMaxAllowedInitialDistanceToLeftEdge);
    objc_setAssociatedObject(self, key, @(MAX(0, distance)), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end