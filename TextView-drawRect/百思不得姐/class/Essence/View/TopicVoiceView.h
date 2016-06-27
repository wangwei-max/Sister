//
//  TopicVoiceView.h
//  百思不得姐
//
//  Created by MAX on 16/6/15.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "topicModel.h"

@interface TopicVoiceView : UIView
@property (nonatomic,strong)topicModel *topicModel;
+(instancetype)voiceView;
@end
