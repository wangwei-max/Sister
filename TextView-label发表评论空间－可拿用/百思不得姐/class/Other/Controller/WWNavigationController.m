//
//  WWNavigationController.m
//  百思不得姐
//
//  Created by MAX on 16/5/16.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "WWNavigationController.h"

@implementation WWNavigationController

//第一次使用这个类会掉用一次
+ (void)initialize
{
//    当导航栏用在UINavigationController中，appearance设置才有效果
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite" ] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:20]
                                                                      }];
    //设置item
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //nomtal
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    
    //Disabled
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
    }



-(void)viewDidLoad
{
    [super  viewDidLoad];
   
}
//自定义navigationController
//可以在这个方法中拦截所有push进来的控制器
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count>0) //如果push不是第一个控制器
    {
        UIButton *backBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
//        [backBtn sizeToFit];
    
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        backBtn.size = CGSizeMake(100, 30);
        [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        viewController.hidesBottomBarWhenPushed = YES;
    }

   [super pushViewController:viewController animated:animated];
}

-(void)backClick
{
    [self popViewControllerAnimated:YES];
}
@end
