//
//  AllHersoCell.m
//  掌游宝
//
//  Created by qingyun on 16/1/13.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "AllHersoCell.h"
#import "HerosModel.h"
@implementation AllHersoCell

-(void)setModel:(HerosModel *)model
{
    self.NameLabel.text = model.name;
    self.coinLabel.text = model.money;
    self.priceLabel.text = model.point;
    self.pic_url = model.pic_url;
    self.imgView.layer.cornerRadius = 30;
    self.imgView.layer.masksToBounds = YES;
    _model = model;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
