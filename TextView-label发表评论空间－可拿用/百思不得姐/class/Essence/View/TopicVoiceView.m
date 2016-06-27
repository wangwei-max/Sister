//
//  TopicVoiceView.m
//  百思不得姐
//
//  Created by MAX on 16/6/15.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "TopicVoiceView.h"
#import <UIImageView+WebCache.h>
#import "ShowPictureController.h"

@interface TopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcount;
@property (weak, nonatomic) IBOutlet UILabel *voicelength;

@end

@implementation TopicVoiceView

+(instancetype)voiceView
{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TopicVoiceView class]) owner:self options:nil] lastObject];
}

-(void)awakeFromNib
{
    
    self.autoresizingMask = UIViewAutoresizingNone;
    //给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImage)];
    [self.imageView addGestureRecognizer:tap];
    
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
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicModel.large_image]];
    
    //播放次数
    self.playcount.text = [NSString stringWithFormat:@"%zd次播放",topicModel.playcount];
    
    //播放时长
    NSInteger time =  topicModel.voicetime;
    NSInteger minute = time / 60 ;
    NSInteger second = time % 60;
    self.voicelength.text = [NSString stringWithFormat:@"%02zd:%zd",minute,second];
    
}
@end
