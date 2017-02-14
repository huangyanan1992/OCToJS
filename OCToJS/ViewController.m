//
//  ViewController.m
//  OCToJS
//
//  Created by Huang Yanan on 2017/2/14.
//  Copyright © 2017年 Huang Yanan. All rights reserved.
//

#import "ViewController.h"
#import "SQJSWebController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)JS:(UIButton *)sender {
    SQJSWebController *jsWebController = [[SQJSWebController alloc] init];
    [self.navigationController pushViewController:jsWebController animated:YES];
}


@end
