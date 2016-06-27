//
//  ShowPictureController.m
//  百思不得姐
//
//  Created by MAX on 16/6/6.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "ShowPictureController.h"
#import "topicModel.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface ShowPictureController ()

@property (weak, nonatomic) IBOutlet UIScrollView *s;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *backbBtn;
@property (weak, nonatomic) IBOutlet UIButton *relayBtn;
@property (strong,nonatomic) UIImageView *bingView;


@end

@implementation ShowPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bingView = [[UIImageView alloc] init];
    self.bingView.userInteractionEnabled = YES;
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [self.bingView addGestureRecognizer:tap];
    [self.s addSubview:self.bingView];
//    self.bingView = bingView;
    
    //屏幕宽度
    //图片高度 图片的高度
    CGSize screenSize= [UIScreen mainScreen].bounds.size;
    CGFloat pictureW = screenSize.width;
    CGFloat pictureH = pictureW *self.topModel.height/self.topModel.width;
    
    //图片的尺寸
    if (pictureH > screenSize.height) {//图片超过屏幕的高度，需要滚动查看
        self.bingView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.s.contentSize = CGSizeMake(0, pictureH);
    }
    else
    {
        self.bingView.size = CGSizeMake(pictureW, pictureH);
        self.bingView.centerY = screenSize.height * 0.5;
    }
    
    [self.bingView sd_setImageWithURL:[NSURL URLWithString:self.topModel.large_image]];
    
}

- (IBAction)backBtn:(id)sender {
    [self back];
}

//保存图片
- (IBAction)savBtn:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.bingView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    if (error) {
        [SVProgressHUD showSuccessWithStatus:@"保存失败"];
    }
    else
    {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}


- (IBAction)relayBtn:(id)sender {
}

//点击图片返回
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
