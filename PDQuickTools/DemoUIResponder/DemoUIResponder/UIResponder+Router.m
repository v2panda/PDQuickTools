//
//  UIResponder+Router.m
//  DemoUIResponder
//
//  Created by Panda on 2017/7/28.
//  Copyright © 2017年 v2panda. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
