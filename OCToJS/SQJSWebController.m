//
//  SQJSWebController.m
//  OCToJS
//
//  Created by Huang Yanan on 2017/2/14.
//  Copyright © 2017年 Huang Yanan. All rights reserved.
//

#import "SQJSWebController.h"
#import "WKWebViewJavascriptBridge.h"

@interface SQJSWebController ()

@property (nonatomic,strong) WKWebView *webView;
@property WKWebViewJavascriptBridge* bridge;

@end

@implementation SQJSWebController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    _webView.navigationDelegate = self;
    
    [self.view addSubview:_webView];
    
    NSLog(@"self.url is %@", self.url);
    if(self.url && self.url.length > 0)
    {
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    }
    
    // 下面两段代码是为了测试使用，需要的时候请打开
    [self renderButtons];
    [self loadExampleHtmlPage];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_bridge)
    {
        return;
    }
    
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:_webView];
    
    /*
     // 请按照下面的示例注册你自己的JS方法
     [_bridge registerHandler:@"SQObjcHandler" handler:^(id data, WVJBResponseCallback responseCallback) {
     
         NSLog(@"SQObjcHandler called: %@", data);
         
         responseCallback(@"首汽约车说:收到Javascript的消息啦~~!我也爱你！");
     }];
     
     // 请按照下面的示例调用你自己的JS方法
     [_bridge callHandler:@"SQJavascriptHandler" data:@{ @"首汽约车说": @"Javascript你好！能收到我消息吗？" }];
     */
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"webViewDidFinishLoad");
}

- (void)renderButtons
{
    CGRect rect = self.view.bounds;
    CGFloat yOffset = rect.origin.y + rect.size.height - 35 - 20;
    
    UIFont* font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
    
    UIButton *callbackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [callbackButton setTitle:@"问Javascript你爱我吗？" forState:UIControlStateNormal];
    [callbackButton addTarget:self action:@selector(callHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:callbackButton aboveSubview:_webView];
    callbackButton.frame = CGRectMake(20, yOffset, 200, 35);
    callbackButton.titleLabel.font = font;
    
    UIButton* reloadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [reloadButton setTitle:@"重新加载页面" forState:UIControlStateNormal];
    [reloadButton addTarget:_webView action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:reloadButton aboveSubview:_webView];
    reloadButton.frame = CGRectMake(20 + 200 + 20, yOffset, 100, 35);
    reloadButton.titleLabel.font = font;
}

- (void)callHandler:(id)sender
{
    id data = @{ @"首汽约车说：": @"Hi, JS! 你爱我吗？" };
    [_bridge callHandler:@"SQJavascriptHandler" data:data responseCallback:^(id response) {
        
        NSLog(@"SQJavascriptHandler responded: %@", response);
    }];
}

- (void)loadExampleHtmlPage
{
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"SQExampleHtmlPage" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [_webView loadHTMLString:appHtml baseURL:baseURL];
}


@end
