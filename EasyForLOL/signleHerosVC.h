//
//  signleHerosVC.h
//  掌游宝
//
//  Created by qingyun on 16/1/13.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "changeValue.h"
@interface signleHerosVC : UIViewController

@property (nonatomic, strong) NSString *nameLabelText;
@property (nonatomic, strong) NSString *filterLabelText;
@property (nonatomic, strong) NSString *moneyLabelText;
@property (nonatomic, strong) NSString *pointLabeltext;
@property (nonatomic, strong) NSString *iconname;
@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, assign) id <changeValue> delegate;
@end
