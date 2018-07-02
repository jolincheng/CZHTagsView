//
//  CZHTagsView.m
//  CZHTagsView
//
//  Created by 程召华 on 2018/6/25.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "CZHTagsView.h"
#import "Header.h"



@interface CZHTagItem : UIButton

///标签内边宽度
@property (nonatomic, assign) CGFloat paddingWidth;
///内容显示
@property (nonatomic, assign) CZHTagsViewDisplayMode displayMode;

+ (instancetype)czh_czh_tagItemWithPaddingWidth:(CGFloat)paddingWidth displayMode:(CZHTagsViewDisplayMode)displayMode;

@end


@implementation CZHTagItem


+ (instancetype)czh_czh_tagItemWithPaddingWidth:(CGFloat)paddingWidth displayMode:(CZHTagsViewDisplayMode)displayMode {
    return [[CZHTagItem alloc] initWithPaddingWidth:paddingWidth displayMode:displayMode];
}

- (instancetype)initWithPaddingWidth:(CGFloat)paddingWidth displayMode:(CZHTagsViewDisplayMode)displayMode {
    
    if (self = [super init]) {
        
        self.paddingWidth = paddingWidth;
        
        self.displayMode = displayMode;
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.displayMode == CZHTagsViewDisplayModePaddingFirst) {
        
        self.titleLabel.czh_width = self.czh_width - self.paddingWidth * 2;
        self.titleLabel.czh_x = self.paddingWidth;
        
    } else {
        self.titleLabel.czh_width = self.czh_width;
        self.titleLabel.czh_x = 0;
    }
    
}

@end;


@interface CZHTagsView ()

///两个标签之前的距离
@property (nonatomic, assign) CGFloat marginWidthForItem;
///两行标签之前的高度
@property (nonatomic, assign) CGFloat marginHeightForRow;
///标签的高度
@property (nonatomic, assign) CGFloat heightForItem;
///标签内边宽度
@property (nonatomic, assign) CGFloat paddingWidthForItem;
///
@property (nonatomic, assign) UIEdgeInsets insetForTagsView;

///边框宽度
@property (nonatomic, assign) CGFloat borderWidthForItem;
///圆角
@property (nonatomic, assign) CGFloat cornerRadiusForItem;
///字体大小
@property (nonatomic, strong) UIFont *fontForItem;

///字体颜色
@property (nonatomic, strong) UIColor *textColorForItem;
///选中字体颜色
@property (nonatomic, strong) UIColor *selectTextColorForItem;

///边框颜色
@property (nonatomic, strong) UIColor *borderColorForItem;
///背景颜色
@property (nonatomic, strong) UIColor *backgroundColorForItem;

///选中边框颜色
@property (nonatomic, strong) UIColor *selectBorderColorForItem;
///选中背景颜色
@property (nonatomic, strong) UIColor *selectBackgroundColorForItem;

///数组
@property (nonatomic, strong) NSArray *tagsArray;
///
@property (nonatomic, weak) UIScrollView *scrollView;
///<#注释#>
@property (nonatomic, weak) UIView *containerView;
///留白类型
@property (nonatomic, assign) CZHTagsViewStyle style;
///选中类型
@property (nonatomic, assign) CZHTagsViewSelectMode selectMode;
///显示类型
@property (nonatomic, assign) CZHTagsViewDisplayMode displayMode;
///单选模式使用
@property (nonatomic, strong) CZHTagItem *selectItem;
///选中
@property (nonatomic, strong) NSMutableArray *selectTagsArray;
///原始高度为0则高度自适应
@property (nonatomic, assign) CGFloat originHeight;

@end



@implementation CZHTagsView


- (NSMutableArray *)selectTagsArray {
    if (!_selectTagsArray) {
        _selectTagsArray = [NSMutableArray array];
    }
    return _selectTagsArray;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    return [[CZHTagsView alloc] initWithFrame:frame style:CZHTagsViewStyleDefault];
    
}

- (instancetype)init {

    return [[CZHTagsView alloc] initWithFrame:CGRectZero style:CZHTagsViewStyleDefault];

}

- (instancetype)initWithFrame:(CGRect)frame style:(CZHTagsViewStyle)style {
    
    return [[CZHTagsView alloc] initWithFrame:frame style:style selectMode:CZHTagsViewSelectModeSingle];
}

