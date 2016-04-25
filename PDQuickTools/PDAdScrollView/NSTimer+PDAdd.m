//
//  NSTimer+PDAdd.m
//  RHNewAdScrollView
//
//  Created by Panda on 16/4/25.
//  Copyright © 2016年 v2panda. All rights reserved.
//

#import "NSTimer+PDAdd.h"

@implementation NSTimer (PDAdd)
-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}

-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

- (void)stopTimer
{
    if ([self isValid]) {
        [self invalidate];
    }
}

@end
