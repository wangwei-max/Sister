//
//  UIBarButtonItem+WW.m
//  百思不得姐
//
//  Created by MAX on 16/5/13.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "UIBarButtonItem+WW.h"

@implementation UIBarButtonItem (WW)
+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage action:(SEL)action target:(id)target
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.size = btn.currentBackgroundImage.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc]initWithCustomView:btn];
}
@end
