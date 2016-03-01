//
//  AllHeros.m
//  掌游宝
//
//  Created by qingyun on 16/1/12.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "AllHeros.h"
//#import "searchVC.h"
//#import "JHCustomMenu.h"
#import "HerosModel.h"
#import "AllHersoCell.h"
#import "signleHerosVC.h"
#import "UIImageView+WebCache.h"

@interface AllHeros ()<UICollectionViewDataSource,UICollectionViewDelegate>
//@property (nonatomic, strong) JHCustomMenu *menu;
@property (nonatomic, strong) UICollectionView *collcetionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
//#define KWidth self.view.frame.size.width
#define KWidth [UIScreen mainScreen].bounds.size.width
@implementation AllHeros
static NSString *QYID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setSeachBar];
//    [self selectedClick];
    [self setSubView];
    [self json];
}


#pragma mark - LoadSubview
-(void)setSubView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    flowLayout.itemSize = CGSizeMake(75, 100);
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.minimumLineSpacing = 1;
    
    _collcetionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height- 150) collectionViewLayout:flowLayout];
    _collcetionView.backgroundColor = [UIColor whiteColor];
    _collcetionView.delegate = self;
    _collcetionView.dataSource = self;
    [self.view addSubview:_collcetionView];
    
    [_collcetionView registerNib:[UINib nibWithNibName:@"AllHersoCell" bundle:nil] forCellWithReuseIdentifier:QYID];
    
}

#pragma mark - UICollcetionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AllHersoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:QYID forIndexPath:indexPath];
    HerosModel *model = self.dataArray[indexPath.item];
    cell.model = model;
    NSString *string;
    NSString *string1 = [NSString stringWithFormat:@".jpg"];
    string = [NSString stringWithFormat:@"%@%@",model.duoname,string1];
//    cell.imgView.image = [UIImage imageNamed:string];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    return cell;
    
}

#pragma mark - CollectionViewSelect
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    signleHerosVC *select = [[signleHerosVC alloc] init];
    [self.navigationController pushViewController:select animated:YES];
    HerosModel *model = self.dataArray[indexPath.item];
    select.nameLabelText = model.name;
    select.filterLabelText = model.filter;
    select.moneyLabelText = model.money;
    select.pointLabeltext = model.point;
    select.iconname = model.duoname;
    select.pic_url = model.pic_url;
    select.id = model.id;
    select.hidesBottomBarWhenPushed = YES;
}
#pragma mark - SeachBar
/*
-(void)setSeachBar
{
    UIButton *seachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    seachBtn.frame = CGRectMake(0, 0, KWidth, 30);
    seachBtn.backgroundColor = [UIColor grayColor];

    [self.view addSubview:seachBtn];
    
    [seachBtn addTarget:self action:@selector(seachView) forControlEvents:UIControlEventTouchUpInside];
}
*/
#pragma mark - JSON解析
-(void)json
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"herolist" withExtension:@"json"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *tempArr = dic[@"data"];
    
    self.dataArray = [NSMutableArray array];
    
    for (NSDictionary *dic in tempArr) {
        HerosModel *heros = [[HerosModel alloc] initWithDic:dic];
        
        [self.dataArray addObject:heros];
    }
    [_collcetionView reloadData];
}
#pragma mark - UIButton
/*
-(void)selectedClick{
    UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    typeBtn.frame = CGRectMake(0, 30, (KWidth / 3), 30);
    [typeBtn setTitle:@"类型" forState:UIControlStateNormal];
    typeBtn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:typeBtn];
    typeBtn.tag = 100;
    [typeBtn addTarget:self action:@selector(TypeList:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    priceBtn.frame = CGRectMake((KWidth / 3), 30, KWidth / 3, 30);
    [priceBtn setTitle:@"价格" forState:UIControlStateNormal];
    priceBtn.backgroundColor = [UIColor blackColor];
    priceBtn.tag = 101;
    [self.view addSubview:priceBtn];
    [priceBtn addTarget:self action:@selector(TypeList:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    publishBtn.frame = CGRectMake((KWidth / 3)*2, 30, KWidth / 3, 30);
    [publishBtn setTitle:@"发布版本" forState:UIControlStateNormal];
    publishBtn.backgroundColor = [UIColor blackColor];
    publishBtn.tag = 102;
    [self.view addSubview:publishBtn];
    [publishBtn addTarget:self action:@selector(TypeList:) forControlEvents:UIControlEventTouchUpInside];
}
*/
/*
-(void)TypeList:(UIButton *)button
{
    __weak __typeof(self) weakSelf = self;
    if (!self.menu) {
        switch (button.tag) {
            case 100:
                self.menu = [[JHCustomMenu alloc] initWithDataArr:@[@"辅助",@"法师",@"射手",@"刺客",@"战士",@"坦克"] origin:CGPointMake(0, 60) width:125 rowHeight:44];
                break;
                
            case 101:
                self.menu = [[JHCustomMenu alloc] initWithDataArr:@[@"点券",@"金币"] origin:CGPointMake(((KWidth / 3)), 60) width:125 rowHeight:44];
                break;
                
            case 102:
                self.menu = [[JHCustomMenu alloc] initWithDataArr:@[@"最新发布",@"名字排序"] origin:CGPointMake((KWidth / 3)*2 - 10, 60) width:115 rowHeight:44];
                break;
                
            default:
                break;
        }
//        self.menu = [[JHCustomMenu alloc] initWithDataArr:@[@"辅助",@"法师",@"射手",@"刺客",@"战士",@"坦克"] origin:CGPointMake(0, 60) width:125 rowHeight:44];
        _menu.delegate = self;
        _menu.dismiss = ^(){
            weakSelf.menu = nil;
        };
        
        [self.view addSubview:_menu];
    }else{
        [_menu dismissWithCompletion:^(JHCustomMenu *object) {
            weakSelf.menu = nil;
        }];
    }
}

 */
-(void)jhCustomMenu:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select:%ld",indexPath.row);
}
/*
-(void)seachView
{
    searchVC *search = [[searchVC alloc] init];
    [self presentViewController:search animated:YES completion:nil];
    
}
*/
@end
