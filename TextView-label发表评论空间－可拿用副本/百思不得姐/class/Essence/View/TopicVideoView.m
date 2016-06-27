//
//  TopicVideoView.m
//  百思不得姐
//
//  Created by MAX on 16/6/16.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "TopicVideoView.h"
#import "topicModel.h"
#import "UIImageView+WebCache.h"
#import "ShowPictureController.h"

@interface TopicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;


@end
@implementation TopicVideoView

+(instancetype)videoView
{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TopicVideoView class]) owner:self options:nil] lastObject];
}

-(void)awakeFromNib
{
    
    self.autoresizingMask = UIViewAutoresizingNone;
    //给图片添加监听器
    self.backGroundImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImage)];
    [self.backGroundImageView addGestureRecognizer:tap];
    
}

//弹出放大控制器
-(void)showImage
{
    ShowPictureController *showPicture = [[ShowPictureController alloc] init];
    showPicture.topModel = self.topicModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}
-(void)setTopicModel:(topicModel *)topicModel
{
    _topicModel = topicModel;
    
    //图片
    [self.backGroundImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.large_image]];
    
    
    //播放次数
    self.countLabel.text = [NSString stringWithFormat:@"%zd次播放",topicModel.playcount];
    
    //播放时长
    NSInteger time =  topicModel.videotime;
    NSInteger minute = time / 60 ;
    NSInteger second = time % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%zd",minute,second];
    
    
}
@end