- (instancetype)initWithFrame:(CGRect)frame style:(CZHTagsViewStyle)style selectMode:(CZHTagsViewSelectMode)selectMode {
    

    return [[CZHTagsView alloc] initWithFrame:frame style:style selectMode:selectMode displayMode:style == CZHTagsViewStyleFit ? CZHTagsViewDisplayModeContentFirst : CZHTagsViewDisplayModePaddingFirst];
    
}

- (instancetype)initWithFrame:(CGRect)frame style:(CZHTagsViewStyle)style selectMode:(CZHTagsViewSelectMode)selectMode displayMode:(CZHTagsViewDisplayMode)displayMode {
    
    if (self = [super initWithFrame:frame]) {
        
        self.originHeight = frame.size.height;
        
        self.style = style;
        
        self.displayMode = displayMode;
        
        self.selectMode = selectMode;
        
        [self czh_initialize];
        
        [self czh_setView];
        
    }
    return self;
}


- (void)czh_initialize {
    
    self.insetForTagsView = UIEdgeInsetsMake(0, 0, 0, 0);
    self.marginWidthForItem = 10;
    self.marginHeightForRow = 10;
    self.heightForItem = 30;
    self.paddingWidthForItem = self.style == CZHTagsViewStyleFit ? 0 : 5;
    self.fontForItem = [UIFont systemFontOfSize:15];
    
    self.cornerRadiusForItem = 5;
    self.borderWidthForItem = 1;
    
    self.borderColorForItem = [UIColor blackColor];
    self.backgroundColorForItem = [UIColor clearColor];
    
    self.selectBorderColorForItem = [UIColor blackColor];
    self.selectBackgroundColorForItem = [UIColor clearColor];
    
    self.textColorForItem = [UIColor blackColor];
    self.selectTextColorForItem = [UIColor blackColor];
    
}

- (void)czh_setView {
    
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
//    scrollView.backgroundColor = CZHColor(0xff0000);
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    
    UIView *containerView = [[UIView alloc] init];
//    containerView.backgroundColor = CZHColor(0x00ff00);
    [scrollView addSubview:containerView];
    self.containerView = containerView;
    
    
}


- (void)reloadData {
    
    [self setDataSource:self.dataSource];
    
}

//重写set
- (void)setDataSource:(id<CZHTagsViewDataSource>)dataSource {
    _dataSource = dataSource;
    if (_dataSource && [_dataSource respondsToSelector:@selector(czh_tagsArrayInTagsView:)]) {
        
        NSArray *tagsArray = [_dataSource czh_tagsArrayInTagsView:self];
        
        if (tagsArray.count > 0) {
            self.tagsArray = tagsArray;
        }
    }
}



