//
//  videoModel.h
//  掌游宝
//
//  Created by qingyun on 16/1/21.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface videoModel : NSObject


@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, strong) NSString *name;

-(instancetype)initWithDic:(NSDictionary *)value;
@end
