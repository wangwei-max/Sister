//
//  wordCell.h
//  百思不得姐
//
//  Created by MAX on 16/5/27.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "topicModel.h"
#import "UserM.h"

@interface wordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *DingBtn;
@property (weak, nonatomic) IBOutlet UIButton *CaiBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *CommentBtn;
@property (weak, nonatomic) IBOutlet UIImageView *sinaV;
@property (weak, nonatomic) IBOutlet UILabel *text_Lbael;
/**最热评论*/
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;
/**最热评论父控件*/
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@property (nonatomic,strong) topicModel *topicModel;


+(instancetype)cell;
@end
