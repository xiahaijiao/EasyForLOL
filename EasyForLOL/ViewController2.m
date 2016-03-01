//
//  ViewController2.m
//  掌游宝
//
//  Created by qingyun on 15/12/10.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController2.h"
#import <AFNetworking.h>
#import "NewsModel.h"
#import "NewsCell.h"
#import "VC1Web.h"
@interface ViewController2 ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ViewController2
#define QYScreenW [UIScreen mainScreen].bounds.size.width
#define QYScreenH [UIScreen mainScreen].bounds.size.height
#define imgCount 6
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadSubView];
    [self loadDataFromNet];
}

-(void)loadSubView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height - 154) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    _tableView = tableView;
    _tableView.rowHeight = 100;
    [self setHeaderView];
    [self.view addSubview:tableView];
    
}

-(void)setHeaderView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 400, QYScreenW, 150)];
    [self.tableView addSubview:_scrollView];
    self.scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(QYScreenW * imgCount, 0);
    
    _scrollView.delegate = self;
    CGFloat imageY = 0;
    CGFloat imageW = QYScreenW;
    CGFloat imageH = 150;
    for (int i = 0; i < imgCount; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        CGFloat imageX = i * QYScreenW;
        imgView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        NSString *name = [NSString stringWithFormat:@"LOL%d",i + 1];
        imgView.image = [UIImage imageNamed:name];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self.scrollView addSubview:imgView];
    }
    _tableView.tableHeaderView = _scrollView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *QYID = @"cell";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:QYID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil][0];
    }
    NewsModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    VC1Web *WebVC = [[VC1Web alloc] init];
    NewsModel *model = self.dataArray[indexPath.row];
    NSString *string1 = [NSString stringWithFormat:@"http://lol.zhangyoubao.com/mobiles/item/"];
    NSString *string2 = [NSString stringWithFormat:@"user_id=16381599&token=66742407f5c24851303d1b8d5cde8148a43&i_=d13c3618f8441be0f5ab862743d6f920c219c1f7&t_=1452409387&p_=30506&v_=40070101&d_=ios&osv_=9.2&version=0&a_=lol&size=middleuser_id=16381599&token=66742407f5c24851303d1b8d5cde8148a43"];
    NSString *url = [NSString stringWithFormat:@"%@%@%@",string1,model.iD,string2];
    WebVC.urlString = url;
    
    [self.navigationController pushViewController:WebVC animated:YES];
}
#pragma mark - 网络请求
-(void)loadDataFromNet
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:@"http://lol.zhangyoubao.com/apis/rest/ItemsService/lists?cattype=news&catid=10000&page=1&i_=d13c3618f8441be0f5ab862743d6f920c219c1f7&t_=1452409123&p_=29714&v_=40070101&d_=ios&osv_=9.2&version=0&a_=lol" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
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
    if (_tableView.contentOffset.y > (_tableView.contentSize.height - _tableView.frame.size.height) + 50) {
        [self loadMoreSource];
    }
}
-(void)loadMoreSource
{
    
    NSString *UrlString = [NSString stringWithFormat:@"http://lol.zhangyoubao.com/apis/rest/ItemsService/lists?cattype=news&catid=10000&page=%lu&i_=d13c3618f8441be0f5ab862743d6f920c219c1f7&t_=1452409123&p_=29714&v_=40070101&d_=ios&osv_=9.2&version=0&a_=lol",(self.dataArray.count/10 +1)];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:UrlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"%@",dic);
        NSArray *tempArr = dic[@"data"];
        
        for (NSDictionary *dic in tempArr) {
            NewsModel *news = [[NewsModel alloc] initWithDic:dic];
            
            [self.dataArray addObject:news];
        }
        NSLog(@"%ld",self.dataArray.count);
        
        
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
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
