//
//  MainTableViewDataSource.m
//  PdTableViewBase
//
//  Created by Panda on 16/5/27.
//  Copyright © 2016年 v2panda. All rights reserved.
//

#import "MainTableViewDataSource.h"
#import "MainTableViewCel.h"

#import "PdBaseSectionObject.h" // 这个实际使用时应该是对应的子类
#import "PdBaseItemObject.h" // 这个实际使用时应该是对应的子类

@implementation MainTableViewDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        PdBaseSectionObject *firstSectionObject = [[PdBaseSectionObject alloc] initWithItemArray:[NSMutableArray arrayWithObjects:
                                                                                                  [[PdBaseItemObject alloc] initWithImage:nil Title:@"第一条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                  [[PdBaseItemObject alloc] initWithImage:nil Title:@"第二条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                  [[PdBaseItemObject alloc] initWithImage:nil Title:@"第三条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                  [[PdBaseItemObject alloc] initWithImage:nil Title:@"第四条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                  [[PdBaseItemObject alloc] initWithImage:nil Title:@"第五条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                  [[PdBaseItemObject alloc] initWithImage:nil Title:@"第六条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                  [[PdBaseItemObject alloc] initWithImage:nil Title:@"第七条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                  [[PdBaseItemObject alloc] initWithImage:nil Title:@"第八条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                  [[PdBaseItemObject alloc] initWithImage:nil Title:@"第九条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                  nil]];
        PdBaseSectionObject *secSectionObject = [[PdBaseSectionObject alloc] initWithItemArray:[NSMutableArray arrayWithObjects:
                                                                                                
                                                                                                [[PdBaseItemObject alloc] initWithImage:nil Title:@"第十二条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                [[PdBaseItemObject alloc] initWithImage:nil Title:@"第十三条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                [[PdBaseItemObject alloc] initWithImage:nil Title:@"第十四条消息" SubTitle:nil AccessoryImage:nil],
                                                                                                nil]];
        
        self.sections = [NSMutableArray arrayWithObjects:firstSectionObject,secSectionObject, nil];
    }
    return self;
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(PdBaseItemObject *)object {
    return [MainTableViewCel class];
}

@end
