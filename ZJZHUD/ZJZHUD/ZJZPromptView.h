//
//  ZJZPromptView.h
//  HUD
//
//  Created by 郑家柱 on 16/5/9.
//  Copyright © 2016年 Jiangsu Houxue Network Information Technology Limited By Share Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZJZPromptType)
{
    ZJZPromptTypeSucceed,
    ZJZPromptTypeError
};

@interface ZJZPromptView : UIView

- (void)showPromptView:(ZJZPromptType)promptType status:(NSString *)status;

- (void)dismissPromptView;

@end
