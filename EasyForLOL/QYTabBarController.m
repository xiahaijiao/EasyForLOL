//
//  QYTabBarController.m
//  掌游宝
//
//  Created by qingyun on 15/12/10.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYTabBarController.h"
#import "informationVC.h"
#import "videoVC.h"
#import "herosVC.h"
//#import "communityVC.h"
#import "moreVC.h"
@interface QYTabBarController ()

@end

@implementation QYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tabBar
    [self setTabBar];
}

//设置tabBar和绑定视图控制器
-(void)setTabBar
{
    self.tabBar.translucent = NO;
    
    informationVC *inforView = [[informationVC alloc] init];
    UINavigationController *NavInfor = [[UINavigationController alloc] initWithRootViewController:inforView];
    videoVC *videoView = [[videoVC alloc] init];
    UINavigationController *NavVideo = [[UINavigationController alloc] initWithRootViewController:videoView];
    herosVC *herosView = [[herosVC alloc] init];
    UINavigationController *NavHeros = [[UINavigationController alloc] initWithRootViewController:herosView];
//    communityVC *communityView = [[communityVC alloc] init];
//    UINavigationController *NavCommunity = [[UINavigationController alloc] initWithRootViewController:communityView];
    moreVC *moreView = [[moreVC alloc] init];
    UINavigationController *NavMore = [[UINavigationController alloc] initWithRootViewController:moreView];
    
    
    NSArray *ViewController = @[NavInfor,NavVideo,NavHeros,NavMore];
    self.viewControllers = ViewController;
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
