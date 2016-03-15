//
//  UIImage+WS.h
//  Image
//
//  Created by 王帅 on 16/3/15.
//  Copyright © 2016年 Mr.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WS)
/**
 *  图片水印
 *
 *  @param bg   背景图片
 *  @param logo 右下角的水印图片
 *
 */
+ (instancetype)waterImageWithBg:(NSString *)bg logo:(NSString *)logo;
/**
 *  图片裁剪
 *
 *  @param name        图片名字
 *  @param borderWidth 边框的宽度
 *  @param borderColor 边框的颜色
 *
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  图片截图
 */
+ (instancetype)captureWithView:(UIView *)view;


@end
