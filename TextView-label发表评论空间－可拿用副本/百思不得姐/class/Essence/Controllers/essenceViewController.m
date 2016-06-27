//
//  essenceViewController.m
//  百思不得姐
//
//  Created by MAX on 16/5/13.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "essenceViewController.h"
#import "RecommendTagsControllersTableViewController.h"
#import "TopicController.h"

@interface essenceViewController ()<UIScrollViewDelegate>

//底部红色指示器
@property (nonatomic,weak) UIView *indicatorView;

//当前选中的按钮
@property (nonatomic,weak) UIButton *selectedView;

//顶部所有的标签
@property (nonatomic,weak) UIView *titleView;

@property (nonatomic,weak) UIScrollView *contentView;
@end

@implementation essenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];//导航栏添加左右按钮和中间文字
    
    [self setupChildVcs];//初始化子控制器
   
    [self setupTitleView];//头部标签栏
    
    [self setupContantView];//底部的scrollView
    
    
}

-(void)setupChildVcs
{
    
    TopicController *allVc = [[TopicController alloc]init];
    allVc.type = TypeAll;
    [self addChildViewController:allVc];
    
    TopicController *videoVc = [[TopicController alloc] init];
    videoVc.type = TypeVideo;
    [self addChildViewController:videoVc];
    
    TopicController *vocieVc = [[TopicController alloc]init];
    vocieVc.type = TypeVoice;
    [self addChildViewController:vocieVc];
    
    TopicController *pictureVc = [[TopicController alloc]init];
    pictureVc.type = TypePicture;
    [self addChildViewController:pictureVc];
    
    TopicController *wordVc = [[TopicController alloc]init];
    wordVc.type = TypeWord;
    [self addChildViewController:wordVc];
}


/**
 *底部的scrollView
 */
-(void)setupContantView
{
    //不自动调整insent
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    //添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
}

//头部标签栏
-(void)setupTitleView
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
    titlesView.width = self.view.width;
    titlesView.height = TitlesViewH;
    titlesView.y = TitlesViewY;
    [self.view addSubview:titlesView];
    self.titleView = titlesView;
   
    //底部红色条（指示器）
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    indicatorView.tag = -1;
//    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
     //自标签
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSInteger count = titles.count ;
    CGFloat childViewW = self.view.width/count;
    CGFloat childViewY = 0;
    CGFloat childViewH = titlesView.height;
    for (NSInteger i = 0; i < count; i++) {
        CGFloat childViewX = childViewW*i;
        UIButton *childView = [[UIButton alloc] initWithFrame:CGRectMake(childViewX, childViewY, childViewW, childViewH)];
        childView.tag = i;
        [childView setTitle:titles[i] forState:UIControlStateNormal];
        childView.titleLabel.font = [UIFont systemFontOfSize:12];
        [childView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [childView setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [childView addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:childView];
        
        //第一个现实为红色
        if (i == 0) {
            childView.enabled = NO;
            self.selectedView = childView;
            
            //让按钮内部的label根据文字计算宽度尺寸
            [childView.titleLabel sizeToFit];
            self.indicatorView.width = childView.titleLabel.width;
            self.indicatorView.centerX = childView.centerX;
        }
    }
    
 [titlesView addSubview:indicatorView];
    
}

-(void)titleClick:(UIButton *)button
{
    //修改按钮状态
    self.selectedView.enabled = YES; //上一次可以点击
    button.enabled = NO;//当前按钮不能点击
    self.selectedView = button;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
    
}

//导航栏
-(void)setupNav
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" action:@selector(tagClick) target:self];
    
    self.view.backgroundColor = WWGLOBALBg;
}

-(void)tagClick
{
    RecommendTagsControllersTableViewController *RecommendTags = [[RecommendTagsControllersTableViewController alloc] init];
    
    
    [self.navigationController pushViewController:RecommendTags animated:YES];
}

#pragma mark -- UIScrollViewDelegate
//滚动完后执行的方法
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
   //添加子控制器的view
    
    //当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0 ;
    vc.view.height = scrollView.height;
    [scrollView addSubview:vc.view];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    //假设点击按钮
    [self titleClick:self.titleView.subviews[index]];
}
@end
