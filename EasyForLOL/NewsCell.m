//
//  NewsCell.m
//  掌游宝
//
//  Created by qingyun on 16/1/20.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "NewsCell.h"
#import "NewsModel.h"
@implementation NewsCell

-(void)setModel:(NewsModel *)model
{
    self.titleLabel.text = model.title;
    self.descLabel.text = model.desc;
    self.pic_url = model.pic_url;
    _model = model;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
