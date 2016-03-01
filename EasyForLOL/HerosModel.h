//
//  HerosModel.h
//  掌游宝
//
//  Created by qingyun on 16/1/13.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HerosModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *filter;
@property (nonatomic, strong) NSString *nickpinyin;
@property (nonatomic, strong) NSString *publish;
@property (nonatomic, strong) NSString *free;
@property (nonatomic, strong) NSString *keyword;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *point;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *duoname;
@property (nonatomic, strong) NSString *pic_url;

-(instancetype)initWithDic:(NSDictionary *)value;
@end
