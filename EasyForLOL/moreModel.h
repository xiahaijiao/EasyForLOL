//
//  moreModel.h
//  掌游宝
//
//  Created by qingyun on 15/12/13.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;
@interface moreModel : NSObject

@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSString *name;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)moreWithDict:(NSDictionary *)dict;
@end
