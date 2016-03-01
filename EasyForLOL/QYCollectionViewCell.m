//
//  QYCollectionViewCell.m
//  掌游宝
//
//  Created by qingyun on 15/12/11.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYCollectionViewCell.h"
#import "V3Model.h"
#import "UIImageView+WebCache.h"
@implementation QYCollectionViewCell


-(void)setV3:(V3Model *)V3
{
    _V3 = V3;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:V3.pic_url]];
//    _imageView.image = V3.icon;
    _label.text = V3.name;
    _desc = V3.desc;
    _imageView.layer.cornerRadius = 10;
    _imageView.layer.masksToBounds = YES;
}
- (void)awakeFromNib {
    // Initialization code
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *selectedBgView = [[UIView alloc] init];
    selectedBgView.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = selectedBgView;
}

@end
