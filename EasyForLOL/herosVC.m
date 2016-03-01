//
//  herosVC.m
//  掌游宝
//
//  Created by qingyun on 15/12/10.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "herosVC.h"
#import "SegmentTapView.h"
#import "FilpTableView.h"

//#import "FreeHeros.h"
#import "AllHeros.h"
@interface herosVC ()<SegmentTapViewDelegate,FilpTableViewDelegate>

@property (nonatomic, strong) SegmentTapView *segment;
@property (nonatomic, strong) FilpTableView *filpView;
@property (nonatomic, strong) NSMutableArray *controllsArray;
@end

@implementation herosVC
#define ScreeFrame [UIScreen mainScreen].bounds
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    [self initFilpTableView];
    [self initSegment];
    
}

-(void)selectedIndex:(NSInteger)index
{
    [self.filpView selectIndex:index];
}

-(void)scrollChangeToIndex:(NSInteger)index
{
    [self.segment selectIndex:index];
}

-(void)setNavigationBar
{
    //设置左边的barBtnItem
    UIBarButtonItem *lefeBarBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:nil];
    lefeBarBtnItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = lefeBarBtnItem;
    
    //设置titleView
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"英雄简介"];
    self.navigationItem.title = label.text;
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    
}
#pragma mark - Segment
-(void)initSegment
{
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 14, ScreeFrame.size.width, 30) withDataArray:[NSArray arrayWithObjects:@"全部英雄", nil] withFont:15];
    self.segment.delegate = self;
    [self.view addSubview:_segment];
}
#pragma mark - FilpTableView
-(void)initFilpTableView
{
    if (!self.controllsArray) {
        self.controllsArray = [[NSMutableArray alloc] init];
    }
//    FreeHeros *FreeVC = [[UIStoryboard storyboardWithName:@"Heros" bundle:nil] instantiateViewControllerWithIdentifier:@"Free"];
    
    AllHeros *AllVC = [[UIStoryboard storyboardWithName:@"Heros" bundle:nil] instantiateViewControllerWithIdentifier:@"All"];
    
//    [self addChildViewController:FreeVC];
    [self addChildViewController:AllVC];
    
//    [self.controllsArray addObject:FreeVC];
    [self.controllsArray addObject:AllVC];
    
    _filpView = [[FilpTableView alloc] initWithFrame:CGRectMake(0, 44, ScreeFrame.size.width, self.view.frame.size.height - 104) withArray:_controllsArray];
    
    _filpView.delegate = self;
    [self.view addSubview:_filpView];
}


#pragma mark - TableBar
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *originalImage = [UIImage imageNamed:@"yingxiongxuanzhong"];
        originalImage = [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"英雄简介" image:[UIImage imageNamed:@"yingxiong"] selectedImage:originalImage];
        self.tabBarItem = tabBarItem;
        self.tabBarController.tabBar.translucent = NO;
    }
    return self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
