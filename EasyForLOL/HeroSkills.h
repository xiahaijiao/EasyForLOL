//
//  HeroSkills.h
//  掌游宝
//
//  Created by qingyun on 16/1/16.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroSkills : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *role_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *video_path;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *passive;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *cold;
@property (nonatomic, strong) NSString *blood;
@property (nonatomic, strong) NSString *energy;
@property (nonatomic, strong) NSString *mana;
@property (nonatomic, strong) NSString *pic_url;


-(instancetype)initWithDic:(NSDictionary *)dic;
@end
