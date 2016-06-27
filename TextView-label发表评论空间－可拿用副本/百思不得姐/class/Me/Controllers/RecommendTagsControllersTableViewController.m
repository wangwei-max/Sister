//
//  RecommendTagsControllersTableViewController.m
//  百思不得姐
//
//  Created by MAX on 16/5/23.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "RecommendTagsControllersTableViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "recommendCategory.h"
#import "RecommendTagsModel.h"
#import "MJExtension.h"
#import "RecommmendTagCell.h"

@interface RecommendTagsControllersTableViewController ()
@property (nonatomic,strong) NSArray *tagsArr;
@end

static NSString *tagsId = @"tag";

@implementation RecommendTagsControllersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    //发送请求
    [self loadTags];
    
    
}
//发送请求
-(void)loadTags
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"action"] = @"sub";
    params[@"a"] = @"tag_recommend ";
    params[@"c"] = @"topic";
    
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        WWLog(@"%@",responseObject);
        self.tagsArr = [RecommendTagsModel mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"失败"];
        [SVProgressHUD dismiss];
    }];
}

-(void)setupTableView
{
    self.navigationItem.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommmendTagCell class]) bundle:nil] forCellReuseIdentifier:tagsId];
    //tableviewcell分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = WWGLOBALBg;

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tagsArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置cellId
    RecommmendTagCell  *cell = [self.tableView dequeueReusableCellWithIdentifier:tagsId];
   
    cell.recommendTag = self.tagsArr[indexPath.row];
    
    //设置cell属性
    return cell;
}

@end
