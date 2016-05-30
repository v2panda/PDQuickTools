//
//  PdBaseTableView.m
//  PdTableViewBase
//
//  Created by Panda on 16/5/25.
//  Copyright © 2016年 v2panda. All rights reserved.
//

#import "PdBaseTableView.h"
#import "PdBaseSectionObject.h"
#import "PdBaseItemObject.h"
#import "PdBaseTableViewCell.h"

@implementation PdBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.separatorColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = YES;
        self.showsHorizontalScrollIndicator = NO;
        // 自定义高度
        self.sectionHeaderHeight = 0;
        self.sectionFooterHeight = 0;
        self.delegate = self;
    }
    return self;
}

- (void)setPdDataSource:(id<PdTableViewDataSource>)pdDataSource {
    if (_pdDataSource != pdDataSource) {
        _pdDataSource = pdDataSource;
        self.dataSource = pdDataSource;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<PdTableViewDataSource> dataSource = (id<PdTableViewDataSource>)tableView.dataSource;
    
    PdBaseItemObject *object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    Class class = [dataSource tableView:tableView cellClassForObject:object];
    
    if (object.cellHeight == CellInvalidHeight) {
        object.cellHeight = [class tableView:tableView rowHeightForObject:object];
    }
    return object.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.pdDelegate respondsToSelector:@selector(didSelectObject:atIndexPath:)]) {
        id<PdTableViewDataSource> dataSource = (id<PdTableViewDataSource>)tableView.dataSource;
        id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
        [self.pdDelegate didSelectObject:object atIndexPath:indexPath];
        // 取消tableView选中状态
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }else if ([self.pdDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.pdDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

// 得先定义sectionHeaderHeight
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.pdDelegate respondsToSelector:@selector(headerViewForSectionObject:atSection:)]) {
        id<PdTableViewDataSource> dataSource = (id<PdTableViewDataSource>)tableView.dataSource;
        PdBaseSectionObject *sectionObject = [((PdTableViewDataSource *)dataSource).sections objectAtIndex:section];
        
        return [self.pdDelegate headerViewForSectionObject:sectionObject atSection:section];
    }
    else if ([self.pdDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.pdDelegate tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}

#pragma mark - 传递原生协议

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.pdDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.pdDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}
@end
