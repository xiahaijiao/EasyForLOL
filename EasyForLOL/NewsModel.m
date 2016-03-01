//
//  NewsModel.m
//  掌游宝
//
//  Created by qingyun on 16/1/8.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

-(instancetype)initWithDic:(NSDictionary *)value
{
    if (self= [super init]) {
        self.published = value[@"published"];
        self.iD = value[@"id"];
        self.viedo_url = value[@"video_url"];
        self.title = value[@"title"];
        self.platform = value[@"platform"];
        self.pic_url = value[@"pic_url"];
        self.recommend = value[@"recommend"];
        self.weight_new = value[@"weight_new"];
        self.desc = value[@"desc"];
    }
    return self;
}

@end
