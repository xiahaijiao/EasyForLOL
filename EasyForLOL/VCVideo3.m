//
//  VCVideo3.m
//  掌游宝
//
//  Created by qingyun on 15/12/11.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "VCVideo3.h"
#import "V3Model.h"
#import "QYCollectionViewCell.h"
#import "videoList.h"
#import <AFNetworking.h>
#import "UIImageView+WebCache.h"
@interface VCVideo3 ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *VideoVC2;
@end

@implementation VCVideo3
static NSString *QYID = @"collectionCell";
-(NSArray *)VideoVC2
{
    if (_VideoVC2 == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"VideoVC2" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            V3Model *model = [V3Model VTModelWithDict:dict];
            [models addObject:model];
        }
        _VideoVC2 = models;
    }
    return _VideoVC2;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor whiteColor];
    //流布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //滚动方向 竖直方向
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //设置item的size
    flowLayout.itemSize = CGSizeMake(100, 140);
    //item之间的距离
    flowLayout.minimumInteritemSpacing = 0;
    //行间距
    flowLayout.minimumLineSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 144) collectionViewLayout:flowLayout];
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor whiteColor];

    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"QYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:QYID];
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.VideoVC2.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QYID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"QYCollectionViewCell" owner:self options:nil][0];
    }
    cell.V3 = self.VideoVC2[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    videoList *List = [[videoList alloc] init];

    V3Model *model = self.VideoVC2[indexPath.item];
    
    List.pic_url = model.pic_url;
    List.name = model.name;
    List.desc = model.desc;
    List.VideoId = model.videoID;
    
    NSString *urlString = [NSString stringWithFormat:@"http://lol.zhangyoubao.com/apis/rest/ItemsService/videos?catwordid=%@&page=1&i_=8643e740dfbf96c2b19f80810eed4f856c82d3f6&t_=1453341695&p_=7430&v_=40070204&d_=ios&osv_=9.2&version=0&a_=lol",model.videoID];
    List.urlString = urlString;
    List.hidesBottomBarWhenPushed = YES;
    [self.parentViewController.navigationController pushViewController:List animated:YES];
    
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
