//
//  videoList.m
//  掌游宝
//
//  Created by qingyun on 16/1/21.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "videoList.h"
#import "NewsTableViewCell.h"
#import "videoModel.h"
#import "UIImageView+WebCache.h"
#import <AFNetworking.h>
#import "NewsModel.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
@interface videoList ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *VidelImg;
@property (weak, nonatomic) IBOutlet UILabel *VideoTitle;
@property (weak, nonatomic) IBOutlet UILabel *VideoDesc;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation videoList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.VideoTitle.text = _name;
    self.VideoDesc.text = _desc;
    self.title = @"比赛视频列表";
    [_VidelImg sd_setImageWithURL:[NSURL URLWithString:_pic_url]];
    [self loadDataFromNet];
    _tableView.rowHeight = 100;
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *model = self.dataArray[indexPath.row];
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Viedocell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCell" owner:self options:nil][0];
        cell.model = model;
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:cell.model.pic_url]];
    }
    return cell;
    
}
#pragma mark - 网络数据请求
-(void)loadDataFromNet
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:_urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        NSArray *tempArray = dic[@"data"];
        
        self.dataArray = [NSMutableArray array];
        
        for (NSDictionary *dic in tempArray) {
            NewsModel *news = [[NewsModel alloc] initWithDic:dic];
            
            [self.dataArray addObject:news];
        }
        
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 上拉加载更多
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_tableView.contentOffset.y > (_tableView.contentSize.height - _tableView.frame.size.height) + 150) {
        [self loadMoreSource];
    }
}
-(void)loadMoreSource
{
    
    NSString *UrlString = [NSString stringWithFormat:@"http://lol.zhangyoubao.com/apis/rest/ItemsService/videos?catwordid=%@&page=%lu&i_=8643e740dfbf96c2b19f80810eed4f856c82d3f6&t_=1453341797&p_=7736&v_=40070204&d_=ios&osv_=9.2&version=0&a_=lol",_VideoId,(self.dataArray.count/10 +1)];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:UrlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject[@"id"]);
        
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        
//        NSLog(@"%@",dic);
        NSArray *tempArr = responseObject[@"data"];
        
        for (NSDictionary *dic in tempArr) {
            NewsModel *news = [[NewsModel alloc] initWithDic:dic];
            NSLog(@"%@",dic[@"video_url"]);
            
            [self.dataArray addObject:news];
        }
        NSLog(@"%ld",self.dataArray.count);
        
        
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}


#pragma mark - 点击播放视频
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
     NewsModel *model = self.dataArray[indexPath.row];
    NSLog(@"%@",model.viedo_url);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否要使用系统播放器播放该视频" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //创建action
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"播放" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"播放");
        if (AFNetworkReachabilityStatusReachableViaWWAN) {
            UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"警告" message:@"如果正在使用蜂窝网络，则会耗费巨额流量" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cencelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                return;
            }];
            
            UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"播放" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
                playerVC.showsPlaybackControls = YES;
                
                AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:model.viedo_url]];
                
                AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:item];
                
                playerVC.player = player;
                
                [self.navigationController presentViewController:playerVC animated:YES completion:^{
                    [playerVC.player play];
                }];
                

            }];
            
            [controller addAction:cencelAction];
            [controller addAction:okaction];
            [self presentViewController:controller animated:YES completion:nil];
        }
        
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
//    UIAlertAction *action = alert.actions[0];
//    action.enabled = NO;
}
@end
