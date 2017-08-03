//
//  RHRiskResultCell.m
//  RHRedHorse
//
//  Created by Panda on 2017/7/27.
//  Copyright © 2017年 forex. All rights reserved.
//

#import "RHRiskResultCell.h"
#import "UIResponder+Router.h"

@interface RHRiskResultCell ()
@property (weak, nonatomic) IBOutlet UILabel *riskLvlLabel;
@property (weak, nonatomic) IBOutlet UILabel *testTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *scopeLabel;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;

@property (nonatomic, strong) UIViewController *fromVC;

@end

static NSString *tableViewIdentifier = @"RHRiskResultCell";

@implementation RHRiskResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFromVCs:(NSArray *)fromVCs {
    _fromVCs = fromVCs;
    
    for (UIViewController *vc in fromVCs) {
        if([vc isMemberOfClass:[NSClassFromString(@"RHOccupationChoiceController") class]]) {
            [self.continueButton setTitle:@"继续" forState:UIControlStateNormal];
            self.fromVC = vc;
            return;
        } else if([vc isMemberOfClass:[NSClassFromString(@"RHFollowListController") class]]) {
            [self.continueButton setTitle:@"继续" forState:UIControlStateNormal];
            self.fromVC = vc;
            return;
        } else if ([vc isMemberOfClass:[NSClassFromString(@"RHNewMineViewController") class]]) {
            [self.continueButton setTitle:@"重新测评" forState:UIControlStateNormal];
            self.fromVC = vc;
            return;
        }
    }
}

- (IBAction)continueButton:(UIButton *)sender {
    NSLog(@"HEHE");
    
    [self routerEventWithName:kBLGoodsDetailTicketEvent userInfo:@{@"continueButton":@"hehe",
                                                           @"1continueButton":@"hehe",
                                                           @"2continueButton":@"hehe"}];
    
    // 这里发送的 key 如果重复，会过滤掉
    [self routerEventWithName:kBLGoodsDetailPromotionEvent userInfo:@{@"continueButton2":@"xixi",
                                                            @"continueButton3":@"xixi",
                                                            @"continueButton4":@"xixi",
                                                            @"continueButton2":@"xixi"}];
    
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(continueButtonDidTouched:)]) {
        [self.delegate continueButtonDidTouched:self.fromVC];
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    RHRiskResultCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewIdentifier];
    if (cell == nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:tableViewIdentifier owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, MAXFLOAT)];
    return cell;
}

@end
