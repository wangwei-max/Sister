//
//  PlaceHolderTextView.m
//  百思不得姐
//
//  Created by MAX on 16/6/27.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "PlaceHolderTextView.h"

@interface PlaceHolderTextView ()
@property (nonatomic,weak)UILabel *placederLabel;

@end

@implementation PlaceHolderTextView

-(UILabel *)placederLabel
{
    if (!_placederLabel) {
        //添加一个站位文字的label
        UILabel *placederLabel = [[UILabel alloc] init];
        placederLabel.numberOfLines = 0;
        placederLabel.x = 4;
        placederLabel.y = 7;
        [self addSubview:placederLabel];
        _placederLabel = placederLabel;

    }
    return _placederLabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:15];
        
        
        //垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        
        
        //默认的占位文字颜色
        self.placeholderColor = [UIColor grayColor];
        
        //监听文字改变.
        [WWNoteCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
        
     
    }
    return  self;
}

-(void)dealloc
{
    [WWNoteCenter removeObserver:self];
}
-(void)textDidChange
{
    // 只要有文字，就隐藏占位文字label
    self.placederLabel.hidden = self.hasText;
}
/** 更新文字占位尺寸*/
/** setNeddsDisplay: 会在恰当的时候调用drwaRext*/
/** layoutSubviews: 会在恰当的时候调用setNeedsLayout*/


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize maxSize = CGSizeMake(self.width - 2 * self.placederLabel.x, MAXFLOAT);
    self.placederLabel.size = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
}


-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placederLabel.textColor = placeholderColor;
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placederLabel.text = placeholder;
    [self setNeedsLayout];
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placederLabel.font = font;
    [self setNeedsLayout];
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    [self textDidChange];
    
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self textDidChange];
}
@end
