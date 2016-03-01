//
//  ViewController.m
//  掌游宝
//
//  Created by qingyun on 15/12/10.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "informationVC.h"
//#import "searchVC.h"
#import "SegmentTapView.h"
#import "FilpTableView.h"

#import "ViewController1.h"
#import "ViewController2.h"
//#import "ViewController3.h"
//#import "ViewController4.h"
#import "VC1Web.h"
@interface informationVC ()<SegmentTapViewDelegate,FilpTableViewDelegate>
@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, strong)FilpTableView *filpView;
@property (nonatomic, strong) NSMutableArray *controllsArray;
@end

@implementation informationVC
#define ScreeFrame [UIScreen mainScreen].bounds
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //进入界面的时间设置
    [NSThread sleepForTimeInterval:1.0];
    //设置导航栏
    [self setNavigationBar];
    
    [self initSegment];
    
    
    [self initFilpTableView];
//    ViewController1 *vc1 = [[ViewController1 alloc] init];
//    [self.navigationController pushViewController:vc1 animated:YES];
}

-(void)initSegment
{
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 14, ScreeFrame.size.width, 30) withDataArray:[NSArray arrayWithObjects:@"最新",@"新闻", nil] withFont:15];
    self.segment.delegate = self;
    [self.view addSubview:self.segment];
}

-(void)initFilpTableView
{
    if (!self.controllsArray) {
        self.controllsArray = [[NSMutableArray alloc] init];
        
    }
    
    ViewController1 *v1 = [[UIStoryboard storyboardWithName:@"Body" bundle:nil] instantiateViewControllerWithIdentifier:@"first"];
    
    ViewController2 *v2 = [[UIStoryboard storyboardWithName:@"Body" bundle:nil] instantiateViewControllerWithIdentifier:@"second"];
    
//    ViewController3 *v3 = [[UIStoryboard storyboardWithName:@"Body" bundle:nil] instantiateViewControllerWithIdentifier:@"third"];
//    
//    ViewController4 *v4 = [[UIStoryboard storyboardWithName:@"Body" bundle:nil] instantiateViewControllerWithIdentifier:@"four"];
    VC1Web *vc1 = [[VC1Web alloc] init];
    [self addChildViewController:v1];
    [self addChildViewController:v2];
//    [self addChildViewController:v3];
//    [self addChildViewController:v4];
    
    [self addChildViewController:vc1];
    [self.controllsArray addObject:v1];
    [self.controllsArray addObject:v2];
//    [self.controllsArray addObject:v3];
//    [self.controllsArray addObject:v4];
    
    self.filpView = [[FilpTableView alloc] initWithFrame:CGRectMake(0, 44, ScreeFrame.size.width, self.view.frame.size.height - 104) withArray:_controllsArray];
    self.filpView.delegate = self;
    [self.view addSubview:self.filpView];
}



-(void)selectedIndex:(NSInteger)index{
    [self.filpView selectIndex:index];
}

-(void)scrollChangeToIndex:(NSInteger)index{
    [self.segment selectIndex:index];
}

//设置导航栏
-(void)setNavigationBar
{
    //设置左边的barBtnItem
    UIBarButtonItem *lefeBarBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:nil];
    lefeBarBtnItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = lefeBarBtnItem;
    
    //设置titleView
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"联盟快讯"];
    self.navigationItem.title = label.text;
    
//    //设置右边的barBtnItem
//    UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchClick:)];
//    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
//    rightBarBtnItem.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    
}
//设置tabBar
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *originalImage = [UIImage imageNamed:@"xinwenxuanzhong"];
        originalImage = [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"联盟快讯" image:[UIImage imageNamed:@"xinwen"] selectedImage:originalImage];
        self.tabBarItem = tabBarItem;
        self.tabBarController.tabBar.translucent = NO;
    }
    return self;
}

//-(void)searchClick:(UIBarButtonItem *)rightBarBtnItem
//{
//    searchVC *Search = [[searchVC alloc] init];
//    [self.navigationController pushViewController:Search animated:YES];
//    self.tabBarController.tabBar.hidden = YES;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
