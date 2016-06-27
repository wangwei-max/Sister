//
//  MeViewController.m
//  百思不得姐
//
//  Created by MAX on 16/5/13.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "MeViewController.h"
#import "MeCell.h"
#import "MeFootView.h"

@interface MeViewController ()<UITableViewDataSource>

@end


@implementation MeViewController

static NSString *const  MeID= @"meCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏内容
    [self setupNav];
    
    //tableView
    [self setupTableView];
    
}

-(void)setupNav;
{
    self.navigationItem.title = @"我的";
    
    self.navigationItem.rightBarButtonItems = @[
                                                [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" action:@selector(settingClick) target:self],
                                                [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" action:@selector(moonClick) target:self]
                                                ];
}

-(void)setupTableView
{
    self.view.backgroundColor = WWGLOBALBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MeCell class] forCellReuseIdentifier:MeID];
    
    //调整header 和 footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    //设置footview
    self.tableView.tableFooterView = [[MeFootView alloc] init];
}
-(void)settingClick
{
    WWLogFunc;
}

-(void)moonClick
{
    WWLogFunc;
}
#pragma mark -数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeCell *cell = [tableView dequeueReusableCellWithIdentifier:MeID];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine-moon-icon-click"];
        cell.textLabel.text = @"登陆／注册";
    }else if(indexPath.section == 1)
    {
        cell.imageView.image = [UIImage imageNamed:@"mine-setting-icon-click"];
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}

@end
