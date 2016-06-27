//
//  WWSquareButton.m
//  百思不得姐
//
//  Created by MAX on 16/6/22.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "WWSquareButton.h"
#import "SquareModel.h"
#import "UIButton+WebCache.h"

@implementation WWSquareButton
//上下按钮

-(void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
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
    //调整图片
    self.imageView.y = self.height * 0.2;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width *0.5;
    
    //调整文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

-(void)setSquare:(SquareModel *)square
{
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    //利用sdweb设置按钮图片
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
}
@end
