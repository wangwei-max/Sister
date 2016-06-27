//
//  UIView+WWExtension.h
//  百思不得姐
//
//  Created by MAX on 16/5/13.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WWExtension)
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;
@property (nonatomic,assign)CGSize size;
@property (nonatomic,assign)CGFloat centerX;
@property (nonatomic,assign)CGFloat centerY;

/**一个控件是否真正的显示在窗口上*/
-(BOOL)isShowingOnKeyWindow;
@end
