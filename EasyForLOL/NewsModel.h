//
//  NewsModel.h
//  掌游宝
//
//  Created by qingyun on 16/1/8.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NewsModel : NSObject

@property (nonatomic, strong) NSString *iD;
@property (nonatomic, strong) NSString *published;
@property (nonatomic, strong) NSString *viedo_url;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *platform;
@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, strong) NSString *recommend;
@property (nonatomic, strong) NSMutableString *weight_new;
@property (nonatomic, strong) NSString *desc;

-(instancetype)initWithDic:(NSDictionary *)value;
@end
