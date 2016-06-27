//
//  RecommendCell.m
//  百思不得姐
//
//  Created by MAX on 16/5/17.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "RecommendCell.h"
#import "recommendCategory.h"

@implementation RecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = WWRGBColoer(244, 244, 244);

}


-(void)setCategory:(recommendCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2*self.textLabel.y ;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.leftview.hidden = !selected;
    self.textLabel.textColor = selected? WWRGBColoer(219, 21, 26):WWRGBColoer(82, 82, 82);
}
@end
