//
//  FiendTrendsViewController.m
//  百思不得姐
//
//  Created by MAX on 16/5/13.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "FiendTrendsViewController.h"
#import "RecommendController.h"
#import "LoginRegController.h"
@interface FiendTrendsViewController ()

@end

@implementation FiendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" action:@selector(firendsClick) target:self];
    self.view.backgroundColor = WWGLOBALBg;
}

-(void)firendsClick
{
    RecommendController *vc= [[RecommendController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)loginRegisterBtn:(id)sender {
    LoginRegController *loginReg = [[LoginRegController alloc] init];
    [self presentViewController:loginReg animated:YES completion:nil];
}
@end
