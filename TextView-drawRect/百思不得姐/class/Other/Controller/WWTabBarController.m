//
//  WWTabBarController.m
//  百思不得姐
//
//  Created by MAX on 16/5/13.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "WWTabBarController.h"
#import "essenceViewController.h"
#import "NewViewController.h"
#import "FiendTrendsViewController.h"
#import "MeViewController.h"
#import "WWTabBar.h"
#import "WWNavigationController.h"
@interface WWTabBarController ()

@end

@implementation WWTabBarController

+(void)initialize
{
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    //通过appearance统一设置所有UITabBarItem的文字属性
    //后面带有UI_APPEARANCE_SELECTOR 可以通过appearance统一设置
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //添加子控制器
    essenceViewController *vc01 = [[essenceViewController alloc] init];
    [self setupChildVc:vc01 title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    NewViewController *vc02 = [[NewViewController alloc] init];
    [self setupChildVc:vc02 title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    FiendTrendsViewController *vc03 = [[FiendTrendsViewController alloc] init];
    [self setupChildVc:vc03 title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    MeViewController *vc04 = [[MeViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self setupChildVc:vc04 title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //更换自定义tabbar
    [self setValue:[[WWTabBar alloc] init] forKeyPath:@"tabBar"];
    
   
}


//初始化子控制器
-(void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    vc.title = title; 
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];

    //包装一个导航控制器，添加导航控制器为tabbarcontroller的子控制器
    WWNavigationController *nav = [[WWNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


@end
