//
//  PostWordViewController.m
//  百思不得姐
//
//  Created by MAX on 16/6/24.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "PostWordViewController.h"
#import "PlaceHolderTextView.h"
@interface PostWordViewController ()

/**文本输入控件*/
@property (nonatomic,strong)PlaceHolderTextView *textView;
@end

@implementation PostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupTextView];
}

-(void)setupTextView
{
    PlaceHolderTextView *textView = [[PlaceHolderTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"请写字撒打算打算打算打撒的撒上滴滴答答滴滴答答撒啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊";
    [self.view addSubview:textView];
    self.textView = textView;
}

-(void)setupNav
{
    self.title = @"发表文字";
    //设置系统字体颜色
    self.navigationItem .leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem .rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;//默认不能点击；
    //强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];

}

-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)post
{
    WWLogFunc;
}

@end
