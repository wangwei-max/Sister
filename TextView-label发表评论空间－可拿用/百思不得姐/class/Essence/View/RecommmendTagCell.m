//
//  RecommmendTagCell.m
//  百思不得姐
//
//  Created by MAX on 16/5/23.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "RecommmendTagCell.h"
#import "UIImageView+WebCache.h".
@interface RecommmendTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNameLabel;

@end

@implementation RecommmendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];  
    // Initialization code
}

-(void)setRecommendTag:(RecommendTagsModel *)recommendTag
{
    _recommendTag = recommendTag;
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themNameLabel.text = recommendTag.theme_name;
    
    NSString *subName = nil;
    if (recommendTag.sub_number<10000) {
        subName = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    }
    else
    {
        subName = [NSString stringWithFormat:@"%.1f万人订阅",recommendTag.sub_number/10000.0];
    }
    self.subNameLabel.text = subName;
    
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -=2*frame.origin.x;
    
    frame.size.height -=2;
    [super setFrame:frame];
}
@end
