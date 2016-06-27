//
//  PlaceHolderTextView.m
//  百思不得姐
//
//  Created by MAX on 16/6/27.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "PlaceHolderTextView.h"

@implementation PlaceHolderTextView
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
    [self setNeedsDisplay];
}

/** 绘制占位文字 */
- (void)drawRect:(CGRect)rect {
    //如果有文字，直接返回，不绘制占位文字
    if (self.hasText) {
        return;
    }
    
    //处理rect
    rect.origin.x = 4;
    rect.origin.y = 7;
    rect.size.width -= 2 *rect.origin.x;
    
    //文字属性
    NSMutableDictionary *atts = [NSMutableDictionary dictionary];
    atts[NSFontAttributeName] = self.font;
    atts[NSForegroundColorAttributeName] = self.placeholderColor;
    [self.placeholder drawInRect:rect withAttributes:atts];
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
@end
