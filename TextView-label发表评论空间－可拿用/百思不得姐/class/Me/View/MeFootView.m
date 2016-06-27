//
//  MeFootView.m
//  百思不得姐
//
//  Created by MAX on 16/6/22.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "MeFootView.h"
#import "AFNetworking.h"
#import "SquareModel.h"
#import <MJExtension.h>
#import "UIButton+WebCache.h"
#import "WWSquareButton.h"
#import "WebViewController.h"

@implementation MeFootView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
      
         //请求
         NSMutableDictionary *params = [[NSMutableDictionary dictionary] init];
         params[@"a"] = @"square";
         params[@"c"] = @"topic";
         //存储上一次的数据
         
         [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
             NSArray *sqaures = [SquareModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
             
             [self createSquares:sqaures];
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         }];
    }
    return self;
}
/**创建九宫格*/
-(void)createSquares:(NSArray *)squares
{
    //一行4列
    int maxCols= 4;
    
    CGFloat buttonW = ScreenW/maxCols;
    CGFloat buttonH = buttonW ;
    
    for (int i=0; i<squares.count; i++) {
//        SquareModel *square = squares[i];
        
        
        WWSquareButton *button = [WWSquareButton buttonWithType:UIButtonTypeCustom];

        [button setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.square = squares[i];
        [self addSubview:button];
        
        //计算frame
        int col = i%maxCols;
        int row = i/maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW ;
        button.height = buttonH;
    }
    
    //计算footer的高度
/** 总行计算*/
    // 1       self.height = CGRectGetMaxY(button.frame);
//    2. NSInteger rows = squares.count/maxCols;
//    if (squares.count % maxCols) {
//        rows++;
//    }
    
//    self.height = rows *buttonH;
    NSUInteger rows = (squares.count + maxCols - 1)/maxCols;
     self.height = rows *buttonH;
    //重绘
    [self setNeedsDisplay];
}

// 设置背景图片
-(void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"error"] drawInRect:rect];
}

-(void)buttonClick:(WWSquareButton *)button
{
    //前缀不适http
    if (![button.square.url hasPrefix:@"http"]) {
        return;
    }
    else
    {
        WWLog(@"%@",button.square.url);
        WebViewController *web = [[WebViewController alloc] init];
        web.url = button.square.url;
        web.title = button.square.name;
        //  取出当前的导航控制器
        UITabBarController *tabBarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        UINavigationController *nav = (UINavigationController *)tabBarController.selectedViewController;
        [nav pushViewController:web animated:YES];
    }
}
@end
