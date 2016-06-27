//
//  wordCell.m
//  百思不得姐
//
//  Created by MAX on 16/5/27.
//  Copyright © 2016年 MAX. All rights reserved.
//
/**

 */

#import "wordCell.h"
#import "UIImageView+WebCache.h"
#import "TopicPictureView.h"
#import "TopicVoiceView.h"
#import "TopicVideoView.h"
#import "CommentModel.h"
#import "UserM.h"

@interface wordCell ()
@property (nonatomic,weak) TopicPictureView *topicPicture;
@property (nonatomic,weak) TopicVoiceView *topicVoice;
@property (nonatomic,weak) TopicVideoView *topicVideo;


@end

@implementation wordCell

+(instancetype)cell
{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

-(TopicPictureView *)topicPicture
{
    if (!_topicPicture) {
        TopicPictureView *pictureView = [TopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _topicPicture = pictureView;
    }
    return _topicPicture;
}

-(TopicVoiceView *)topicVoice
{
    if (!_topicVoice) {
        TopicVoiceView *voiceView = [TopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _topicVoice = voiceView;
    }
    return _topicVoice;
}

-(TopicVideoView *)topicVideo
{
    if (!_topicVideo) {
        TopicVideoView *topicVideo = [TopicVideoView videoView];
        [self.contentView addSubview:topicVideo];
        _topicVideo = topicVideo;
    }
    return _topicVideo;
}

-(void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
    //圆角
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;

    
}

-(void)setTopicModel:(topicModel *)topicModel
{
    _topicModel = topicModel;
    
    topicModel.sina_v = (int)arc4random_uniform(2);
    [self.Icon sd_setImageWithURL:[NSURL URLWithString:topicModel.profile_image] placeholderImage:[UIImage imageNamed:@"post_placeholderImage"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.Icon.image = [image circleImage];
    }];
    
    self.name.text = topicModel.name;
    
    //设置帖子的创建的时间
    self.time.text = topicModel.create_time;
    
    self.sinaV.hidden =  topicModel.isSina_v;
   
    [self numButton:self.DingBtn count:topicModel.ding palceholder:@"顶"];
    [self numButton:self.CaiBtn count:topicModel.cai palceholder:@"踩"];
    [self numButton:self.shareBtn count:topicModel.repost palceholder:@"分享"];
    [self numButton:self.CommentBtn count:topicModel.comment palceholder:@"评论"];
    
    self.text_Lbael.text = topicModel.text;
//    [self testDate:topicModel.create_time];
    
    //根据模型类型（帖子类型）添加对应的内容到cell的中间
    if (topicModel.type == TypePicture) {//图片帖子
        self.topicVideo.hidden = YES;
        self.topicVoice.hidden = YES;
        self.topicPicture.hidden = NO;
        self.topicPicture.topicModel = topicModel;
        self.topicPicture.frame = topicModel.pictureViewFrame;
    }
    else if (topicModel.type == TypeVoice)//声音帖子
    {
        self.topicVideo.hidden = YES;
        self.topicVoice.hidden = NO;
        self.topicPicture.hidden = YES;
        self.topicVoice.topicModel = topicModel;
        self.topicVoice.frame = topicModel.voiceViewFrame;
    }
    else if (topicModel.type == TypeVideo)//声音帖子
    {
        self.topicVideo.hidden = NO;
        self.topicVoice.hidden = YES;
        self.topicPicture.hidden = YES;
        self.topicVideo.topicModel = topicModel;
        self.topicVideo.frame = topicModel.videoViewFrame;
    }
    else//段子
    {
        self.topicVideo.hidden = YES;
        self.topicVoice.hidden = YES;
        self.topicPicture.hidden = YES;
        
    }
    
    //处理最热评论
   
    CommentModel *cmt = [topicModel.top_cmt firstObject];
    NSLog(@"%@",cmt.user);
    if (cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtLabel.text = [NSString stringWithFormat:@"%@:%@",cmt.user.username,cmt.content];
    }
    else
    {
        self.topCmtView.hidden = YES;
    }
    
    
    
}

//-(void)testDate:(NSString *)create_time
//{
//    //时间比较
//    NSDate *now = [NSDate date];
//    
//    //发帖时间
//    //NSString --->NSdate
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    //设置日期格式
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss ";
//    NSDate *create = [fmt dateFromString:create_time];

    
    
//    //获得当前年 月 日
//    NSInteger year = [calendar component:NSCalendarUnitYear fromDate:now];
//    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:now];
//    NSInteger day = [calendar component:NSCalendarUnitDay fromDate:now];
//}

//-(void)testDate:(NSString *)create_time
//{
//    //时间比较
//    NSDate *now = [NSDate date];
//    //发帖时间
//    //NSString --->NSdate
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    //设置日期格式
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss ";
//    NSDate *create = [fmt dateFromString:create_time];
//    //比较时间
//    NSTimeInterval  delta = [now timeIntervalSinceDate:create];
//}
-(void)setFrame:(CGRect)frame
{
//    frame.origin.x = TopicCellMargin;
//    frame.size.width -=2*TopicCellMargin ;
//    frame.size.height-=TopicCellMargin;
    frame.size.height = self.topicModel.cellHeight - TopicCellMargin;
    frame.origin.y += TopicCellMargin;
    [super setFrame:frame];
}

- (IBAction)moreButton:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *other1 = [UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *other2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *other3 = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
/**
    NSArray *actions = [[NSArray alloc] init];
    actions = @[other1,other2,other3];
 */
    
    [alert addAction:other1];
    [alert addAction:other2];
    [alert addAction:other3];

  
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [vc presentViewController:alert animated:YES completion:nil];
    
//    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"哈哈" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"呵呵" otherButtonTitles:@"1",@"2" ,nil];
//    [sheet showInView:self.window];
}

-(void)numButton:(UIButton *)button count:(NSInteger)count palceholder:(NSString *)palceholder
{
    NSString *title = nil;
    if (count == 0) {
        title = palceholder;
    }
    else if (count <10000) {
        title = [NSString stringWithFormat:@"%ld",(long)count];
    }
    else
    {
        title = [NSString stringWithFormat:@"%.1ld万",(long)count/10000];
    }
    [button setTitle:title forState:UIControlStateNormal];
}

@end
