//
//  TopWindow.m
//  百思不得姐
//
//  Created by MAX on 16/6/20.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "TopWindow.h"

@implementation TopWindow

static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, ScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)show
{
    window_.hidden = NO;
}

+(void)windowClick
{
    // 1.scrollView
    // 2.keywindow
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInVoew:window];
}

//遍历递归
+(void)searchScrollViewInVoew:(UIView *)superView
{
    for (UIScrollView *subview in superView.subviews) {
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        // 继续查找子控件
        [self searchScrollViewInVoew:subview];
    }
}
@end
