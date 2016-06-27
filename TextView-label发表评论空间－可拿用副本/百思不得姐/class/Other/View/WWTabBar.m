//
//  WWTabBar.m
//  百思不得姐
//
//  Created by MAX on 16/5/13.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "WWTabBar.h"
#import "PublishView.h"
#import "PostWordViewController.h"
#import "WWNavigationController.h"

@interface WWTabBar ()
@property (nonatomic,weak)UIButton *pulishButton;


@end

@implementation WWTabBar
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置tabbar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        //添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"]forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.pulishButton = publishButton;
    }
    return self;
}

-(void)addClick
{
    [PublishView show];
   
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    标记按钮是否已经添加
    static BOOL added = NO;
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    //设置发布按钮位置
    self.pulishButton.frame = CGRectMake(0, 0, self.pulishButton.currentImage.size.width, self.pulishButton.currentImage.size.height);
    self.pulishButton.size = self.pulishButton.currentImage.size;
    self.pulishButton.center = CGPointMake(width * 0.5, height * 0.5);
    //其它tabbar按钮的位置
    CGFloat btnY = 0 ;
    CGFloat btnH = height;
    CGFloat btnW = width/5;
    NSInteger index = 0;
    for (UIControl *btn in self.subviews) {
//        if (![btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        if ((![btn isKindOfClass:[UIControl class]] || btn== self.pulishButton))continue;
        CGFloat btnX = ((index >1)?(index+1):index )*btnW;
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            index ++;
        if (added == NO) {
            //监听按钮的点击
            [btn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpOutside];
        }
        
    }
    added = YES;
}

-(void)buttonClick
{
    //发出一个通知
    [WWNoteCenter postNotificationName:TabBarDidSelectNotification object:nil userInfo:nil];

}
@end
