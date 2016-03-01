//
//  NewsCell.h
//  掌游宝
//
//  Created by qingyun on 16/1/20.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;
@interface NewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, strong) NewsModel *model;
@end
