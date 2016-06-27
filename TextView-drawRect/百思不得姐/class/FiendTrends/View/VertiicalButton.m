//
//  VertiicalButton.m
//  百思不得姐
//
//  Created by MAX on 16/5/24.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "VertiicalButton.h"

@implementation VertiicalButton

//上下按钮

-(void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

//XIB
-(void)awakeFromNib
{
    [self setup];
}

//代码
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

//布局
-(void)layoutSubviews
{
    
    [super layoutSubviews];
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height+10;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
