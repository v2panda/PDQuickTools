//
//  PDAdScrollView.h
//  RHNewAdScrollView
//
//  Created by Panda on 16/4/25.
//  Copyright © 2016年 v2panda. All rights reserved.
//

#import <UIKit/UIKit.h>

// 依赖SDWebImage
@interface PDAdScrollView : UIView
/**
 *  支持三种类型
 *  URL(String) & NSString(ImageName) & UIImage
 */
@property (nonatomic, copy) NSArray *adList;
@property (nonatomic, assign, readonly) NSInteger currentPage;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic , copy) void (^tapActionBlock)(PDAdScrollView *adScrollView);

@end
