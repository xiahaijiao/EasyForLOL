//
//  V3Model.m
//  掌游宝
//
//  Created by qingyun on 15/12/12.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "V3Model.h"
#import <UIKit/UIImage.h>
@implementation V3Model

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _icon = [UIImage imageNamed:dict[KIconKey]];
        _name = dict[KNameKey];
        _videoID = dict[KID];
        _pic_url = dict[KPICURL];
        _desc = dict[KDESC];
    }
    return self;
}

+(instancetype)VTModelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

@end
