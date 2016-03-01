//
//  NewsTableViewCell.m
//  掌游宝
//
//  Created by qingyun on 16/1/8.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "NewsModel.h"

@implementation NewsTableViewCell


-(void)setModel:(NewsModel *)model
{
    self.titleLabel.text = model.title;
    self.pic_url = model.pic_url;
    self.desLabel.text = model.desc;
//    self.timeLabel.text = model.iD;
    _imgView.layer.cornerRadius = 8;
    _imgView.layer.masksToBounds = YES;
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
