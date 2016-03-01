//
//  VCVideo1.m
//  掌游宝
//
//  Created by qingyun on 15/12/11.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "VCVideo1.h"
#import <AFNetworking.h>
#import "videoModel.h"
#import "videoList.h"

@interface VCVideo1 ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation VCVideo1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubView];
//    [self loadDataFromNet];
}


-(void)loadSubView
{
    //流布局
    UICollectionViewFlowLayout *FlowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //滚动方向
    [FlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //设置item的size
    FlowLayout.itemSize = CGSizeMake(100, 140);
    //间距
    FlowLayout.minimumInteritemSpacing = 5 ;
    //行间距
    FlowLayout.minimumLineSpacing = 5;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 144) collectionViewLayout:FlowLayout];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_collectionView];
}

#pragma mark - UICollcetionViewDatasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - 网络数据请求
-(void)loadDataFromNet
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:@"http://lol.zhangyoubao.com/apis/rest/CatalogsService/all?cattype=video&i_=8643e740dfbf96c2b19f80810eed4f856c82d3f6&t_=1453341672&p_=7361&v_=40070204&d_=ios&osv_=9.2&version=0&a_=lol" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"%@",dic);
        
        NSArray *tempArr = dic[@"data"];
        self.dataArray = [NSMutableArray array];
        
        for (NSDictionary *dic in tempArr) {
            videoModel *model = [[videoModel alloc] initWithDic:dic];
            [self.dataArray addObject:model];
        }
        
        [_collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}

#pragma mark - 代理点击选中事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    videoList *ListVC = [[videoList alloc] init];
    [self.navigationController pushViewController:ListVC animated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
