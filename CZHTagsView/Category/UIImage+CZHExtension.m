//
//  UIImage+CZHExtension.m
//  CZHTagsView
//
//  Created by 程召华 on 2018/6/26.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "UIImage+CZHExtension.h"

@implementation UIImage (CZHExtension)


//颜色转换图片
+ (UIImage *)czh_imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
