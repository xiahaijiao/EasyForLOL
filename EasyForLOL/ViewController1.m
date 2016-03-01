//
//  ViewController1.m
//  掌游宝
//
//  Created by qingyun on 15/12/10.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController1.h"
#import "VC1Web.h"
#import "informationVC.h"
#import <AFNetworking.h>
#import "NewsModel.h"
#import "NewsTableViewCell.h"
#import "NewsCell.h"
//#import "FileHandel.h"
#import "UIImageView+WebCache.h"
//#import "SXNetworkTools.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>


@interface ViewController1 ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
#define KImageURL @"http://avatar.anzogame.com/pic_v1/"
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView1;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation ViewController1
#define QYScreenW [UIScreen mainScreen].bounds.size.width
#define QYScreenH [UIScreen mainScreen].bounds.size.height
#define imgCount 6
int a = 0;
static NSString *QYID = @"Viedocell";
static NSString *identifier = @"NewSCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height - 154) style:UITableViewStylePlain];
    [self.view addSubview:tableView1];
    _tableView1 = tableView1;
    _tableView1.dataSource = self;
    _tableView1.delegate = self;
    _tableView1.tableHeaderView.backgroundColor = [UIColor redColor];
    _tableView1.rowHeight = 100;
    tableView1.backgroundColor = [UIColor whiteColor];
    [self setHeaderView];
//    [_tableView1 registerClass:[UITableViewCell class] forCellReuseIdentifier:QYID];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(next:) userInfo:nil repeats:YES];
    [self loadDataFromNet];
    [self addSubView];

}


-(void)addSubView
{
    _refreshControl = [[UIRefreshControl alloc] init];
    _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新..."];
    [_refreshControl addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
    
    [_tableView1 addSubview:_refreshControl];
}

-(void)changeValue:(UIRefreshControl *)control
{
    if (control.isRefreshing) {
        control.attributedTitle = [[NSAttributedString alloc] initWithString:@"正在加载..."];
        
        [self loadDataFromNet];
    }else{
        
    }
}
//设置头视图的滚动
-(void)setHeaderView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 400, QYScreenW, 150)];
    _scrollView.backgroundColor = [UIColor redColor];
    [self.tableView1 addSubview:_scrollView];
    
    self.scrollView.pagingEnabled = YES;
    
    _scrollView.contentSize = CGSizeMake(QYScreenW * imgCount, 0);
    
    _scrollView.delegate = self;
    
    CGFloat imageY = 0;
    CGFloat imageW = QYScreenW;
    CGFloat imageH = 150;
    for (int i = 0 ; i < imgCount ; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        CGFloat imageX = i * QYScreenW;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        NSString *name = [NSString stringWithFormat:@"LOL%d",i + 1];
        imageView.image = [UIImage imageNamed:name];
        
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self.scrollView addSubview:imageView];
    }
    //设置为头视图
    _tableView1.tableHeaderView = _scrollView;
}

-(void)next:(NSInteger)go
{
    int b = a;
    if (b == 5) {
        b = 0;
        a = b;
        CGFloat offsetx = b * self.scrollView.frame.size.width;
        
        [self.scrollView setContentOffset:CGPointMake(offsetx, 0) animated:NO];
    }else{
        b++;
        a = b;
        CGFloat offsetx = b * self.scrollView.frame.size.width;
        [self.scrollView setContentOffset:CGPointMake(offsetx, 0) animated:YES];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NewsModel *model = self.dataArr[indexPath.row];
    if (model.pic_url.length == 0) {
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil][0];
            
            cell.model = model;
            return cell;
        }
    }else{
        NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QYID];
        
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"NewsTableViewCell" owner:self options:nil][0];
            cell.model = model;
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:cell.model.pic_url] placeholderImage:[UIImage imageNamed:@""]];
            return cell;
    }
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VC1Web *WebVC = [[VC1Web alloc] init];
    NewsModel *model = self.dataArr[indexPath.row];
    NSString *string;
    NSString *string1 = [NSString stringWithFormat:@"http://lol.zhangyoubao.com/mobiles/item/"];
    NSString *string2 = [NSString stringWithFormat:@"user_id=16381599&token=66742407f5c24851303d1b8d5cde8148a43&i_=d13c3618f8441be0f5ab862743d6f920c219c1f7&t_=1452409387&p_=30506&v_=40070101&d_=ios&osv_=9.2&version=0&a_=lol&size=middleuser_id=16381599&token=66742407f5c24851303d1b8d5cde8148a43"];
    
    string = [NSString stringWithFormat:@"%@%@%@",string1,model.iD,string2];
    WebVC.urlString = string;
    if (model.viedo_url.length == 0) {
        [self.parentViewController.navigationController pushViewController:WebVC animated:YES];
    }else{
//        
//        http://api.weibo.cn/2/httpdns/config?did=869579016134077&v=6.0.0&s=93af637a&c=httpdns&k=e4982a86a993f9691fe57feb9ef2b200
//        http://api.weibo.cn/2/httpdns/config?did=869579016134077&v=6.0.0&s=93af637a&c=httpdns&k=e4982a86a993f9691fe57feb9ef2b200
        UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"将要使用系统播放器播放该视频" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"");
        }];
        
        UIAlertAction *playAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
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
        
        [alter addAction:cancelAction];
        [alter addAction:playAction];
        
        [self presentViewController:alter animated:YES completion:nil];
    }
    
    
}


#pragma mark - 网络数据请求
-(void)loadDataFromNet
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:@"http://lol.zhangyoubao.com/apis/rest/ItemsService/lists?cattype=news&catid=10178&page=1&i_=d13c3618f8441be0f5ab862743d6f920c219c1f7&t_=1452244808&p_=16769&v_=40070101&d_=ios&osv_=9.2&version=0&a_=lol" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"%@",dic);
        NSArray *tempArr = dic[@"data"];
        
        self.dataArr = [NSMutableArray array];
        
        for (NSDictionary *dic in tempArr) {
            NewsModel *news = [[NewsModel alloc] initWithDic:dic];
            
            [self.dataArr addObject:news];
        }
        
        [_tableView1 reloadData];
        
        [_refreshControl endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (_tableView1.contentOffset.y > (_tableView1.contentSize.height - _tableView1.frame.size.height) + 150) {
//        [self loadMoreSource];
//    }
//}


#pragma mark - 上拉加载更多
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_tableView1.contentOffset.y > (_tableView1.contentSize.height - _tableView1.frame.size.height) + 50) {
        [self loadMoreSource];
    }
}
-(void)loadMoreSource
{
    
    NSString *UrlString = [NSString stringWithFormat:@"http://lol.zhangyoubao.com/apis/rest/ItemsService/lists?cattype=news&catid=10178&page=%lu&i_=d13c3618f8441be0f5ab862743d6f920c219c1f7&t_=1452244808&p_=16769&v_=40070101&d_=ios&osv_=9.2&version=0&a_=lol",(self.dataArr.count/10 +1)];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager GET:UrlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"%@",dic);
        NSArray *tempArr = dic[@"data"];
        
        for (NSDictionary *dic in tempArr) {
            NewsModel *news = [[NewsModel alloc] initWithDic:dic];
            
            [self.dataArr addObject:news];
        }
        NSLog(@"%ld",self.dataArr.count);


        [_tableView1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

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
