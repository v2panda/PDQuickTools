//
//  RHRiskResultCell.h
//  RHRedHorse
//
//  Created by Panda on 2017/7/27.
//  Copyright © 2017年 forex. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString  *kBLGoodsDetailTicketEvent = @"kBLGoodsDetailTicketEvent";

static NSString  *kBLGoodsDetailPromotionEvent = @"kBLGoodsDetailPromotionEvent";


@protocol RHRiskResultCellDelegate <NSObject>

- (void)continueButtonDidTouched:(UIViewController *)fromeVC;

@end

@interface RHRiskResultCell : UITableViewCell

@property (nonatomic, strong) NSArray *fromVCs;

@property (nonatomic, weak) id<RHRiskResultCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
