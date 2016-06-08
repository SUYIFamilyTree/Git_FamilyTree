//
//  NewsCell.m
//  FamilyTree
//
//  Created by 王子豪 on 16/6/7.
//  Copyright © 2016年 王子豪. All rights reserved.
//

#import "NewsCell.h"

@interface NewsCell()
@property (nonatomic,strong) UILabel *dashLine; /*虚线*/
@property (nonatomic,strong) UILabel *newsText; /*内容*/

@end
@implementation NewsCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        [self addSubview:self.dashLine];
        
    }
    return self;
}

-(UILabel *)dashLine{
    if (!_dashLine) {
        _dashLine = [[UILabel alloc] initWithFrame:CGRectMake(26*AdaptationWidth(), 2, 662*AdaptationWidth(), 1)];
        _dashLine.backgroundColor = LH_RGBCOLOR(223, 223, 223);
    }
    return _dashLine;
}

-(UILabel *)newsText{
    if (!_newsText) {
        _newsText = [[UILabel alloc] initWithFrame:AdaptationFrame(26, 5, 662, 50)];
        _newsText.font = MFont(12);
        _newsText.textColor = LH_RGBCOLOR(108, 108, 108);
    }
    return _newsText;
}
@end
