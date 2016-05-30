//
//  MainTableViewCel.m
//  PdTableViewBase
//
//  Created by Panda on 16/5/27.
//  Copyright © 2016年 v2panda. All rights reserved.
//

#import "MainTableViewCel.h"

@implementation MainTableViewCel

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(PdBaseItemObject *)object {
    
    return 60;
}


@end
