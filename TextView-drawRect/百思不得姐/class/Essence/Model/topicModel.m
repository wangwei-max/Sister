//
//  topicModel.m
//  百思不得姐
//
//  Created by MAX on 16/5/26.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "topicModel.h"
#import "CommentModel.h"
#import "UserM.h"

@implementation topicModel
{
    CGFloat _cellHeight;
}

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id"
             };
}
//top_cmt
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"top_cmt" : [CommentModel class]
             };
}
//时间
-(NSString *)create_time
{
    //日期格式化
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期格式
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss ";
    //帖子创建的时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) {//今年
        if (create.isThisDay) {//今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld分钟前",cmps.hour];
            }
            else if (cmps.minute >=1 )
            {
                return [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
            }
            else
            { 
                return  @"刚刚";
            }
        }
        else if(create.isYesterday)//昨天
        {
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        }
        else//其它
        {
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    }
    else//非今年
    {
        return _create_time;
    }
}


-(CGFloat)cellHeight
{
    if (!_cellHeight) {
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2*TopicCellMargin, MAXFLOAT);
        //文字高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                           NSFontAttributeName : [UIFont systemFontOfSize:14.0]} context:nil].size.height;
      

        
        //cell  高度
        _cellHeight = TopicCellTextY +textH+TopicCellMargin;//(10为cell缩小的距离)
   
        if (self.type == TypePicture) {//图片帖子
            //图片显示出来的宽度
            CGFloat pictureW  = maxSize.width;
            //图片显示 － 比例计算高度
            CGFloat pictureH = pictureW * self.height/self.width;
            if (pictureH >= TopicCellPcitureMaxH) {//图片高度过长
                pictureH = TopicCellPcitureBreakH;
                self.BigImage = YES;//大图
            }
            
            // 计算图片控件的frame
            CGFloat pictureX = TopicCellMargin;
            CGFloat pictureY = TopicCellTextY + textH + TopicCellMargin;
            _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            _cellHeight += pictureH+TopicCellMargin;
    
        
        }else if (self.type == TypeVoice){//声音帖子
       
        CGFloat voiceX = TopicCellMargin;
        CGFloat voiceY = TopicCellTextY + textH + TopicCellMargin;
        CGFloat voiceW = maxSize.width;
        CGFloat voiceH = voiceW*self.height/self.width;
        _voiceViewFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
        
        _cellHeight += voiceH +TopicCellMargin;
        }
        else if (self.type == TypeVideo)//视频帖子
        {
            CGFloat videoX = TopicCellMargin;
            CGFloat videoY= TopicCellTextY + textH + TopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW*self.height/self.width;
            _videoViewFrame = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH +TopicCellMargin;
        }
        
        
        
        CommentModel *cmt = [self.top_cmt firstObject];
        if (cmt) {
            NSString *comment = cmt.content;
            CGFloat commentH = [comment boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{
                                                                                                                                NSFontAttributeName : [UIFont systemFontOfSize:14.0]} context:nil].size.height;

            _cellHeight += TopicCellTopCmtTitle +TopicCellMargin+commentH;
        
        }
        
        
     _cellHeight += TopicCellBottomBarH +TopicCellMargin;
    }
    return _cellHeight;
}
@end
