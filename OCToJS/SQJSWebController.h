//
//  SQJSWebController.h
//  OCToJS
//
//  Created by Huang Yanan on 2017/2/14.
//  Copyright © 2017年 Huang Yanan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface SQJSWebController : UIViewController<WKNavigationDelegate>

@property (nonatomic, copy) NSString *url;

@end