- (void)setDelegate:(id<CZHTagsViewDelegate>)delegate {
    _delegate = delegate;
    
    if (_delegate && [_delegate respondsToSelector:@selector(czh_insetForTagsView:)]) {
        UIEdgeInsets insetForTagsView = [_delegate czh_insetForTagsView:self];
        
        self.insetForTagsView = insetForTagsView;
        
//        self.scrollView.contentInset = UIEdgeInsetsMake(insets.top, insets.left, insets.bottom, insets.right);
 
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(czh_marginWithForItemInTagsView:)]) {//获取标签之前的宽度
        CGFloat marginWidthForItem = [_delegate czh_marginWithForItemInTagsView:self];
        
        self.marginWidthForItem = marginWidthForItem;
        
        CZHLog(@"--marginWidthForItem=%f", marginWidthForItem);
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(czh_marginHeightForRowInTagsView:)]) {//获取每行之前的高度
        
        CGFloat marginHeightForRow = [_delegate czh_marginHeightForRowInTagsView:self];
        
        self.marginHeightForRow = marginHeightForRow;
        
        CZHLog(@"--marginHeightForRow=%f", marginHeightForRow);
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(czh_heightForItemInTagsView:)]) {//获取标签高度
        
        CGFloat heightForItem = [_delegate czh_heightForItemInTagsView:self];
        
        self.heightForItem = heightForItem;
        
        CZHLog(@"--heightForItem=%f", heightForItem);
        
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(czh_paddingWidthForItemInTagsView:)] && self.style != CZHTagsViewStyleFit) {//如果不是CZHTagsViewStyleFit，走下面方法
        
        CGFloat paddingWidthForItem = [_delegate czh_paddingWidthForItemInTagsView:self];
        
        self.paddingWidthForItem = paddingWidthForItem;
        
        CZHLog(@"--paddingWidthForItem=%f", paddingWidthForItem);
        
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(czh_borderWidthForItemInTagsView:)]) {//变框宽度
        CGFloat borderWidthForItem = [_delegate czh_borderWidthForItemInTagsView:self];
        
        self.borderWidthForItem = borderWidthForItem;
    }

    if (_delegate && [_delegate respondsToSelector:@selector(czh_cornerRadiusForItemInTagsView:)]) {//圆角
        CGFloat cornerRadiusForItem = [_delegate czh_cornerRadiusForItemInTagsView:self];
        
        self.cornerRadiusForItem = cornerRadiusForItem;
    }
    

    if (_delegate && [_delegate respondsToSelector:@selector(czh_fontForItemInTagsView:)]) {//标签字体大小
        UIFont *fontForItem = [_delegate czh_fontForItemInTagsView:self];
        
        self.fontForItem = fontForItem;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(czh_textColorForItemInTagsView:)]) {//标签字体颜色
        UIColor *textColorForItem = [_delegate czh_textColorForItemInTagsView:self];
        
        self.textColorForItem = textColorForItem;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(czh_selectTextColorForItemInTagsView:)]) {//选中标签字体颜色
        UIColor *selectTextColorForItem = [_delegate czh_selectTextColorForItemInTagsView:self];
        
        self.selectTextColorForItem = selectTextColorForItem;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(czh_backgroundColorForItemInTagsView:)]) {//标签背景颜色
        UIColor *backgroundColorForItem = [_delegate czh_backgroundColorForItemInTagsView:self];
        
        self.backgroundColorForItem = backgroundColorForItem;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(czh_borderColorForItemInTagsView:)]) {//边框颜色
        UIColor *borderColorForItem = [_delegate czh_borderColorForItemInTagsView:self];
        
        self.borderColorForItem = borderColorForItem;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(czh_selectBackgroundColorForItemInTagsView:)]) {//标签背景颜色
        UIColor *selectBackgroundColorForItem = [_delegate czh_selectBackgroundColorForItemInTagsView:self];
        
        self.selectBackgroundColorForItem = selectBackgroundColorForItem;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(czh_selectBorderColorForItemInTagsView:)]) {//边框颜色
        UIColor *selectBorderColorForItem = [_delegate czh_selectBorderColorForItemInTagsView:self];
        
        self.selectBorderColorForItem = selectBorderColorForItem;
    }
    
    [self reloadData];
    
}




