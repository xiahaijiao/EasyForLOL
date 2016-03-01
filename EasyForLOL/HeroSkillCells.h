//
//  HeroSkillCells.h
//  掌游宝
//
//  Created by qingyun on 16/1/16.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeroSkills;
@interface HeroSkillCells : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *skill;
@property (weak, nonatomic) IBOutlet UILabel *skillName;
@property (weak, nonatomic) IBOutlet UILabel *skillIntro;
@property (nonatomic, strong) HeroSkills *model;
@end
