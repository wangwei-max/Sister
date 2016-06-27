//
//  TopicPictureView.m
//  百思不得姐
//
//  Created by MAX on 16/6/3.
//  Copyright © 2016年 MAX. All rights reserved.
//图片帖子中的内容

#import "TopicPictureView.h"
#import "ShowPictureController.h"

@implementation TopicPictureView

+(instancetype)pictureView
{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TopicPictureView class]) owner:self options:nil] lastObject];
}

-(void)awakeFromNib
{
    
    self.autoresizingMask = UIViewAutoresizingNone;
    //给图片添加监听器
    self.pictureView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImage)];
    [self.pictureView addGestureRecognizer:tap];
    
}

-(void)showImage
{
    ShowPictureController *showPicture = [[ShowPictureController alloc] init];
    showPicture.topModel = self.topicModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

-(void)setTopicModel:(topicModel *)topicModel
{
    _topicModel = topicModel;
    
    //设置图片
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:topicModel.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressV.hidden = NO;
        CGFloat progress = 1.0 *receivedSize/expectedSize;        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressV.hidden = YES;
        
        if (topicModel.isBigPicture) {
            //开启图形上下文
            UIGraphicsBeginImageContextWithOptions(topicModel.pictureViewFrame.size, YES, 0.0);
            
            //将下载的image对象绘制到图形上下文
            CGFloat width = topicModel.pictureViewFrame.size.width;
            CGFloat height = width * image.size.height/image.size.width;
            [image drawInRect:CGRectMake(0, 0, width, height)];
            
            //获得图片
            self.pictureView.image =  UIGraphicsGetImageFromCurrentImageContext();
            
            //结束图形上下文
            UIGraphicsEndImageContext();
        }
            }];
    
    //判读是不是gif图片
    NSString *extension = topicModel.large_image.pathExtension;
    
//    self.gifView.hidden = ![extension isEqualToString:@"git"];
    if (![extension.lowercaseString isEqualToString:@"git"]) {
        self.gifView.hidden = YES;
    }
    
    //判断是否显示按钮
    if (topicModel.isBigPicture) {//大图
        self.channgBigView.hidden = NO;
    }
    else //非大图
    {
        self.channgBigView.hidden = YES;
    }
    self.channgBigView.hidden = !topicModel.isBigPicture;
}
@end
