//
//  QYMoreCell.m
//  掌游宝
//
//  Created by qingyun on 15/12/13.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYMoreCell.h"
#import "moreModel.h"
@implementation QYMoreCell

-(void)setMmodel:(moreModel *)Mmodel
{
    _Mmodel = Mmodel;
    
    _imageView.image = Mmodel.icon;
    _label.text = Mmodel.name;
}
- (void)awakeFromNib {
    // Initialization code
}

@end
