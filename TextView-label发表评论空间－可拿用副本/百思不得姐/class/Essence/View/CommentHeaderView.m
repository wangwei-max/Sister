//
//  CommentHeaderView.m
//  百思不得姐
//
//  Created by MAX on 16/6/17.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "CommentHeaderView.h"

@interface CommentHeaderView ()
@property (nonatomic,weak) UILabel *label;

@end

@implementation CommentHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = WWGLOBALBg;
        UILabel *label = [[UILabel alloc] init];
        label.textColor = WWRGBColoer(67, 67, 67);
        label.width = 200;
        label.x = 10;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label ;
    }
    return  self;
}
-(void)setTitle:(NSString *)title
{
//    _title = [title copy];
    self.label.text = title;
}
@end
