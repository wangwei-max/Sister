//
//  UIImageView+WWExtension.m
//  百思不得姐
//
//  Created by MAX on 16/6/21.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "UIImageView+WWExtension.h"
#import <UIImageView+WebCache.h>
@implementation UIImageView (WWExtension)
-(void)setHeader:(NSString *)url
{
    UIImage *placehodel = [[UIImage imageNamed:@"defaultUserIcon"]circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placehodel completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
     }];
}
@end
