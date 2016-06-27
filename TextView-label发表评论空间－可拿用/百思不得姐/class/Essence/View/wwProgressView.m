//
//  wwProgressView.m
//  百思不得姐
//
//  Created by MAX on 16/6/6.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "wwProgressView.h"

@implementation wwProgressView

-(void)awakeFromNib
{
    self.progressLabel.textColor = [UIColor whiteColor];
    self.roundedCorners = 5;

}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;
{
    [super setProgress:progress animated:animated];
    self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress*100];
}

@end
