//
//  PdBaseSectionObject.h
//  PdTableViewBase
//
//  Created by Panda on 16/5/26.
//  Copyright © 2016年 v2panda. All rights reserved.
//
/**
 *  TableViewSection 基础类
 */

#import <Foundation/Foundation.h>

@interface PdBaseSectionObject : NSObject

@property (nonatomic, copy) NSString *headerTitle; // UITableDataSource 协议中的 titleForHeaderInSection 方法可能会用到
@property (nonatomic, copy) NSString *footerTitle; // UITableDataSource 协议中的 titleForFooterInSection 方法可能会用到

@property (nonatomic, retain) NSMutableArray *items;

- (instancetype)initWithItemArray:(NSMutableArray *)items;

@end
