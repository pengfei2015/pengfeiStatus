//
//  WPFOAuthVC.m
//  鹏飞微博2
//
//  Created by 王家辉 on 15/11/7.
//  Copyright (c) 2015年 温鹏飞. All rights reserved.
//

#import "WPFOAuthVC.h"
#import "MBProgressHUD+MJ.h"
#import "WPFAccessTokenRequest.h"
#import "WPFHttpTool.h"
#import "MJExtension.h"
#import "WPFAccount.h"
#import "WPFNewFeartureVC.h"

@interface WPFOAuthVC ()<UIWebViewDelegate>

@end
@implementation WPFOAuthVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1. 添加webview
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:webView];
    // 2. 加载数据
    /**
     *  https://api.weibo.com/oauth2/authorize?client_id=123050457758183&redirect_uri=http://www.ex
     */
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",APP_KEY,REDIRECT_URL];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark -UIWebViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
    WPFLog(@"didFailLoadWithError");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
    //WPFLog(@"webViewDidFinishLoad");
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].statusBarHidden = YES;
    [MBProgressHUD showMessage:@"正在拼命加载，请稍后。。。"];
    //WPFLog(@"webViewDidStartLoad");
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *str= @"http://www.baidu.com/?code=";
    NSString *url = request.URL.absoluteString;
    NSRange rang = [url rangeOfString:str];
    if (rang.location != NSNotFound) { // 如果找到
        int frome = rang.location + rang.length;
        NSString *code = [url substringFromIndex:frome];
        [self accessTokenWithCode:code];
        return NO;
    }
    return YES;
}

- (void)accessTokenWithCode:(NSString *)code
{
    WPFAccessTokenRequest *params = [[WPFAccessTokenRequest alloc] init];
    params.client_id = APP_KEY;
    params.client_secret = APP_SECRET;
    params.grant_type = @"authorization_code";
    params.code = code;
    params.redirect_uri = REDIRECT_URL;
    
    [WPFHttpTool post:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id responsObj) {
        WPFAccount *account = [WPFAccount objectWithKeyValues:responsObj];
        
        [WPFAccount save:account];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = [[WPFNewFeartureVC alloc] init];
        
    } failure:^(NSError *error) {
        WPFLog(@"accessTokenWithCode  失败");
    }];
}
@end
