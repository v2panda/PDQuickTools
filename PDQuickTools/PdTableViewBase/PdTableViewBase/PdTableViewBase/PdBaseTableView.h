//
//  PdBaseTableView.h
//  PdTableViewBase
//
//  Created by Panda on 16/5/25.
//  Copyright © 2016年 v2panda. All rights reserved.
//
/**
 *  TableView 基础类
 */

#import <UIKit/UIKit.h>
#import "PdTableViewDataSource.h"

@class PdBaseSectionObject;
/**
 *  这个协议继承了UITableViewDelegate ，所以自己做一层中转，VC 依然需要实现某些代理方法。
 */
@protocol PdBaseTableViewDelegate <UITableViewDelegate>
@optional
/**
 * 选择一个cell的回调，并返回被选择cell的数据结构和indexPath
 */
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

- (UIView *)headerViewForSectionObject:(PdBaseSectionObject *)sectionObject atSection:(NSInteger)section;

// 可以有 cell 的编辑，交换，左滑等回调

@end


@interface PdBaseTableView : UITableView<UITableViewDelegate>

@property (nonatomic, assign) id<PdTableViewDataSource> pdDataSource;

@property (nonatomic, assign) id<PdBaseTableViewDelegate> pdDelegate;

@end