- (void)setTagsArray:(NSArray *)tagsArray {
    _tagsArray = tagsArray;
    
    
    [self.containerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    
    if (self.style == CZHTagsViewStyleDefault) {
        
        [self czh_layoutWithDefaultStyle];
        
    } else if (self.style == CZHTagsViewStyleFit) {

        [self czh_layoutWithFitStyle];
    }
}



- (void)czh_layoutWithFitStyle {
    

    //标签之间的间距
    CGFloat tagsMargin = self.marginWidthForItem;
    //行间距
    CGFloat tagsLineSpacing = self.marginHeightForRow;
    //标签字体
    UIFont *tagsFont = self.fontForItem;
    
    CGFloat containerViewWidth = self.czh_width;
    
    
    // 下一个标签的宽度
    CGFloat nextTagsW = 0;
    CGFloat nextTagsX = 0;
    //当前标签宽度
    CGFloat currentTagsW = 0;
    CGFloat currentTagsX = self.insetForTagsView.left;
 
    CGFloat moreWidth = 0;  // 每一行多出来的宽度
    
    //每一行的最后一个tag的索引的数组和每一行多出来的宽度的数组
    NSMutableArray *lastIndexs = [NSMutableArray array];
    NSMutableArray *moreWidths = [NSMutableArray array];
    
    for (NSInteger i=0; i<_tagsArray.count; i++) {
        
        NSString *currentTags = self.tagsArray[i];
        
        currentTagsW = [currentTags czh_sizeWithFont:tagsFont].width;
        
        if (i < self.tagsArray.count - 1) {
            
            NSString *nextTags = self.tagsArray[i + 1];
            
            nextTagsW = [nextTags czh_sizeWithFont:tagsFont].width;
        }
        
        nextTagsX = currentTagsX + currentTagsW + tagsMargin;
        
        if (nextTagsX + nextTagsW + self.insetForTagsView.right > containerViewWidth) {//下一个标签如果大于最大宽度，换行
            
            moreWidth = containerViewWidth - nextTagsX - self.insetForTagsView.right;
            
            [lastIndexs addObject:[NSNumber numberWithInteger:i]];
            [moreWidths addObject:[NSNumber numberWithFloat:moreWidth]];
            
            nextTagsX = self.insetForTagsView.left;
            
        }
        
        currentTagsX = nextTagsX;
        
        // 如果是最后一个且数组中没有，则把最后一个加入数组
        if (i == _tagsArray.count -1) {
            if (![lastIndexs containsObject:[NSNumber numberWithInteger:i]]) {
                [lastIndexs addObject:[NSNumber numberWithInteger:i]];
                [moreWidths addObject:[NSNumber numberWithFloat:0]];
            }
        }
        
    }
    
    
    NSInteger location = 0;  // 截取的位置
    NSInteger length = 0;    // 截取的长度
    CGFloat averageW = 0;    // 多出来的平均的宽度
    CGFloat tagW = 0;
    CGFloat tagH = self.heightForItem;
    
    for (NSInteger i = 0; i < lastIndexs.count; i++) {
        
        NSInteger lastIndex = [lastIndexs[i] integerValue];
        if (i == 0) {
            length = lastIndex + 1;
        }else{
            length = [lastIndexs[i] integerValue] - [lastIndexs[i-1] integerValue];
        }
        // 从数组中截取每一行的数组
        NSArray *newArr = [_tagsArray subarrayWithRange:NSMakeRange(location, length)];
        
        averageW = [moreWidths[i] floatValue] / newArr.count;
        CGFloat tagX = self.insetForTagsView.left;
        CGFloat tagY = (tagsLineSpacing + tagH) * i + self.insetForTagsView.top;
        
        for (NSInteger j = 0; j < newArr.count; j++) {
            
            NSString *currentTags = newArr[j];
            
            tagW = [currentTags czh_sizeWithFont:tagsFont].width + averageW;
            
            
            [self czh_setUpTagItemWithTag:location + j frame:CGRectMake(tagX, tagY, tagW, tagH) title:currentTags];
            
            
            tagX += (tagW + tagsMargin);
        }
        //计算位置
        location = lastIndex + 1;
    }

    CGFloat height = (tagH + tagsLineSpacing) * lastIndexs.count - tagsLineSpacing + self.insetForTagsView.top + self.insetForTagsView.bottom;
    
    self.containerView.frame = CGRectMake(0, 0, containerViewWidth, height);

    self.scrollView.contentSize = CGSizeMake(0, height);
    
    if (self.originHeight <= 0) {
        self.scrollView.czh_height = height;
        
        self.czh_height = height;
    }

}


- (void)czh_layoutWithDefaultStyle {
    
    
    //标签内部文字距离左右的间距
    CGFloat tagsMinPadding = self.paddingWidthForItem;
    //标签之前的间距
    CGFloat tagsMargin = self.marginWidthForItem;
    //行间距
    CGFloat tagsLineSpacing = self.marginHeightForRow;
    
    //标签字体
    UIFont *tagsFont = self.fontForItem;
    
    CGFloat tagsHeight = self.heightForItem;
    
    CGFloat containerViewWidth = self.czh_width;
    
    CGFloat tagsMaxWidth = containerViewWidth - self.insetForTagsView.left - self.insetForTagsView.right;
    
    // 下一个标签的宽度
    CGFloat nextTagsW = 0;
    CGFloat nextTagsX = 0;
    CGFloat nextTagsY = self.insetForTagsView.top;
    //当前标签宽度
    CGFloat currentTagsW = 0;
    CGFloat currentTagsX = self.insetForTagsView.left;
    CGFloat currentTagsY = self.insetForTagsView.top;
    CGFloat currentTagsH = tagsHeight;
    
    for (NSInteger i = 0; i < self.tagsArray.count; i++) {
        
        
        NSString *currentTags = self.tagsArray[i];
        
        currentTagsW = [currentTags czh_sizeWithFont:tagsFont].width + tagsMinPadding * 2;
        
        if (i < self.tagsArray.count - 1) {
            
            NSString *nextTags = self.tagsArray[i + 1];
            
            nextTagsW = [nextTags czh_sizeWithFont:tagsFont].width + tagsMinPadding * 2;
        }
        
        nextTagsX = currentTagsX + currentTagsW + tagsMargin;
        
        if (nextTagsX + nextTagsW + self.insetForTagsView.right > containerViewWidth) {//下一个标签如果大于最大宽度，换行
            
            nextTagsX = self.insetForTagsView.left;
            nextTagsY = currentTagsY + tagsHeight + tagsLineSpacing;
            
            if (currentTagsW > tagsMaxWidth) {
                currentTagsW = tagsMaxWidth;
            }
        }
        
        [self czh_setUpTagItemWithTag:i frame:CGRectMake(currentTagsX, currentTagsY, currentTagsW, currentTagsH) title:currentTags];
 
        currentTagsX = nextTagsX;
        currentTagsY = nextTagsY;
    }
    
    currentTagsY =  currentTagsY - tagsLineSpacing + self.insetForTagsView.bottom;
    
    self.containerView.frame = CGRectMake(0, 0, containerViewWidth, currentTagsY);
    
    self.scrollView.contentSize = CGSizeMake(0, currentTagsY);
    
    if (self.originHeight <= 0) {
        
        self.scrollView.czh_height = currentTagsY;
        
        self.czh_height = currentTagsY;
    }
}


- (void)czh_setUpTagItemWithTag:(NSInteger)tag frame:(CGRect)frame title:(NSString *)title {
    
    CZHTagItem *tagItem = [CZHTagItem czh_czh_tagItemWithPaddingWidth:self.paddingWidthForItem displayMode:self.displayMode];
    tagItem.tag = tag;
    tagItem.frame = frame;
    [tagItem setTitle:title forState:UIControlStateNormal];
    [tagItem setTitleColor:self.textColorForItem forState:UIControlStateNormal];
    [tagItem setTitleColor:self.selectTextColorForItem forState:UIControlStateSelected];
    tagItem.titleLabel.font = self.fontForItem;
    tagItem.layer.cornerRadius = self.cornerRadiusForItem;
    tagItem.layer.borderWidth = self.borderWidthForItem;
    tagItem.layer.borderColor = self.borderColorForItem.CGColor;
    tagItem.layer.masksToBounds = YES;
    tagItem.selected = NO;
    [tagItem setBackgroundImage:[UIImage czh_imageWithColor:self.backgroundColorForItem] forState:UIControlStateNormal];
    [tagItem setBackgroundImage:[UIImage czh_imageWithColor:self.selectBackgroundColorForItem] forState:UIControlStateSelected];
    tagItem.backgroundColor = self.backgroundColorForItem;
    [tagItem addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:tagItem];
}


- (void)buttonClick:(CZHTagItem *)sender {

    
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) {//选中
        sender.layer.borderColor = self.selectBorderColorForItem.CGColor;
        [self.selectTagsArray addObject:[self.tagsArray objectAtIndex:sender.tag]];
    } else {//非选中
        sender.layer.borderColor = self.borderColorForItem.CGColor;
        [self.selectTagsArray removeObject:[self.tagsArray objectAtIndex:sender.tag]];
    }
    
    if (self.selectMode == CZHTagsViewSelectModeSingle) {//单选模式
        
        if (self.selectItem == sender) {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(czh_tagsView:didSelectItemWithSelectTagsArray:)]) {
                [self.delegate czh_tagsView:self didSelectItemWithSelectTagsArray:self.selectTagsArray];
            }
            
            return;
        }
    
        self.selectItem.layer.borderColor = self.borderColorForItem.CGColor;
        
        [self.selectTagsArray removeObject:[self.tagsArray objectAtIndex:self.selectItem.tag]];
        
        self.selectItem.selected = NO;

        self.selectItem = sender;
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(czh_tagsView:didSelectItemWithSelectTagsArray:)]) {
        [self.delegate czh_tagsView:self didSelectItemWithSelectTagsArray:self.selectTagsArray];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    
 
}

@end
