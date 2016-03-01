//
//  HeroSkills.m
//  掌游宝
//
//  Created by qingyun on 16/1/16.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "HeroSkills.h"

@implementation HeroSkills


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.id = value;
    }
}

-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.id = dic[@"id"];
        self.role_id = dic[@"role_id"];
        self.name = dic[@"name"];
        self.video_path = dic[@"video_path"];
        self.key = dic[@"key"];
        self.passive = dic[@"passive"];
        self.desc = dic[@"desc"];
        self.cold = dic[@"cold"];
        self.blood = dic[@"blood"];
        self.energy = dic[@"energy"];
        self.mana = dic[@"mana"];
        self.pic_url = dic[@"pic_url"];
    }
    return self;
}
@end
