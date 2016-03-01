//
//  QYMoreCell.h
//  掌游宝
//
//  Created by qingyun on 15/12/13.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class moreModel;
@interface QYMoreCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic, strong) moreModel *Mmodel;
@end
