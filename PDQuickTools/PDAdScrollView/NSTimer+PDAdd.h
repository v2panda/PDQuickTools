//
//  NSTimer+PDAdd.h
//  RHNewAdScrollView
//
//  Created by Panda on 16/4/25.
//  Copyright © 2016年 v2panda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (PDAdd)
- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
- (void)stopTimer;
@end
