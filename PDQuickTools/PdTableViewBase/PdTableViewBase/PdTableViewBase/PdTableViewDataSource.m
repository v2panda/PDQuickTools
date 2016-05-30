//
//  PdTableViewDataSource.m
//  PdTableViewBase
//
//  Created by Panda on 16/5/26.
//  Copyright © 2016年 v2panda. All rights reserved.
//

#import "PdTableViewDataSource.h"
#import "PdBaseSectionObject.h"
#import "PdBaseItemObject.h"
#import "PdBaseTableViewCell.h"
#import <objc/runtime.h>

@implementation PdTableViewDataSource

#pragma mark - PdTableViewDataSource
- (PdBaseItemObject *)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sections.count > indexPath.section) {
        PdBaseSectionObject *sectionObject = [self.sections objectAtIndex:indexPath.section];
        if ([sectionObject.items count] > indexPath.row) {
            return [sectionObject.items objectAtIndex:indexPath.row];
        }
    }
    return nil;
}

 // 这个方法会子类有机会重写，默认的 Cell 类型是 KtBaseTableViewCell
- (Class)tableView:(UITableView*)tableView cellClassForObject:(PdBaseItemObject *)object {
    return [PdBaseTableViewCell class];
}

- (void)appendItem:(PdBaseItemObject *)item {
    PdBaseSectionObject *firstSectionObject = [self.sections objectAtIndex:0];
    [firstSectionObject.items addObject:item];
}

#pragma mark - UITableViewDataSource Required
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.sections.count > section) {
        PdBaseSectionObject *sectionObject = [self.sections objectAtIndex:section];
        return sectionObject.items.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PdBaseItemObject *object = [self tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cellClass = [self tableView:tableView cellClassForObject:object];
    NSString *className = [NSString stringWithUTF8String:class_getName(cellClass)];
    
    PdBaseTableViewCell* cell = (PdBaseTableViewCell*)[tableView dequeueReusableCellWithIdentifier:className];
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:className];
    }
    [cell setObject:object];
    
    return cell;
}

#pragma mark - UITableViewDataSource Optional
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections ? self.sections.count : 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.sections.count > section) {
        PdBaseSectionObject *sectionObject = [self.sections objectAtIndex:section];
        return sectionObject.headerTitle;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (self.sections.count > section) {
        PdBaseSectionObject *sectionObject = [self.sections objectAtIndex:section];
        if (sectionObject != nil && sectionObject.footerTitle != nil && ![sectionObject.footerTitle isEqualToString:@""]) {
            return sectionObject.footerTitle;
        }
    }
    return nil;
}

@end
