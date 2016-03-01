//
//  HeroSkillCells.m
//  掌游宝
//
//  Created by qingyun on 16/1/16.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "HeroSkillCells.h"
#import "HeroSkills.h"
#import "UIImageView+WebCache.h"
//#import "MDHTMLLabel.h"
@implementation HeroSkillCells

-(void)setModel:(HeroSkills *)model
{
    _model = model;
    [self.skill sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    _skillName.text = model.name;
    _skillIntro.text = model.desc;
//    MDHTMLLabel *htmlLabel = [[MDHTMLLabel alloc] init];
//    htmlLabel.htmlText = _skillIntro.text;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
