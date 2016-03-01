//
//  FilpTableView.h
//  掌游宝
//
//  Created by qingyun on 15/12/10.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^HDSliderTabBarSelectBlock) (NSInteger index, UITableView *reloadView);
@protocol FilpTableViewDelegate <NSObject>

/**
 滑动回调
 
 **/
-(void)scrollChangeToIndex:(NSInteger)index;
@end

@interface FilpTableView : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

//@property (nonatomic, strong) UITableView *leftView;
//@property (nonatomic, strong) UITableView *showView;
//@property (nonatomic, strong) UITableView *rightView;
//@property (nonatomic, copy) HDSliderTabBarSelectBlock seletedBlock;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) id<FilpTableViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame withArray:(NSArray *)contentArray;

-(void)selectIndex:(NSInteger)index;

@end
