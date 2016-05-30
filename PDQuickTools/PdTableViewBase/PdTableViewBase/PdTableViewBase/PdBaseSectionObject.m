//
//  PdBaseSectionObject.m
//  PdTableViewBase
//
//  Created by Panda on 16/5/26.
//  Copyright © 2016年 v2panda. All rights reserved.
//

#import "PdBaseSectionObject.h"

@implementation PdBaseSectionObject

- (instancetype)init {
    self = [super init];
    if (self) {
        self.headerTitle = @"";
        self.footerTitle = @"";
        self.items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithItemArray:(NSMutableArray *)items {
    self = [self init];
    if (self) {
        [self.items addObjectsFromArray:items];
    }
    return self;
}

@end
