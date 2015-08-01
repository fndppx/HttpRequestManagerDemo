//
//  ViewController.m
//  HttpRequestManagerDemo
//
//  Created by family on 15/7/7.
//  Copyright (c) 2015年 吴文妹. All rights reserved.
//

#define URL @"http://bcjrest.91baicaijia.com/ad/indexad"
#import "ViewController.h"
#import "WmHttpRequestManager.h"
#import "RequestInfo.h"

@interface ViewController ()<WmHttpRequeestDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createUI];
}

- (void)createUI {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"connect" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor grayColor];
    btn.frame = CGRectMake(40, 140, 100, 30);
    [btn addTarget:self action:@selector(startRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"cancelRequest" forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor grayColor];
    cancelBtn.frame = CGRectMake(160, 140, 100, 30);
    cancelBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [cancelBtn addTarget:self action:@selector(cancelRequest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
}

- (void)startRequest {
    RequestInfo *info = [[RequestInfo alloc]init];
    info.method = HttpRequestMethod_GET;
    info.urlStr = URL;
    info.wmDelegate = self;
    //标记网络请求，可选参数
    info.flagStr = @"first";
    [[WmHttpRequestManager shareManager] startAsyncHttpRequestWithRequestInfo:info];
}

- (void)cancelRequest {
    //在页面dealloc的时候取消请求
    [[WmHttpRequestManager shareManager] cancelRequest];
}

- (void)dealloc {
    [[WmHttpRequestManager shareManager] cancelRequest];
}

#pragma mark - 回调方法
- (void)refreshDataWithDictionary:(NSDictionary *)dic andFlagString:(NSString *)flagStr {
    if ([flagStr isEqualToString:@"first"]) {
        NSLog(@"dic = %@",dic);
    }
}

- (void)connectionFailedWithError:(NSError *)error {
    NSLog(@"error = %@",error.localizedDescription);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
