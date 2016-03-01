//
//  videoVC.m
//  掌游宝
//
//  Created by qingyun on 15/12/10.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "videoVC.h"
#import "SegmentTapView.h"
#import "FilpTableView.h"

#import "VCVideo1.h"
#import "VCVideo2.h"
#import "VCVideo3.h"
@interface videoVC ()<SegmentTapViewDelegate,FilpTableViewDelegate>

@property (nonatomic, strong)SegmentTapView *segment;
@property (nonatomic, strong)FilpTableView *filpView;
@property (nonatomic, strong) NSMutableArray *controllsArray;
@end

@implementation videoVC
#define ScreeFrame [UIScreen mainScreen].bounds
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    [self initSegment];
    [self initFilpTableView];
}

-(void)initSegment
{
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 14, ScreeFrame.size.width, 30) withDataArray:[NSArray arrayWithObjects:@"比赛视频",nil] withFont:15];
    self.segment.delegate = self;
    [self.view addSubview:self.segment];
}

-(void)initFilpTableView
{
    if (!self.controllsArray) {
        self.controllsArray = [[NSMutableArray alloc] init];
    }
    
//    VCVideo1 *VC1 = [[UIStoryboard storyboardWithName:@"VCSB" bundle:nil] instantiateViewControllerWithIdentifier:@"VCSB1"];
//    VCVideo2 *VC2 = [[UIStoryboard storyboardWithName:@"VCSB" bundle:nil] instantiateViewControllerWithIdentifier:@"VCSB2"];
    VCVideo3 *VC3 = [[UIStoryboard storyboardWithName:@"VCSB" bundle:nil] instantiateViewControllerWithIdentifier:@"VCSB3"];
    
//    [self addChildViewController:VC1];
//    [self addChildViewController:VC2];
    [self addChildViewController:VC3];
    
//    [self.controllsArray addObject:VC1];
//    [self.controllsArray addObject:VC2];
    [self.controllsArray addObject:VC3];
    
    self.filpView = [[FilpTableView alloc] initWithFrame:CGRectMake(0, 44, ScreeFrame.size.width, self.view.frame.size.height - 104) withArray:_controllsArray];
    
    self.filpView.delegate = self;
    [self.view addSubview:self.filpView];
    
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
    UIBarButtonItem *leftBarBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:nil];
    leftBarBtnItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarBtnItem;
    
    //设置titleView
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"视频"];
    self.navigationItem.title = label.text;
    
    //设置右边的barBtnItem
    UIBarButtonItem *rightBarBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightBarBtnItem;
    rightBarBtnItem.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    
}

//
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *originalImage = [UIImage imageNamed:@"shipinxuanzhong"];
        originalImage = [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"比赛视频" image:[UIImage imageNamed:@"shipin"] selectedImage:originalImage];
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
