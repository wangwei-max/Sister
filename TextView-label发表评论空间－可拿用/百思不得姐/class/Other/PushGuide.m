//
//  PushGuide.m
//  百思不得姐
//
//  Created by MAX on 16/5/25.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "PushGuide.h"

@implementation PushGuide

+(void)show
{
    NSString *key = @"CFBundleShortVersionString";
    //当前版本
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    //上次一次版本
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {//第一次打开版本时
        //引导页
        PushGuide *guide = [PushGuide guide];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        guide.frame = window.bounds;
        [window addSubview:guide];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+(instancetype)guide
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
- (IBAction)knowBtn:(id)sender {
    [self removeFromSuperview];
}

@end
