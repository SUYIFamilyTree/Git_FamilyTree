//
//  HelpTableTableViewCell.m
//  FamilyTree
//
//  Created by 王子豪 on 16/5/31.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "HelpTableTableViewCell.h"
@interface HelpTableTableViewCell()



@end
@implementation HelpTableTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.leftImageView];
        [self.contentView addSubview:self.oneLabel];
        [self.contentView addSubview:self.twoLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark *** getters ***

-(UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [UIImageView new];
        _leftImageView.backgroundColor = [UIColor orangeColor];
        
    }
    return _leftImageView;
}
-(UILabel *)oneLabel{
    if (!_oneLabel) {
        _oneLabel = [UILabel new];
        _oneLabel.font = MFont(16);
        _oneLabel.text = @"只能拐杖,让关爱如影随形";
        _oneLabel.backgroundColor    = [UIColor redColor];
        
    }
    return _oneLabel;
}
-(UILabel *)twoLabel{
    if (!_twoLabel) {
        _twoLabel = [UILabel new];
        _twoLabel.font = MFont(14);
        _twoLabel.text = @"跌倒报警,gprs定位,跌倒报警,gprs定位跌倒报警,gprs定位跌倒报警,gprs定位跌倒报警,gprs定位跌倒报警,gprs定位跌倒报警,gprs定位";
        _twoLabel.numberOfLines = 0;
        _twoLabel.backgroundColor = [UIColor blackColor];
    }
    return _twoLabel;
}
@end
