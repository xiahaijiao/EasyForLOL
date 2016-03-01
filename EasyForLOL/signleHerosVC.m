//
//  signleHerosVC.m
//  掌游宝
//
//  Created by qingyun on 16/1/13.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "signleHerosVC.h"
#import "HeroSkills.h"
#import "UIImageView+WebCache.h"
#import "HeroSkillCells.h"
#import "NSString+StringSize.h"
//#include "MDHTMLLabel.h"
@interface signleHerosVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *filter;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *point;
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (nonatomic, strong) NSString *role_id;
@property (nonatomic, strong) NSMutableArray *dataArray;
//@property (nonatomic, strong) MDHTMLLabel *htmlLabel;

@end

@implementation signleHerosVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.rowHeight = 200;
    self.name.text = _nameLabelText;
    self.filter.text = _filterLabelText;
    self.money.text = _moneyLabelText;
    self.point.text = _pointLabeltext;
    self.pic_url = _pic_url;
    self.id = _id;
    self.title = @"英雄介绍";
    NSString *string = [NSString stringWithFormat:@"%@.jpg",_iconname];
    [_iconImg sd_setImageWithURL:[NSURL URLWithString:_pic_url] placeholderImage:[UIImage imageNamed:string]];

    _filter.layer.cornerRadius = 5;
    _filter.layer.masksToBounds = YES;
    [self json];
    _tableView = [[UITableView alloc] init];
    _tableView.rowHeight = 44.0f;
    _tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


-(void)setcell
{
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HeroSkillCells *cell;
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"HeroSkillCells" owner:self options:nil][0];
    }
    HeroSkills *model = self.dataArray[indexPath.row];
    [cell.skill sd_setImageWithURL:[NSURL URLWithString:model.pic_url]];
    cell.model = model;
//    _htmlLabel.htmlText = cell.model.desc;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - JOSN解析

-(void)json
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"heroskills" withExtension:@"json"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *tempArr = dic[@"data"];
    
    self.dataArray = [NSMutableArray array];

    for (NSDictionary *dic in tempArr) {
        HeroSkills *skills = [[HeroSkills alloc] initWithDic:dic];
        if (_id == skills.role_id) {
            [self.dataArray addObject:skills];
        }
        
    }
    [_tableView reloadData];
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
