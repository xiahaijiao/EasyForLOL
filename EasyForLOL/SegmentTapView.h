//
//  SegmentTapView.h
//  掌游宝
//
//  Created by qingyun on 15/12/10.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegmentTapViewDelegate <NSObject>

@optional
/**
 选择index回调
 
 **/
-(void)selectedIndex:(NSInteger)index;

@end
@interface SegmentTapView : UIView

@property (nonatomic, assign)id<SegmentTapViewDelegate> delegate;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UIColor *textNomalColor;

@property (nonatomic, strong) UIColor *textSelectedColor;

@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, assign) CGFloat titleFont;

//frame大小  标题数组  标题字体的大小
-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray withFont:(CGFloat)font;

//手动选择
-(void)selectIndex:(NSInteger)index;
@end
