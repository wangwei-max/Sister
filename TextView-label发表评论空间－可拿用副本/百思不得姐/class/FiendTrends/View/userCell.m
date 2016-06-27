//
//  userCell.m
//  百思不得姐
//
//  Created by MAX on 16/5/19.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "userCell.h"
#import "UIImageView+WebCache.h"
@implementation userCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setUsermodel:(UserModel *)usermodel
{
    self.name.text = usermodel.screen_name;
    [self.userImageV sd_setImageWithURL:[NSURL URLWithString:usermodel.header] placeholderImage:[UIImage imageNamed:@"post_placeholderImage"]];
    
    //万人
    NSString *fans_count = nil;
    if (usermodel.fans_count<10000) {
        fans_count = [NSString stringWithFormat:@"%zd人订阅", usermodel.fans_count];
    }
    else
    {
        fans_count = [NSString stringWithFormat:@"%.1f万人订阅",usermodel.fans_count/10000.0];
    }
    self.count.text = fans_count;
}

@end
