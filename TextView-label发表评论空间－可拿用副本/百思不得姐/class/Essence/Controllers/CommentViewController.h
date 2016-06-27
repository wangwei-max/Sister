//
//  CommentViewController.h
//  百思不得姐
//
//  Created by MAX on 16/6/17.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class topicModel;
@interface CommentViewController : UIViewController
/** 帖子模型 */
@property (nonatomic,strong) topicModel *topicModel;
@end
