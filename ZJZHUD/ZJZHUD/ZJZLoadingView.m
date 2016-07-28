//
//  ZJZLoadingView.m
//  HUD
//
//  Created by 郑家柱 on 16/5/6.
//  Copyright © 2016年 Jiangsu Houxue Network Information Technology Limited By Share Ltd. All rights reserved.
//

#import "ZJZLoadingView.h"
#import "ZJZDefine.h"

@interface ZJZLoadingView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation ZJZLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KZJZHUDRGB(40, 40, 40, 0.8f);
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10.0f;
        [self initLoadingView];
    }
    return self;
}

//MARK: 创建圆弧
- (void)initLoadingView
{
    self.shapeLayer = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.imageView.frame.size.width/2, self.imageView.frame.size.height/2) radius:self.imageView.frame.size.width/2 - 1 startAngle:M_PI endAngle:M_PI * 3 clockwise:YES];
    
    self.shapeLayer.path = path.CGPath;
    self.shapeLayer.lineWidth = 3.0f;
    self.shapeLayer.strokeStart = 0.0f;
    self.shapeLayer.strokeEnd = 0.25f;
    self.shapeLayer.lineCap = kCALineCapRound;
    self.shapeLayer.lineJoin = kCALineJoinBevel;
    self.shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    self.shapeLayer.strokeColor = [[UIColor orangeColor] CGColor];
    self.shapeLayer.frame = self.imageView.frame;
    [self.layer addSublayer:self.shapeLayer];
}

// MARK: 开始动画
- (void)showLoadingView:(NSString *)status
{
    self.title.text = status;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI - 1, 0, 0, 1)];
    animation.duration = 0.2f;
    animation.repeatCount = MAXFLOAT;
    animation.cumulative = YES;
    
    [self.shapeLayer addAnimation:animation forKey:@"LoadingView"];
    
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    
    [UIView animateWithDuration:KZJZHUDSHOWANIMATIONTIME delay:0.0f usingSpringWithDamping:KZJZHUDANIMATIONDAMPING initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    } completion:^(BOOL finished) {
        
    }];
}

// MARK: 结束动画
- (void)dismissLoadingView
{
    
    [UIView animateWithDuration:KZJZHUDHIDEANIMATIONTIME animations:^{
        self.transform = CGAffineTransformMakeScale(0.05f, 0.05f);
    } completion:^(BOOL finished) {
        
        [self.shapeLayer removeAnimationForKey:@"LoadingView"];
        [self.shapeLayer removeFromSuperlayer];
        [self.superview removeFromSuperview];
        [self removeFromSuperview];
    }];
    
}

// MARK: 懒加载
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _imageView.center = CGPointMake(self.frame.size.width/2, (self.frame.size.height - 20)/2);
        _imageView.image = [UIImage imageNamed:ZJZHUDIMAGEPATH(@"hud_logo")];
        [self addSubview:_imageView];
    }
    
    return _imageView;
}

- (UILabel *)title
{
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 20)];
        _title.font = [UIFont boldSystemFontOfSize:13];
        _title.textColor = [UIColor whiteColor];
        _title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_title];
    }
    
    return _title;
}

@end
