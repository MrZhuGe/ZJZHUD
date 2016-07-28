//
//  ZJZDefine.h
//  HUD
//
//  Created by 郑家柱 on 16/5/6.
//  Copyright © 2016年 Jiangsu Houxue Network Information Technology Limited By Share Ltd. All rights reserved.
//

#ifndef ZJZDefine_h
#define ZJZDefine_h

#define KZJZHUDRGB(R,G,B,A)         [UIColor colorWithRed:(R/255.0f) green:(G/255.0f) blue:(B/255.0f) alpha:A]

#define KZJZHUDSHOWANIMATIONTIME    0.6f
#define KZJZHUDHIDEANIMATIONTIME    0.3f
#define KZJZHUDANIMATIONDAMPING     0.5f
#define KZJZHUDANIMATIONTIMER       1.8f

/** 图片资源 **/
#define ZJZHUDIMAGEPATH(FILE)       [@"ZJZHUD.bundle" stringByAppendingPathComponent:FILE]

#endif /* ZJZDefine_h */
