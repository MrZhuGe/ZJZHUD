//
//  NSString+ZJZExten.h
//  HUD
//
//  Created by 郑家柱 on 16/5/9.
//  Copyright © 2016年 Jiangsu Houxue Network Information Technology Limited By Share Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (ZJZExten)

/** 动态计算文本高度 **/
- (CGSize)countStringSize:(CGSize)size font:(UIFont *)font;

@end
