//
//  PublishView.m
//  百思不得姐
//
//  Created by MAX on 16/6/7.
//  Copyright © 2016年 MAX. All rights reserved.
//


#import "PublishView.h"
#import "VertiicalButton.h"
#import "PostWordViewController.h"
#import "WWNavigationController.h"
#import "POP.h"


@interface PublishView ()
@property (nonatomic,strong) UIImageView *sloganView;
@property (nonatomic,strong) VertiicalButton *btn;
@end

@implementation PublishView


static UIWindow *window_;

+(void)show
{
    window_ = [[UIWindow alloc] init];
    window_.frame = [UIScreen mainScreen].bounds;
    window_.hidden = NO;
    window_.backgroundColor = [UIColor whiteColor];
    
    PublishView *publishView = [PublishView pulishView];
    publishView.frame = window_.bounds;
    [window_ addSubview:publishView];
}

+(instancetype)pulishView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
    
    
}

- (void)awakeFromNib {
    //不能被点击
    self.userInteractionEnabled = NO;

    //数据
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];
    
    //中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (ScreenH - 2*buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    
    CGFloat xMargin = (ScreenW - 2*buttonStartX -maxCols*buttonW) * 0.5 ;
    for (int i = 0 ; i<images.count; i++) {
        VertiicalButton *button = [[VertiicalButton alloc]init];
        button.tag = i ;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        //设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        //计算x/y
        int row = i/maxCols;
        int col = i%maxCols;
        CGFloat buttonX = buttonStartX+col*(xMargin+buttonW);
        CGFloat buttonEndY = buttonStartY + row*(buttonH);
        CGFloat buttonBeginY = buttonEndY-ScreenH;
        
        //按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springSpeed = 20;
        anim.springBounciness = 20;
        anim.beginTime = CACurrentMediaTime() +0.1*i;
        [button pop_addAnimation:anim forKey:nil];
    }
    
    //添加标题
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:sloganView];
    
    CGFloat centerX = ScreenW *0.5;
    CGFloat centerEndY = ScreenH *0.2;
    CGFloat centerBenginY = centerEndY -ScreenH;
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBenginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.springSpeed = 20;
    anim.springBounciness = 20;
    anim.beginTime = CACurrentMediaTime() +0.1*(images.count+1);
    
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
        self.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
    
}
- (IBAction)cancelBtn:(id)sender {
    [self cancelWithCompletionBlock:nil];
    
   }

/*
 *先执行推出动画，动画完毕后执行completionBlock
 */
-(void)cancelWithCompletionBlock:(void(^)())completionBlock
{
    int beginIndex = 1;
    self.userInteractionEnabled = NO;
    for (int i = beginIndex; i<self.subviews.count; i++) {
        UIView *subview = self.subviews[i];
        CGFloat centerY = subview.y +ScreenH;
        
        //基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        
        //动画的执行节奏
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime()+ (i-beginIndex) *0.1;
        [subview pop_addAnimation:anim forKey:nil];
        
        //后一个动画，后跳出
        if (i == self.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
//                [self removeFromSuperview];
                //销毁窗口
                window_ = nil;
                //执行传进来的completionBlock参数
                !completionBlock ? :completionBlock();
            }];
        }
    }

}
#pragma mark - buttonClick 
-(void)buttonClick:(UIButton *)button
{
    [self cancelWithCompletionBlock:^{
        
        switch (button.tag) {
            case 0:
                WWLog(@"1");
                break;
            case 1:
                NSLog(@"2");
                break;
            case 2:
            {
                PostWordViewController *postWord = [[PostWordViewController alloc] init];
                WWNavigationController *nav = [[WWNavigationController alloc]initWithRootViewController:postWord];
                
                UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
                [root presentViewController:nav animated:YES completion:nil];
            }
                break;
            case 3:
                NSLog(@"4");
                break;
            case 4:
                NSLog(@"5");
                break;
            case 5:
                NSLog(@"6");
                break;
            default:
                break;
        }
    }];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancelWithCompletionBlock:nil];
}
@end
