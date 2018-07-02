//
//  NSString+CZHExtension.m
//  CZHTagsView
//
//  Created by 程召华 on 2018/6/25.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "NSString+CZHExtension.h"

@implementation NSString (CZHExtension)

- (CGSize)czh_sizeWithFont:(UIFont *)font maxH:(CGFloat)maxH
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(MAXFLOAT, maxH);
    
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)czh_sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)czh_sizeWithFont:(UIFont *)font
{
    return [self czh_sizeWithFont:font maxW:MAXFLOAT];
}

@end
