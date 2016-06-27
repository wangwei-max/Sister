//
//  WebViewController.m
//  百思不得姐
//
//  Created by MAX on 16/6/23.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "WebViewController.h"
#import <NJKWebViewProgress.h>
@interface WebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *left;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *right;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;

/**进度代理对象*/
@property (nonatomic,strong) NJKWebViewProgress *progress;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progress;
    __weak typeof (self) weakSelf = self;
    self.progress.progressBlock = ^(float progress){
        weakSelf.progressView.progress = progress;
        
        weakSelf.progressView.hidden = (progress = 1.0);
    };
    self.progress.webViewProxyDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}


- (IBAction)left:(id)sender {
    [self.webView goBack];
}
- (IBAction)right:(id)sender {
    [self.webView goForward];
}
- (IBAction)refresh:(id)sender {
    
    [self.webView reload];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.left.enabled = webView.canGoBack;
    self.right.enabled = webView.canGoForward;
}

@end
