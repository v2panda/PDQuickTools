//
//  ResponderChainHandle.m
//  DemoUIResponder
//
//  Created by Panda on 2017/8/3.
//  Copyright © 2017年 v2panda. All rights reserved.
//

#import "ResponderChainHandle.h"
#import "RHRiskResultCell.h"

@interface ResponderChainHandle ()

@property (nonatomic, strong) NSDictionary *eventStrategy;

@end

@implementation ResponderChainHandle

- (void)handleEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    NSInvocation *invocation = self.eventStrategy[eventName];
    [invocation setArgument:&userInfo atIndex:2];
    [invocation invoke];
}

- (NSInvocation *)createInvocationWithSelector:(SEL)selector {
    
    NSMethodSignature  *signature = [[self class] instanceMethodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    //设置方法调用者
    invocation.target = self;
    //注意：这里的方法名一定要与方法签名类中的方法一致
    invocation.selector = selector;
    
    //    NSString *way = @"byCar";
    //这里的Index要从2开始，以为0跟1已经被占据了，分别是self（target）,selector(_cmd)
    //    [invocation setArgument:&way atIndex:2];
    //3、调用invoke方法
    //    [invocation invoke];
    
    return invocation;
}

- (void)docontinueButton:(NSDictionary *)dic {
    NSLog(@"docontinueButton- %@",dic);
}

- (void)docontinueButton2:(NSDictionary *)dic {
    NSLog(@"docontinueButton2- %@",dic);
}

- (NSDictionary <NSString *, NSInvocation *> *)eventStrategy {
    if (_eventStrategy == nil) {
        _eventStrategy = @{
                           kBLGoodsDetailTicketEvent:[self createInvocationWithSelector:@selector(docontinueButton:)],
                           kBLGoodsDetailPromotionEvent:[self createInvocationWithSelector:@selector(docontinueButton2:)]
                           };
    }
    return _eventStrategy;
}
@end
