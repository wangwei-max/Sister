//
//  TopicPictureView.h
//  百思不得姐
//
//  Created by MAX on 16/6/3.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "topicModel.h"
#import "UIImageView+WebCache.h"
#import "wwProgressView.h"

@interface TopicPictureView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIButton *channgBigView;
@property (nonatomic,strong)topicModel *topicModel;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet wwProgressView *progressV;

+(instancetype)pictureView;
@end
