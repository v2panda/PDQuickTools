//
//  PdBaseTableViewCell.m
//  PdTableViewBase
//
//  Created by Panda on 16/5/26.
//  Copyright © 2016年 v2panda. All rights reserved.
//

#import "PdBaseTableViewCell.h"
#import "PdBaseItemObject.h"

@implementation PdBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 子类在这个方法中解析数据
- (void)setObject:(PdBaseItemObject *)object {
    self.imageView.image = object.itemImage;
    self.textLabel.text = object.itemTitle;
    self.detailTextLabel.text = object.itemSubtitle;
    self.accessoryView = [[UIImageView alloc] initWithImage:object.itemAccessoryImage];
}

// 返回Cell高度 默认44
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(PdBaseItemObject *)object {
    return 44.0f;
}

@end
