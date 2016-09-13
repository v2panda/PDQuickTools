//
//  UIButton+PDTouches.m
//  DemoMutiButtonTouched
//
//  Created by Panda on 16/9/13.
//  Copyright © 2016年 v2panda. All rights reserved.
//

#import "UIButton+PDTouches.h"
#import <objc/runtime.h>

@interface UIButton()
@property (nonatomic, assign) NSTimeInterval custom_acceptEventTime;
@end

@implementation UIButton (PDTouches)
+ (void)load{
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    
    Method customMethod = class_getInstanceMethod(self, @selector(custom_sendAction:to:forEvent:));
    SEL customSEL = @selector(custom_sendAction:to:forEvent:);
    
    //添加方法 语法：BOOL class_addMethod(Class cls, SEL name, IMP imp, const char *types) 若添加成功则返回No
    // cls：被添加方法的类  name：被添加方法方法名  imp：被添加方法的实现函数  types：被添加方法的实现函数的返回值类型和参数类型的字符串
    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(customMethod), method_getTypeEncoding(customMethod));
    
    //如果系统中该方法已经存在了，则替换系统的方法  语法：IMP class_replaceMethod(Class cls, SEL name, IMP imp,const char *types)
    if (didAddMethod) {
        class_replaceMethod(self, customSEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(systemMethod, customMethod);
        
    }
}

- (NSTimeInterval )custom_acceptEventInterval{
    return [objc_getAssociatedObject(self, "UIControl_acceptEventInterval") doubleValue];
}

- (void)setCustom_acceptEventInterval:(NSTimeInterval)custom_acceptEventInterval{
    objc_setAssociatedObject(self, "UIControl_acceptEventInterval", @(custom_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval )custom_acceptEventTime{
    return [objc_getAssociatedObject(self, "UIControl_acceptEventTime") doubleValue];
}

- (void)setCustom_acceptEventTime:(NSTimeInterval)custom_acceptEventTime{
    objc_setAssociatedObject(self, "UIControl_acceptEventTime", @(custom_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setIsCheckTouches:(BOOL)isCheckTouches{

    objc_setAssociatedObject(self, @selector(isCheckTouches), @(isCheckTouches), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isCheckTouches{
    //_cmd == @select(isIgnore); 和set方法里一致
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)custom_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if (!self.isCheckTouches) {
        //不需要被hook
        [self custom_sendAction:action to:target forEvent:event];
        return;
    }
    
     if (self.custom_acceptEventInterval <= 0) {
         // 如果没有自定义时间间隔，则默认为0.5秒
        self.custom_acceptEventInterval = 0.5;
     }
    
    // 是否小于设定的时间间隔
    BOOL needSendAction = (NSDate.date.timeIntervalSince1970 - self.custom_acceptEventTime >= self.custom_acceptEventInterval);
    
    // 更新上一次点击时间戳
    if (self.custom_acceptEventInterval > 0) {
        self.custom_acceptEventTime = NSDate.date.timeIntervalSince1970;
    }
    
    // 两次点击的时间间隔小于设定的时间间隔时，才执行响应事件
    if (needSendAction) {
        [self custom_sendAction:action to:target forEvent:event];
    }
    
}
@end
