//
//  ZJZPromptView.m
//  HUD
//
//  Created by 郑家柱 on 16/5/9.
//  Copyright © 2016年 Jiangsu Houxue Network Information Technology Limited By Share Ltd. All rights reserved.
//

#import "ZJZPromptView.h"
#import "ZJZDefine.h"

@interface ZJZPromptView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *title;

@end

@implementation ZJZPromptView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KZJZHUDRGB(40, 40, 40, 0.8f);
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10.0f;
    }
    return self;
}

// MARK: 创建提示
- (void)showPromptView:(ZJZPromptType)promptType status:(NSString *)status
{
    if (promptType == ZJZPromptTypeSucceed) {
        [self showSucceed:status];
    } else if (promptType == ZJZPromptTypeError) {
        [self showError:status];
    }
}

// MARK: 成功提示
- (void)showSucceed:(NSString *)status
{
    self.imageView.image = [UIImage imageNamed:ZJZHUDIMAGEPATH(@"hud_success")];
    self.title.text = status;
    
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    [UIView animateWithDuration:KZJZHUDSHOWANIMATIONTIME delay:0.0f usingSpringWithDamping:KZJZHUDANIMATIONDAMPING initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    } completion:^(BOOL finished) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:KZJZHUDANIMATIONTIMER target:self selector:@selector(onTimerClicked:) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }];
}

// MARK: 失败提示
- (void)showError:(NSString *)status
{
    self.imageView.image = [UIImage imageNamed:ZJZHUDIMAGEPATH(@"hud_error")];
    self.title.text = status;
    
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    [UIView animateWithDuration:KZJZHUDSHOWANIMATIONTIME delay:0.0f usingSpringWithDamping:KZJZHUDANIMATIONDAMPING initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    } completion:^(BOOL finished) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:KZJZHUDANIMATIONTIMER target:self selector:@selector(onTimerClicked:) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }];
}

// MARK: 销毁提示
- (void)dismissPromptView
{
    [UIView animateWithDuration:KZJZHUDHIDEANIMATIONTIME animations:^{
        self.transform = CGAffineTransformMakeScale(0.05f, 0.05f);
    } completion:^(BOOL finished) {
        [self.superview removeFromSuperview];
        [self removeFromSuperview];
    }];
}

// MARK: 定时器
- (void)onTimerClicked:(NSTimer *)timer
{
    [self dismissPromptView];
    
    [timer invalidate];
}

// MARK: 懒加载
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 30)/2, 15, 30, 30)];
        [self addSubview:_imageView];
    }
    
    return _imageView;
}

- (UILabel *)title
{
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, self.frame.size.width - 20, self.frame.size.height - 50)];
        _title.numberOfLines = 0;
        _title.font = [UIFont boldSystemFontOfSize:13];
        _title.textColor = [UIColor whiteColor];
        _title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_title];
    }
    
    return _title;
}

@end
