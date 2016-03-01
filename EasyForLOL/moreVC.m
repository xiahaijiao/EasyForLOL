//
//  moreVC.m
//  掌游宝
//
//  Created by qingyun on 15/12/10.
//  Copyright © 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "moreVC.h"
//#import "moreModel.h"
#import "QYMoreCell.h"
#import "VC1Web.h"
#import "SDImageCache.h"
#import "MBProgressHUD.h"
@interface moreVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UICollectionView *collcetionView;
@property (nonatomic, strong) NSArray *more;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MBProgressHUD *HUD;
@end

@implementation moreVC
static NSString *QYID = @"moreCell";
//懒加载
/*
-(NSArray *)more
{
    if (_more == nil ) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"more" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            moreModel *model = [moreModel moreWithDict:dict];
            [models addObject:model];
        }
        _more = models;
    }
    return _more;
}
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    _tableView.alwaysBounceVertical = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
/*
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    flowLayout.itemSize = CGSizeMake(93, 100);
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.minimumLineSpacing = 1;
    _collcetionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    _collcetionView.backgroundColor = [UIColor lightGrayColor];
    _collcetionView.delegate = self;
    _collcetionView.dataSource = self;
    [self.view addSubview:_collcetionView];
    _collcetionView.alwaysBounceVertical = NO;
    
    [_collcetionView registerNib:[UINib nibWithNibName:@"QYMoreCell" bundle:nil] forCellWithReuseIdentifier:QYID];
 */
    [self setNavigationBar];
 
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }else
        return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.section == 0) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"战绩查询";
            cell.imageView.image = [UIImage imageNamed:@"战绩查询"];
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"战斗力查询";
            cell.imageView.image = [UIImage imageNamed:@"战斗力查询"];
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"隐藏分查询";
            cell.imageView.image = [UIImage imageNamed:@"隐藏分查询"];
        }else if (indexPath.row == 3){
            cell.textLabel.text = @"Rank大神榜";
            cell.imageView.image = [UIImage imageNamed:@"Rank排行榜"];
        }
        
    }else{
       
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
        cell.imageView.image = [UIImage imageNamed:@"清理垃圾"];
        cell.textLabel.text = @"清理缓存";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}
/*
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.more.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    QYMoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QYID forIndexPath:indexPath];
    
    cell.Mmodel = self.more[indexPath.item];
    return cell;
 
}
 */
-(void)setNavigationBar
{
    //设置左边的barBtnItem
    UIBarButtonItem *lefeBarBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:nil];
    lefeBarBtnItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = lefeBarBtnItem;
    
    //设置titleView
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"设置"];
    self.navigationItem.title = label.text;
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *originalImage = [UIImage imageNamed:@"shezhixuanzhong"];
        originalImage = [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:[UIImage imageNamed:@"shezhi"] selectedImage:originalImage];
        self.tabBarItem = tabBarItem;
        self.tabBarController.tabBar.translucent = NO;
    }
    return self;
}
 

#pragma mark - 选中方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    VC1Web *webVC = [[VC1Web alloc] init];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSString *url = [NSString stringWithFormat:@"http://lol.duowan.com/zdl/"];
            webVC.urlString = url;
            [self.navigationController pushViewController:webVC animated:YES];
        }else if (indexPath.row == 1){
            NSString *url = [NSString stringWithFormat:@"http://lol.duowan.com/zdl/"];
            webVC.urlString = url;
            [self.navigationController pushViewController:webVC animated:YES];
        }else if (indexPath.row ==2){
            NSString *url = [NSString stringWithFormat:@"http://lol.52pk.com/zhuanti/6064872.shtml"];
            webVC.urlString = url;
            [self.navigationController pushViewController:webVC animated:YES];
        }else if (indexPath.row == 3){
            NSString *url = [NSString stringWithFormat:@"http://lolbox.duowan.com/rankScoreRank.php"];
            webVC.urlString = url;
            [self.navigationController pushViewController:webVC animated:YES];
        }
    }else if (indexPath.section == 1){
        NSLog(@"清理缓存");
        _HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_HUD];
        //如果设置此属性当前的view置于后台
        _HUD.dimBackground = YES;
        //设置对话框文字
        _HUD.labelText = @"正在清理";
        //设置模式
        _HUD.mode = MBProgressHUDModeDeterminate;
        
        //显示对话框
        [_HUD showAnimated:YES whileExecutingBlock:^{
            float progress = 0.0f;
            while (progress < 1.0f) {
                progress += 0.01f;
                _HUD.progress = progress;
                usleep(50000);
            }
        } completionBlock:^{
            [_HUD removeFromSuperview];
            _HUD = nil;
            
            
            _HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:_HUD];
            _HUD.labelText = @"清理完成";
            _HUD.mode = MBProgressHUDModeText;
            
            [_HUD showAnimated:YES whileExecutingBlock:^{
                sleep(1);
            } completionBlock:^{
                [_HUD removeFromSuperview];
                _HUD = nil;
            }];
            
        }];
        
        [[SDImageCache sharedImageCache]cleanDisk];
//        [[SDImageCache sharedImageCache] getSize];
        UILabel *l = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
        l.text = @"qingliwangcheng";
//        [self.view addSubview:l];
    }
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
