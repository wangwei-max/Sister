//
//  CommentViewController.m
//  百思不得姐
//
//  Created by MAX on 16/6/17.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "CommentViewController.h"
#import "wordCell.h"
#import "topicModel.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "CommentModel.h"
#import <MJExtension.h>
#import "CommentHeaderView.h"
#import "CommentCell.h";

static NSInteger const HeaderLabelTag = 99;
static NSString  *const commentId = @"commentCell";

@interface CommentViewController ()<UITableViewDelegate,UITableViewDataSource >
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpcae;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 最热评论*/
@property (nonatomic,strong)NSArray *hotComments;

/** 最新评论*/
@property (nonatomic,strong)NSMutableArray *lastComments;

/** 保存帖子的top——cmt*/
@property (nonatomic,strong)NSArray *saved_top_Cmt;

/** 保存当前页码*/
@property (nonatomic,assign) NSInteger page;

/**管理者*/
@property (nonatomic,assign)AFHTTPSessionManager *manager;


@end

@implementation CommentViewController

-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
-(NSMutableArray *)lastComments
{
    if (!_lastComments) {
        _lastComments = [NSMutableArray array];
    }
    return _lastComments;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //基本设置
    [self setupBasic];
    
    [self setupHeader];
    
    [self setupRefresh];
    
    
}

-(void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    //隐藏尾部控件
    self.tableView.mj_footer.hidden = YES;
}
-(void)loadMoreComments
{
    //结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //页码
    NSInteger page = self.page + 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicModel.ID;
    params[@"page"] =@(page);
    CommentModel *cmt = [self.lastComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //最新评论
        NSArray *newComments = [CommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.lastComments addObjectsFromArray:newComments];
        //请求成功后页码赋值
        self.page = page;
        
        //刷新数据
        [self.tableView reloadData];
        
        
        //如果数据刷新第一次加载完了，（之后没有数据） foot隐藏
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.lastComments.count >= total) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else
        {
            //结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
-(void)loadNewComment
{
    //结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicModel.ID;
    params[@"hot"] = @"1";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {//如果返回数据不是字典类型 没有评论数据
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        
        //最热评论
        self.hotComments = [CommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        //最新评论
        self.lastComments = [CommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        //成功后页码赋值
        self.page = 1;

        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        //如果数据刷新第一次加载完了，（之后没有数据） foot隐藏
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.lastComments.count >= total) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        
    }];
}

-(void)setupHeader
{
    //创建header
    UIView *headerView = [[UIView alloc] init];
    
    //清空top——cmt
    if (self.topicModel.top_cmt.count) {
        self.saved_top_Cmt = self.topicModel.top_cmt;
        self.topicModel.top_cmt = nil;
        [self.topicModel setValue:@0 forKey:@"cellHeight"];
    }
    
    //添加cell
    wordCell *cell = [wordCell cell];
    cell.topicModel = self.topicModel;
    cell.size = CGSizeMake(ScreenW, self.topicModel.cellHeight);
    [headerView addSubview:cell];
    
    //header的高度
    headerView.height = self.topicModel.cellHeight +10 ;
    
    //设置header
    self.tableView.tableHeaderView = headerView;
}

-(void)setupBasic
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" action:nil target:nil];
    
    //键盘处理
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybooardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

    self.tableView.backgroundColor = WWGLOBALBg;
    
    //cell自动的高度
    self.tableView.estimatedRowHeight = 44; //估计高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;//自动计算
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CommentCell class]) bundle:nil] forCellReuseIdentifier:commentId];
    
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //tableview 内边距
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
}

-(void)keybooardChangeFrame:(NSNotification *)note
{
    //键盘最后的尺寸
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //屏幕的高度减去－键盘的y值 修改底部约束
    self.bottomSpcae.constant = ScreenH - frame.origin.y;
    
    //动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    //恢复帖子的top——cmt
    if(self.saved_top_Cmt)
    {
        self.topicModel.top_cmt = self.saved_top_Cmt;
        [self.topicModel setValue:@0 forKey:@"cellHeight"];
    }
    
    // 取消请求所有任务
    [self.manager invalidateSessionCancelingTasks:YES];
}

