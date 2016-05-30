//
//  PdTableViewDataSource.h
//  PdTableViewBase
//
//  Created by Panda on 16/5/26.
//  Copyright © 2016年 v2panda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PdBaseItemObject;

@protocol PdTableViewDataSource <UITableViewDataSource>

@optional
/**
 *  子类通过 objectForRowAtIndexPath 方法可以快速获取 item
 */
- (PdBaseItemObject *)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  指定 cell 的类型
 */
- (Class)tableView:(UITableView*)tableView cellClassForObject:(PdBaseItemObject *)object;

@end

@interface PdTableViewDataSource : NSObject <PdTableViewDataSource>

@property (nonatomic, strong) NSMutableArray *sections;  // 二维数组，每个元素都是一个 SectionObject

/**
 *  只有一个section 可以用此方法添加item
 */
- (void)appendItem:(PdBaseItemObject *)item;

@end
