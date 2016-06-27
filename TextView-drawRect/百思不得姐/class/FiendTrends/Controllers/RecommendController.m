//
//  RecommendController.m
//  百思不得姐
//
//  Created by MAX on 16/5/17.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "RecommendController.h"
#import "AFNetworking.h"
#import <SVProgressHUD.h>
#import "RecommendCell.h"
#import <MJExtension.h>
#import "recommendCategory.h"
#import "userCell.h"
#import "UserModel.h"
#import "MJRefresh.h"

#define WWSelectedCategory self.categories[self.recommendTV.indexPathForSelectedRow.row]
@interface RecommendController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *recommendTV;
@property (weak, nonatomic) IBOutlet UITableView *usertableview;
@property (nonatomic,strong)NSArray *categories;

//请求参数
@property (strong,nonatomic) NSMutableDictionary *params;

@property (strong,nonatomic) AFHTTPSessionManager *manager;
@end

@implementation RecommendController

//设置cellId
static NSString *categoryId = @"category";
static NSString *userId = @"user";

-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化
    [self setupTableView];
    
    //添加刷新空间
    [self setupRefresh];
    
    //加载左侧的类数据
    [self loadCategory];
   }

-(void)loadCategory
{
    //显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeCustom];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.categories = [recommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.recommendTV reloadData];
        //默认选中第一行
        [self.recommendTV selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:(UITableViewScrollPositionTop)];
        //让用户表格一进来刷新状态
        [self.usertableview.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SVProgressHUD *hud = [[SVProgressHUD alloc] init];
        hud.minimumDismissTimeInterval = 1.5;
        [SVProgressHUD showErrorWithStatus:@"信息加载失败"];
    }];

}

-(void)setupTableView
{
    [self.recommendTV registerNib:[UINib nibWithNibName:NSStringFromClass([RecommendCell class]) bundle:nil] forCellReuseIdentifier:@"category"];
    
    [self.usertableview registerNib:[UINib nibWithNibName:NSStringFromClass([userCell class]) bundle:nil] forCellReuseIdentifier:@"user"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.recommendTV.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.usertableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.usertableview.rowHeight = 70;
    self.title = @"推荐关注";
    self.view.backgroundColor = WWGLOBALBg;
    
    
}

-(void)setupRefresh
{
    //下拉
    self.usertableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    //上啦刷新
    self.usertableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];//    self.usertableview.mj_footer
    self.usertableview.mj_footer.hidden = YES;
}

#pragma mark - 加载用户数据
//上啦刷新
-(void)loadNewUsers
{
    recommendCategory *Model= WWSelectedCategory;
    // 发送请求给服务器
    
    //设置当前页码为1
    Model.currentPage = 1 ;
    
    //发送请求，加载右边数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(Model.ID);
    params[@"page"] = @(Model.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
       
        //字典数组 转 模型数组
        NSArray *users = [UserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //清除所有数据
        [Model.user removeAllObjects];
        
        //添加到当前类别对应的用户数组中
        [Model.user addObjectsFromArray:users];
        
        //保存总数
        Model.total = [responseObject[@"total"] integerValue];
        
        //不适最后一次请求
        if (self.params != params) {
            return ;
        }
        
        [self.usertableview reloadData];
        
        //结束刷新
        [self.usertableview.mj_header endRefreshing];
        
        //让底部空间结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params !=params) {
            return ;
        }
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        
        [self.usertableview.mj_header endRefreshing];
    }];

}

-(void)loadMoreUsers
{
    recommendCategory *category = WWSelectedCategory;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.ID);
    params[@"page"] = @(++category.currentPage);
    self.params=params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
       
        //字典数组 转 模型数组
        NSArray *users = [UserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加到当前类别对应的用户数组中
        [category.user addObjectsFromArray:users];
        
        
        if (self.params !=params) {
            return ;
        }
        
        [self.usertableview reloadData];
 
        //让底部空间结束刷新（判断底部刷新空间）
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params !=params) {
            return ;
        }
        [SVProgressHUD showErrorWithStatus:@"加载数据失败"];
        
        //让底部空间结束刷新
        [self.usertableview.mj_footer endRefreshing];
    }];
}

//让底部空间结束刷新状态（判断底部刷新空间）
-(void)checkFooterState
{
    recommendCategory *CategoryModel = self.categories[self.recommendTV.indexPathForSelectedRow.row];
    
    // 每次刷新有变数据时，都控制footer显示或yinc
    self.usertableview.mj_footer.hidden = (CategoryModel.user.count==0);
    
    //让底部空间结束刷新（判断底部刷新空间）
    if (CategoryModel.user.count == CategoryModel.total) {
        //全部数据加载完毕
        [self.usertableview.mj_footer endRefreshingWithNoMoreData];
    }
    else
    {
        //还没有加载完毕
        [self.usertableview.mj_footer endRefreshing];
    }
}

#pragma mark - <tableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //左边的类别表格
    if (tableView == self.recommendTV)return self.categories.count;
    
    //右边的用户表格
    //让底部空间结束刷新状态
    [self checkFooterState];
    //左边被选中的类别模型
    recommendCategory *CategoryModel = self.categories[self.recommendTV.indexPathForSelectedRow.row];
    //返回右边数据
    return CategoryModel.user.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.recommendTV) {
        RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryId];
        if (!cell) {
            cell = [[RecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:categoryId];
        }
        //设置cell属性
        cell.category = self.categories[indexPath.row];
        
        return cell;
    }
    else
    {
        userCell *cell = [tableView dequeueReusableCellWithIdentifier:userId];
        if (!cell) {
            cell = [[userCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:userId];
        }
        //设置cell属性］］
        recommendCategory *CategoryModel = self.categories[self.recommendTV.indexPathForSelectedRow.row];
        
        cell.usermodel = CategoryModel.user[indexPath.row];
        return cell;
    }

}
//

#pragma mark - <tableViewDatadelegate>
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //结束刷新
    [self.usertableview.mj_header endRefreshing];
    [self.usertableview.mj_footer endRefreshingWithNoMoreData];
    
    recommendCategory *Model = self.categories[indexPath.row];
    
    if (Model.user.count) {
        //有曾经数据
        [self.usertableview reloadData];
    }
    else
    {
        //立即刷新表格，目的：马上显示当前的category的用户数据，不让用户看见上一个category的数据；
        [self.usertableview reloadData];
    
        //进入下拉刷新状态
        [self.usertableview.mj_header beginRefreshing];
    }
}

#pragma mark - 销毁请求
-(void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
}
@end
