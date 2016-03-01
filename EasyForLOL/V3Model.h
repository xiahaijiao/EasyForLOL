//
//  V3Model.h
//  掌游宝
//
//  Created by qingyun on 15/12/12.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;

#define KIconKey @"icon"
#define KNameKey @"name"
#define KID @"videoID"
#define KPICURL @"pic_url"
#define KDESC @"desc"
@interface V3Model : NSObject

@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, assign) NSString *videoID;
@property (nonatomic, strong) NSString *desc;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)VTModelWithDict:(NSDictionary *)dict;
@end
