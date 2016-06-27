//
//  topicModel.h
//  百思不得姐
//
//  Created by MAX on 16/5/26.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <UIKit/UIkit.h>
@class CommentModel;

@interface topicModel : NSObject
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *profile_image;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *create_time;
@property (nonatomic,assign) NSInteger cai;
@property (nonatomic,assign) NSInteger repost;
@property (nonatomic,assign) NSInteger ding;
@property (nonatomic,assign) NSInteger comment;
@property (nonatomic,assign,getter=isSina_v) BOOL sina_v;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,copy) NSString *small_image;
@property (nonatomic,copy) NSString *large_image;
@property (nonatomic,copy) NSString *middel_image;
@property (nonatomic,assign) NSInteger voicetime;
@property (nonatomic,assign) NSInteger playcount;
@property (nonatomic,assign) NSInteger videotime;
/** 最热评论 */
@property (nonatomic,strong) NSArray *top_cmt;

@property (nonatomic,assign) TopicType type;
//辅助属性
@property (nonatomic,assign,readonly)CGFloat cellHeight;

@property (nonatomic,assign,readonly)CGRect pictureViewFrame;

@property (nonatomic,assign,readonly)CGRect voiceViewFrame;

@property (nonatomic,assign,readonly)CGRect videoViewFrame;

@property (nonatomic,assign,readonly)CGRect CommentViewFrame;

//图片是否太大
@property (nonatomic,assign,getter=isBigPicture)BOOL BigImage;



@end
