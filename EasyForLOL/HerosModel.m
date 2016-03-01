//
//  HerosModel.m
//  掌游宝
//
//  Created by qingyun on 16/1/13.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "HerosModel.h"

@implementation HerosModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.id = value;
    }
}

-(instancetype)initWithDic:(NSDictionary *)value
{
    if (self = [super init]) {
        self.id = value[@"id"];
        self.name = value[@"name"];
        self.nickname = value[@"nickname"];
        self.filter = value[@"filter"];
        self.nickpinyin = value[@"nickpinyin"];
        self.publish = value[@"publish"];
        self.free = value[@"free"];
        self.keyword = value[@"keyword"];
        self.money = value[@"money"];
        self.point = value[@"point"];
        self.area = value[@"area"];
        self.duoname = value[@"duoname"];
        self.pic_url = value[@"pic_url"];
    }
    return self;
}
@end
