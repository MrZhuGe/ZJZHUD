//
//  ZJZHUD.m
//  HUD
//
//  Created by 郑家柱 on 16/5/6.
//  Copyright © 2016年 Jiangsu Houxue Network Information Technology Limited By Share Ltd. All rights reserved.
//

#import "ZJZHUD.h"
#import "ZJZDefine.h"
#import "ZJZLoadingView.h"
#import "ZJZPromptView.h"
#import "NSString+ZJZExten.h"

@interface ZJZHUD ()

@property (nonatomic, assign) ZJZHUDType            type;
@property (nonatomic, strong) ZJZLoadingView        *loadingView;

@end

@implementation ZJZHUD

// MARK: Singleton
+ (instancetype)instance
{
    static ZJZHUD *hud;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [[self alloc] init];
    });
    
    return hud;
}

// MARK: Show
+ (void)show:(ZJZHUDType)hudType status:(NSString *)status
{
    ZJZHUD *hud = [self instance];
    hud.type = hudType;
    
    if (hudType == ZJZHUDTypeLoading) {
        [self showLoadingView:status];
    } else if (hudType == ZJZHUDTypeSucceed) {
        [self showPromptView:ZJZPromptTypeSucceed status:status];
    } else if (hudType == ZJZHUDTypeError) {
        [self showPromptView:ZJZPromptTypeError status:status];
    }
}

+ (void)show:(ZJZHUDType)hudType status:(NSString *)status completion:(void(^)(void))completion
{
    ZJZHUD *hud = [self instance];
    hud.type = hudType;
    
    if (hudType == ZJZHUDTypeLoading) {
        [self showLoadingView:status];
    } else if (hudType == ZJZHUDTypeSucceed) {
        [self showPromptView:ZJZPromptTypeSucceed status:status];
    } else if (hudType == ZJZHUDTypeError) {
        [self showPromptView:ZJZPromptTypeError status:status];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(KZJZHUDSHOWANIMATIONTIME * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion();
    });
}

// MARK: Loading
+ (void)showLoadingView:(NSString *)status
{
    ZJZHUD *hud = [self instance];
    if (!hud.superview) {
        NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
        UIScreen *mainScreen = [UIScreen mainScreen];
        
        for (UIWindow *win in frontToBackWindows) {
            if (win.screen == mainScreen && win.windowLevel == UIWindowLevelNormal) {
                hud.frame = win.frame;
                [win addSubview:hud];
                break;
            }
        }
    }
    
    hud.loadingView = [[ZJZLoadingView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    hud.loadingView.center = CGPointMake(hud.frame.size.width/2, hud.frame.size.height/2);
    [hud.loadingView showLoadingView:status];
    [hud addSubview:hud.loadingView];
}

// MARK: Prompt
+ (void)showPromptView:(ZJZPromptType)promptType status:(NSString *)status
{
    ZJZHUD *hud = [self instance];
    if (!hud.superview) {
        NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication] windows] reverseObjectEnumerator];
        UIScreen *mainScreen = [UIScreen mainScreen];
        
        for (UIWindow *win in frontToBackWindows) {
            if (win.screen == mainScreen && win.windowLevel == UIWindowLevelNormal) {
                hud.frame = win.frame;
                [win addSubview:hud];
                break;
            }
        }
    }
    
    CGSize size = [status countStringSize:CGSizeMake(hud.frame.size.width - 140, FLT_MAX) font:[UIFont boldSystemFontOfSize:13]];
    
    CGFloat width = size.width >= 120 ? size.width : 120;
    CGFloat height = size.height >= 16 ? size.height + 50 : 70;
    height = height > 32 ? 90 : height + 50;
    
    ZJZPromptView *promptView = [[ZJZPromptView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    promptView.center = CGPointMake(hud.frame.size.width/2, hud.frame.size.height/2);
    [promptView showPromptView:promptType status:status];
    [hud addSubview:promptView];
}

// MARK: Dismiss
+ (void)dismiss
{
    ZJZHUD *hud = [self instance];
    if (hud.type == ZJZHUDTypeLoading) {
        [hud.loadingView dismissLoadingView];
    }
}

+ (void)dismiss:(void(^)(void))completion
{
    ZJZHUD *hud = [self instance];
    
    CGFloat time;
    if (hud.type == ZJZHUDTypeLoading) {
        [hud.loadingView dismissLoadingView];
        time = KZJZHUDSHOWANIMATIONTIME + KZJZHUDHIDEANIMATIONTIME;
    } else {
        time = KZJZHUDSHOWANIMATIONTIME + KZJZHUDHIDEANIMATIONTIME + KZJZHUDANIMATIONTIMER;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion();
    });
}

@end
