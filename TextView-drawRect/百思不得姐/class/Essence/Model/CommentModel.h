//
//  CommentModel.h
//  百思不得姐
//
//  Created by MAX on 16/6/16.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserM.h"

@interface CommentModel : NSObject
/** 音频文件的时长*/
@property (nonatomic,assign)NSInteger voicetime;
/** 音频文件的路径*/
@property (nonatomic,copy)NSString *voiceuri;
/** 评论的文字内容 */
@property (nonatomic,copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic,assign) NSInteger like_count;
/** 用户 */
@property (nonatomic,strong) UserM *user;
/**id*/
@property (nonatomic,copy) NSString *ID;
@end