/**返回第section组的所有评论数据*/
-(NSArray *)commentsInSction:(NSInteger)section
{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments :self.lastComments;
    }
    return self.lastComments;
}

-(CommentModel *)commentIndenPath:(NSIndexPath *)indexPath
{
    return [self commentsInSction:indexPath.section][indexPath.row];
}


#pragma mark -- tableView datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCont = self.hotComments.count;
    NSInteger lastCont = self.lastComments.count;
    if (hotCont) return 2;//"最热评论＋最新评论" 2组
    if (lastCont) return 1;//只有最新评论 1组
    return 0;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSInteger hotCount =  self.hotComments.count;
    NSInteger lastCont = self.lastComments.count;
    
    //隐藏尾部控件
    tableView.mj_footer.hidden = (lastCont == 0);
    
    if (section == 0) {
        return hotCount ? hotCount : lastCont;
    }
    //非第0组
    return lastCont;
  
}


/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    no.1
    //创建头部
    UIView *header = [[UIView alloc]init];
    header.backgroundColor = WWGLOBALBg;
    
    //创建label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = WWRGBColoer(67, 67, 67);
    label.width = 200;
    label.x = 10;
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [header addSubview:label];
    
    //设置文字
        NSInteger hotCount =  self.hotComments.count;
        if (section == 0) {
            label.text =  hotCount ? @"最热" : @"最新";
        }
        label.text =  @"最新";
    return header;
    
    NO.2
    static NSString *ID = @"header";
    //先从缓存池中找header
    UITableViewHeaderFooterView *header =  [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    UILabel *label = nil;
    if (header == nil) {//缓存池中没有header 第一次创建label
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:ID];
        header.contentView.backgroundColor = WWGLOBALBg;
        UILabel *label = [[UILabel alloc] init];
        label.textColor = WWRGBColoer(67, 67, 67);
        label.width = 200;
        label.x = 10;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.tag = HeaderLabelTag;
        [header.contentView addSubview:label];
    }
    else//缓存池中取出label
    {
        label = (UILabel *)[header viewWithTag:HeaderLabelTag];
    }
    
    // 设置label数据
    NSInteger hotCount =  self.hotComments.count;
    if (section == 0) {
        label.textColor = [UIColor whiteColor];
        label.text =  hotCount ? @"最热" : @"最新";
    }
    else{
        label.text =  @"最新";
    }
    
    return header;
    
}
 */

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    static NSString *ID = @"header";
    //先从缓存池中找header
    CommentHeaderView *header =  [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {//缓存池中没有header 第一次创建label
        header = [[CommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    // 设置label数据
    NSInteger hotCount =  self.hotComments.count;
    if (section == 0) {
        header.title =  hotCount ? @"最热" : @"最新";
    }
    else{
        header.title =  @"最新";
    }
    
    return header;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentId];
    cell.commentModel = [self commentIndenPath:indexPath];
    return cell;
}
#pragma mark -MenuController处理
#pragma mark -- tableViewdelegate
//tableview滚动时候键盘推出 //滚动时方法
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    //隐藏
    [menu setMenuVisible:NO animated:YES];

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    // 被点击的cell
    CommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //出现第一个响应者
    [cell becomeFirstResponder];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }else
    {
        //显示MenuController
        
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
        menu.menuItems =@[ding,replay,report];
        CGRect rect = CGRectMake(0, cell.height*0.5, cell.width, cell.height);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
    

}

-(void)ding: (UIMenuController *)menu
{
    //当前选中的行
    NSIndexPath *indexPath =  [self.tableView indexPathForSelectedRow];
    NSLog(@"%@",[self commentIndenPath:indexPath].content);
}

-(void)replay: (UIMenuController *)menu
{
    NSIndexPath *indexPath =  [self.tableView indexPathForSelectedRow];
    NSLog(@"%@",[self commentIndenPath:indexPath].content);
}

-(void)report: (UIMenuController *)menu
{
    NSIndexPath *indexPath =  [self.tableView indexPathForSelectedRow];
    NSLog(@"%@",[self commentIndenPath:indexPath].content);
}



@end
