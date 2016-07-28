//
//  ViewController.m
//  ZJZHUD
//
//  Created by 郑家柱 on 16/7/28.
//  Copyright © 2016年 Jiangsu Houxue Network Information Technology Limited By Share Ltd. All rights reserved.
//

#import "ViewController.h"
#import "ZJZHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)onLoading:(UIButton *)sender {
    [ZJZHUD show:ZJZHUDTypeLoading status:@"请稍候..."];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [ZJZHUD dismiss];
    });
}

- (IBAction)onSuccess:(UIButton *)sender {
    [ZJZHUD show:ZJZHUDTypeSucceed status:@"成功"];
}

- (IBAction)onFailure:(UIButton *)sender {
    [ZJZHUD show:ZJZHUDTypeError status:@"失败"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
