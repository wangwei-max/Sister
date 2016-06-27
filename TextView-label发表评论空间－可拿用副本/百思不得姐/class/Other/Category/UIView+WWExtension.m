//
//  UIView+WWExtension.m
//  百思不得姐
//
//  Created by MAX on 16/5/13.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "UIView+WWExtension.h"

@implementation UIView (WWExtension)
-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
-(CGFloat)width
{
    return self.frame.size.width;
}

-(CGFloat)height
{
    return self.frame.size.height;
}

-(CGFloat)x
{
    return self.frame.origin.x;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}

-(CGSize)size
{
    return self.frame.size;
}

-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y= centerY;
    self.center = center;
}

-(CGFloat)centerX
{
    return self.center.x;
}

-(CGFloat)centerY
{
    return self.center.y;
}

//判断是不是当前窗口
-(BOOL)isShowingOnKeyWindow{
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    //以助窗口左上交为坐标原点，计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromWindow:self.superview];
    CGRect winBounds = keyWindow.bounds;
   //主窗口的
    BOOL Intersects = CGRectIntersectsRect(newFrame, winBounds);
    return !self.isHidden && self.alpha>0.01 && self.window == keyWindow && Intersects;
  
}
@end
