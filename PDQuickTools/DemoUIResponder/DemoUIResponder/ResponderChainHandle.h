//
//  ResponderChainHandle.h
//  DemoUIResponder
//
//  Created by Panda on 2017/8/3.
//  Copyright © 2017年 v2panda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponderChainHandle : NSObject

- (void)handleEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end
