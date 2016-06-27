//
//  TopicController.m
//  百思不得姐
//
//  Created by MAX on 16/5/25.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "TopicController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.m"
#import "topicModel.h"
#import "wordCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "CommentViewController.h"
#import "NewViewController.h"

@interface TopicController ()
@property (nonatomic,strong)NSMutableArray *topicsArr;
//当前页码
@property (nonatomic,assign)NSInteger page;
//下载下一页数据时需要这个
@property (nonatomic,copy)NSString *maxtime;

//创建manager
@property (nonatomic,strong)AFHTTPSessionManager *manager;
//上一次请求参数
@property (nonatomic,strong)NSDictionary *params;

//上次选中的索引
@property (nonatomic,assign)NSInteger lastSelectedIndex;
@end

@implementation TopicController


static  NSString *cellID = @"wordCell";
//懒加载 全局都使用这个manager
-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

-(NSArray *)topicsArr
{
    if (!_topicsArr) {
        _topicsArr = [NSMutableArray array];
    }
    return _topicsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化表格
    [self setupTableView];
    
    //添加刷新空间
    [self setupRefresh];
    
}

#pragma mark -初始化tableView
-(void)setupTableView
{
    
    //设置内边距（这个范围里面可以加在子空间）
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = TitlesViewH + TitlesViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    //设置滚动条内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([wordCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    
    self.tableView.backgroundColor = [UIColor grayColor];
    
    //监听tabbar点击的通知
    [WWNoteCenter addObserver:self selector:@selector(tabbarSelect) name:TabBarDidSelectNotification object:nil];
}

-(void)tabbarSelect
{
    
    
    //如果是连续选中2次，直接刷新
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && self.tabBarController.selectedViewController != self.navigationController && self.view.isShowingOnKeyWindow) {
        [self.tableView.mj_header beginRefreshing];

    }
    WWLogFunc;
    //记录这一次选中的索引
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}
#pragma mark - 刷新控件
-(void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark - a参数
-(NSString *)a
{
    //判断是新帖还是精华控制器
    return  [self.parentViewController isKindOfClass:[NewViewController class ]] ? @"newlist" :@"list";
}

#pragma mark - 数据处理
//加载新帖
-(void)loadNewTopics
{
    //结束上啦
    [self.tableView.mj_footer endRefreshing];
    
    //请求
    NSMutableDictionary *params = [[NSMutableDictionary dictionary] init];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    //存储上一次的数据
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
        //        （防止两次刷新）防止上次一请求参数和这一次不一样
        if (self.params != params)return ;
        //        存储返回数据maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topicsArr =[topicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        //页码
        self.page = 0;
        //         WWLog(@"%@",responseObject);
        //         //请求放桌面
        //         [responseObject writeToFile:@"/Users/max/Desktop/duanzi.plist" atomically:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WWLog(@"失败");
        //（防止两次刷新）防止上次一请求参数和这一次不一样
        if (self.params != params) {
            return ;
        }
        
        [self.tableView.mj_header endRefreshing];
    }];
}

//记载更多数据
-(void)loadMoreTopics
{
    [self.tableView.mj_header endRefreshing];
    
    //页码
    NSInteger page = self.page+1;
    //请求
    NSMutableDictionary *params = [[NSMutableDictionary dictionary] init];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        //（防止两次刷新）防止上次一请求参数和这一次不一样
        //        if (self.params != params) {
        //            [self.tableView.mj_footer endRefreshing];
        //            return ;
        //        }
        
        
        //存储返回数据maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *newtopicsArr =[topicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topicsArr addObjectsFromArray:newtopicsArr];
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
        //成功＋1
        self.page++;
        //         WWLog(@"%@",responseObject);
        //         //请求放桌面
        //         [responseObject writeToFile:@"/Users/max/Desktop/duanzi.plist" atomically:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        WWLog(@"失败");
        //（防止两次刷新）防止上次一请求参数和这一次不一样
        if (self.params != params) {
            return ;
        }
        
        
        [self.tableView.mj_footer endRefreshing];
        //恢复页码
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topicsArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    wordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[wordCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.topicModel = self.topicsArr[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    topicModel *topicModel = self.topicsArr[indexPath.row];
  
    return topicModel.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentViewController *commentVC = [[CommentViewController alloc] init];
    commentVC.topicModel = self.topicsArr[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:YES];
    
}

#pragma mark - 销毁请求
-(void)dealloc
{
    //控制器销毁时候 同时销毁本次的请求管理者manager
    [self.manager.operationQueue cancelAllOperations];
}
@end
