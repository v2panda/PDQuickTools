//
//  UIResponder+Router.h
//  DemoUIResponder
//
//  Created by Panda on 2017/7/28.
//  Copyright © 2017年 v2panda. All rights reserved.
//

/**
    一种基于ResponderChain的对象交互方式
    地址：https://casatwy.com/responder_chain_communication.html
*/

#import <UIKit/UIKit.h>

@interface UIResponder (Router)
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;
@end
