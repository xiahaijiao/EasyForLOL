//
//  VC1Web.m
//  掌游宝
//
//  Created by qingyun on 15/12/13.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "VC1Web.h"
#import "informationVC.h"
#import "MBProgressHUD.h"
@interface VC1Web ()<UIWebViewDelegate>
@property (nonatomic, strong) MBProgressHUD *HUD;
@end

@implementation VC1Web

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    UINavigationController *NavC = [[UINavigationController alloc] init];
//    [self.view addSubview:NavC];
    self.navigationItem.title = @"详情";
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
    
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    webView.delegate = self;

    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.labelText = @"火力全开,急速加载";
    _HUD.mode = MBProgressHUDModeAnnularDeterminate;
    
    [_HUD showAnimated:YES whileExecutingBlock:^{
        float progress = 0.0f;
        while (progress < 1.0f) {
            progress += 0.01f;
            _HUD.progress = progress;
            usleep(10000);
        }
    } completionBlock:^{
        [_HUD removeFromSuperview];
        _HUD = nil;
        
        NSURL *url = [NSURL URLWithString:_urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];

    }];
    
}
-(void)back:(UIBarButtonItem *)barBtnItem{
    informationVC *infor = [[informationVC alloc] init];
    [self.parentViewController.navigationController popToViewController:infor animated:YES];
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
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
