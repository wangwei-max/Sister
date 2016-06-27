//
//  UIImage+WWExtension.m
//  百思不得姐
//
//  Created by MAX on 16/6/21.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "UIImage+WWExtension.h"

@implementation UIImage (WWExtension)
-(UIImage *)circleImage
{
    //NO表示透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    //获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    //裁剪
    CGContextClip(ctx);
    
    //将图片画上去
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return image;
}
@end
