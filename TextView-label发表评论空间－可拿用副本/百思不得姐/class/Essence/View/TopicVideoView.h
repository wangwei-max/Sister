//
//  TopicVideoView.h
//  百思不得姐
//
//  Created by MAX on 16/6/16.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "topicModel.h"
@interface TopicVideoView : UIView

@property (nonatomic,strong)topicModel *topicModel;
+(instancetype)videoView;
@end
