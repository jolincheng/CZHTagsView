//
//  CZHTagsView.h
//  CZHTagsView
//
//  Created by 程召华 on 2018/6/25.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

///留白
typedef NS_ENUM(NSInteger, CZHTagsViewStyle) {
    //默认的,标签文字两边留白是根据代理里面的值算
    CZHTagsViewStyleDefault,
    //标签文字两边留白根据屏幕宽度自适应
    CZHTagsViewStyleFit
    
};

//如果CZHTagsViewStyle == CZHTagsViewStyleDefault是有效
typedef NS_ENUM(NSInteger, CZHTagsViewDisplayMode) {
    ///留白优先
   CZHTagsViewDisplayModePaddingFirst,
    ///内容自适应优先
    CZHTagsViewDisplayModeContentFirst
    
};


//选中模式，默认单选
typedef NS_ENUM(NSInteger, CZHTagsViewSelectMode) {
    ///单选模式
    CZHTagsViewSelectModeSingle,
    ///多选模式
    CZHTagsViewSelectModeMulti
    
};


@class CZHTagsView;
@protocol CZHTagsViewDataSource <NSObject>

@optional

- (NSArray *)czh_tagsArrayInTagsView:(CZHTagsView *)tagsView;

@end

@protocol CZHTagsViewDelegate <NSObject>

@optional

//内边距 默认(0,0,0,0)
- (UIEdgeInsets)czh_insetForTagsView:(CZHTagsView *)tagsView;
//两个标签之前的距离 默认10
- (CGFloat)czh_marginWithForItemInTagsView:(CZHTagsView *)tagsView;
//每一行之前的距离 默认10
- (CGFloat)czh_marginHeightForRowInTagsView:(CZHTagsView *)tagsView;
//标签的高度 默认30
- (CGFloat)czh_heightForItemInTagsView:(CZHTagsView *)tagsView;
//标签文字两边留白 默认5 如果是CZHTagsViewStyleFit，不走这个方法
- (CGFloat)czh_paddingWidthForItemInTagsView:(CZHTagsView *)tagsView;

//字体大小 默认15
- (UIFont *)czh_fontForItemInTagsView:(CZHTagsView *)tagsView;


//边框宽度 默认1
- (CGFloat)czh_borderWidthForItemInTagsView:(CZHTagsView *)tagsView;
//圆角 默认5
- (CGFloat)czh_cornerRadiusForItemInTagsView:(CZHTagsView *)tagsView;

//背景颜色 默认透明
- (UIColor *)czh_backgroundColorForItemInTagsView:(CZHTagsView *)tagsView;
//边框颜色 默认黑色
- (UIColor *)czh_borderColorForItemInTagsView:(CZHTagsView *)tagsView;
//字体颜色 默认 黑色
- (UIColor *)czh_textColorForItemInTagsView:(CZHTagsView *)tagsView;

//选中状态背景颜色 默认透明
- (UIColor *)czh_selectBackgroundColorForItemInTagsView:(CZHTagsView *)tagsView;
//选中边框颜色 默认黑色
- (UIColor *)czh_selectBorderColorForItemInTagsView:(CZHTagsView *)tagsView;
//字体颜色 默认 黑色
- (UIColor *)czh_selectTextColorForItemInTagsView:(CZHTagsView *)tagsView;

//选中
- (void)czh_tagsView:(CZHTagsView *)tagsView didSelectItemWithSelectTagsArray:(NSArray *)selectTagsArray;

@end

@interface CZHTagsView : UIView


///代理
@property (nonatomic, weak) id<CZHTagsViewDelegate> delegate;
///代理
@property (nonatomic, weak) id<CZHTagsViewDataSource> dataSource;


- (instancetype)initWithFrame:(CGRect)frame style:(CZHTagsViewStyle)style;


- (instancetype)initWithFrame:(CGRect)frame style:(CZHTagsViewStyle)style selectMode:(CZHTagsViewSelectMode)selectMode;

/**
 * frame : 高度为0的时候默认自适应高度计算
 * CZHTagsViewStyle : 每个标签两边的留白
 * selectMode       : 选中模式 单选和多选
 * displayMode      : 当一个标签超过视图的宽度设置内容自适应优先或者留白优先
 */
- (instancetype)initWithFrame:(CGRect)frame style:(CZHTagsViewStyle)style selectMode:(CZHTagsViewSelectMode)selectMode displayMode:(CZHTagsViewDisplayMode)displayMode;

//刷新
- (void)reloadData;

@end



