//
//  CommentCell.m
//  百思不得姐
//
//  Created by MAX on 16/6/20.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "CommentCell.h"
#import "CommentModel.h"
#import <UIImageView+WebCache.h>
#import "UserM.h"
#import "CommentCell.h"

@interface CommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeConntLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;


@end

@implementation CommentCell

-(void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

-(void)setCommentModel:(CommentModel *)commentModel
{
    _commentModel = commentModel;
//    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:commentModel.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//         self.profileImageView.image = [image circleImage];
//    }];
    [self.profileImageView setHeader:commentModel.user.profile_image];
    self.sexView.image = [commentModel.user.sex isEqualToString:UserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = commentModel.content;
    self.usernameLabel.text = commentModel.user.username;
    self.likeConntLabel.text = [NSString stringWithFormat:@"%zd",commentModel.like_count];
    
    if (commentModel.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",commentModel.voicetime] forState:UIControlStateNormal];
    }
    else
    {
        self.voiceButton.hidden = YES;

    }
}

//Cell边距 重写frame的set方法
-(void)setFrame:(CGRect)frame
{
//    frame.origin.x = TopicCellMargin;
//    frame.size.width -= 2 *TopicCellMargin;
    
    [super setFrame: frame];
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}
@end
