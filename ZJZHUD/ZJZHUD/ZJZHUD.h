//
//  ZJZHUD.h
//  HUD
//
//  Created by 郑家柱 on 16/5/6.
//  Copyright © 2016年 Jiangsu Houxue Network Information Technology Limited By Share Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZJZHUDType)
{
    ZJZHUDTypeLoading,
    ZJZHUDTypeSucceed,
    ZJZHUDTypeError
};

@interface ZJZHUD : UIView

// MARK: Singleton(单例)
+ (instancetype)instance;

// MARK: Show
+ (void)show:(ZJZHUDType)hudType status:(NSString *)status;

+ (void)show:(ZJZHUDType)hudType status:(NSString *)status completion:(void(^)(void))completion;

// MARK: Hide
+ (void)dismiss;

+ (void)dismiss:(void(^)(void))completion;

@end
