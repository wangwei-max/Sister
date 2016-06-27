//
//  LoginRegController.m
//  百思不得姐
//
//  Created by MAX on 16/5/24.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "LoginRegController.h"

@interface LoginRegController ()
@property (weak, nonatomic) IBOutlet UITextField *telField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
//登陆框离左边的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;
@end

@implementation LoginRegController

- (void)viewDidLoad {
    [super viewDidLoad];
    //恢复状态栏白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
//    //文字属性
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    //带有属性的文字（富文本技术）
    NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attributes];
    self.telField.attributedPlaceholder = placeholder;
    
//    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"手机号码" ];
//    [placeholder setAttributes:@{
//                                 NSForegroundColorAttributeName:[UIColor redColor],
//                                 NSFontAttributeName : [UIFont systemFontOfSize:30]
//                                 } range:NSMakeRange(0, 1)];
//    
//    [placeholder setAttributes:@{
//                                 NSForegroundColorAttributeName:[UIColor yellowColor],
//                                 NSFontAttributeName : [UIFont systemFontOfSize:15]
//                                 } range:NSMakeRange(1, 1)];
//    
//    [placeholder setAttributes:@{
//                                 NSForegroundColorAttributeName:[UIColor blueColor],
//                                 NSFontAttributeName : [UIFont systemFontOfSize:10]
//                                 } range:NSMakeRange(2, 1)];
//    self.telField.attributedPlaceholder = placeholder;
    
}

//当前控制器状态栏白色

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//注册
- (IBAction)regrist:(UIButton *)sender {
    //退出键盘
    [self.view endEditing:YES];
    
    if (self.leftMargin.constant == 0) {
        self.leftMargin.constant = -self.view.width;
        [sender setTitle:@"已有账号？" forState:UIControlStateNormal];
    }
    else
    {
        self.leftMargin.constant = 0;
        [sender setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

//返回按钮
- (IBAction)backBtn:(id)sender {
    //恢复状态栏黑色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
