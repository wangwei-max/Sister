//
//  MeCell.m
//  百思不得姐
//
//  Created by MAX on 16/6/22.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "MeCell.h"

@implementation MeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        
        //圆角
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.imageView.image) return;
    
    self.imageView.width = 35;
    self.imageView.height = 35;
    self.imageView.centerY = self.contentView.height *0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame)+10;
}
@end
