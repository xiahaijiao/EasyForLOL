//
//  SegmentTapView.m
//  掌游宝
//
//  Created by qingyun on 15/12/10.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "SegmentTapView.h"
//类的扩展
@interface SegmentTapView ()
@property (nonatomic, strong) NSMutableArray *buttonsArray;
@property (nonatomic, strong) UIImageView *lineImageView;
@end

@implementation SegmentTapView

-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray withFont:(CGFloat)font
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        _buttonsArray = [[NSMutableArray alloc] init];
        _dataArray = dataArray;
        _titleFont = font;
        
        //默认
        self.textNomalColor = [UIColor blackColor];
        self.textSelectedColor = [UIColor colorWithRed:243/255.0 green:123/255.0 blue:30/255.0 alpha:1];
        self.lineColor = [UIColor colorWithRed:25/225 green:82/255 blue:161/255 alpha:1];
        
        [self addSubSegmentView];
    }
    return self;
}

-(void)addSubSegmentView
{
    //每个按键的宽度
    float width = self.frame.size.width / _dataArray.count;
    
    for (int i = 0 ; i < _dataArray.count ; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*width, 0, width, self.frame.size.height)];
        button.tag = i + 1;
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:[_dataArray objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:self.textNomalColor forState:UIControlStateNormal];
        [button setTitleColor:self.textSelectedColor forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:_titleFont];
        
        [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //默认第一个选中
        if (i == 0) {
            button.selected = YES;
        }
        else{
            button.selected = NO;
        }
        
        [self.buttonsArray addObject:button];
        [self addSubview:button];
        
        if (i != _dataArray.count || i != 0) {
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(i * width, 0, 0.45, 40)];
            line.backgroundColor = [UIColor whiteColor];
            [self bringSubviewToFront:line];
            [self addSubview:line];
        }
    }
    self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, width, 1)];
    self.lineImageView.backgroundColor = _lineColor;
    [self addSubview:self.lineImageView];
}

-(void)tapAction:(id)sender{
    UIButton *button = (UIButton *)sender;
    [UIView animateWithDuration:0.2 animations:^{
        self.lineImageView.frame = CGRectMake(button.frame.origin.x, self.frame.size.height - 1, button.frame.size.width, 1);
    }];
    for (UIButton *suButton in self.buttonsArray) {
        if (button == suButton) {
            suButton.selected = YES;
        }else{
            suButton.selected = NO;
        }
    }
    if ([self.delegate respondsToSelector:@selector(selectedIndex:)]) {
        [self.delegate selectedIndex:button.tag -1];
    }
}

-(void)selectIndex:(NSInteger)index
{
    for (UIButton *suButton in self.buttonsArray) {
        if (index != suButton.tag) {
            suButton.selected = NO;
        }else{
            suButton.selected = YES;
            [UIView animateWithDuration:0.2 animations:^{
                self.lineImageView.frame = CGRectMake(suButton.frame.origin.x, suButton.frame.size.height - 1, suButton.frame.size.width, 1);
            }];
        }
    }
}

-(void)setLineColor:(UIColor *)lineColor
{
    if (_lineColor != lineColor) {
        self.lineImageView.backgroundColor = lineColor;
        _lineColor = lineColor;
    }
}
-(void)setTextNomalColor:(UIColor *)textNomalColor
{
    if (_textNomalColor != textNomalColor) {
        for (UIButton *suButton in self.buttonsArray) {
            [suButton setTitleColor:textNomalColor forState:UIControlStateNormal];
        }
        _textNomalColor = textNomalColor;
    }
}

-(void)setTextSelectedColor:(UIColor *)textSelectedColor
{
    if (_textSelectedColor != textSelectedColor) {
        for (UIButton *suButton in self.buttonsArray) {
            [suButton setTitleColor:textSelectedColor forState:UIControlStateSelected];
        }
        _textSelectedColor = textSelectedColor;
    }
}

-(void)setTitleFont:(CGFloat)titleFont
{
    if (_titleFont != titleFont) {
        for (UIButton *suButton in self.buttonsArray) {
            suButton.titleLabel.font = [UIFont systemFontOfSize:titleFont];
        }
        _titleFont = titleFont;
    }
}
@end
