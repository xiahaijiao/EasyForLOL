//
//  videoModel.m
//  掌游宝
//
//  Created by qingyun on 16/1/21.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "videoModel.h"

@implementation videoModel


-(instancetype)initWithDic:(NSDictionary *)value
{
    if (self = [super init]) {
        self.pic_url = value[@""];
        self.name = value[@""];
    }
    return self;
}
@end
