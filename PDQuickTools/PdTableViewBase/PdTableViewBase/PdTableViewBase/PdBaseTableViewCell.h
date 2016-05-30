//
//  PdBaseTableViewCell.h
//  PdTableViewBase
//
//  Created by Panda on 16/5/26.
//  Copyright © 2016年 v2panda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PdBaseItemObject;

@interface PdBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) id object;

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(PdBaseItemObject *)object;

@end
