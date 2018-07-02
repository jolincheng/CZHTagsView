# CZHTagsView

![公司的项目.png](https://upload-images.jianshu.io/upload_images/6709174-4b217cb5f07b1f6f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

公司的项目，求支持，如果发现什么问题，可以留言反应，感激不尽


标签页,可以自适应高度,支持单选多选,修改选中状态和默认状态各种参数,

![QQ20180702-180020----.gif](https://upload-images.jianshu.io/upload_images/6709174-8665e808960a9edc.gif?imageMogr2/auto-orient/strip)

```
枚举说明

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
```
```
初始化
- (instancetype)initWithFrame:(CGRect)frame style:(CZHTagsViewStyle)style;


- (instancetype)initWithFrame:(CGRect)frame style:(CZHTagsViewStyle)style selectMode:(CZHTagsViewSelectMode)selectMode;

/**
 * frame : 高度为0的时候默认自适应高度计算
 * CZHTagsViewStyle : 每个标签两边的留白
 * selectMode       : 选中模式 单选和多选
 * displayMode      : 当一个标签超过视图的宽度设置内容自适应优先或者留白优先
 */
- (instancetype)initWithFrame:(CGRect)frame style:(CZHTagsViewStyle)style selectMode:(CZHTagsViewSelectMode)selectMode displayMode:(CZHTagsViewDisplayMode)displayMode;

```

```
数据源方法
@protocol CZHTagsViewDataSource <NSObject>

@optional

- (NSArray *)czh_tagsArrayInTagsView:(CZHTagsView *)tagsView;

@end
```

```
代理方法
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
```

```
使用
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = CZHColor(0xf6f6f6);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CZHTagsView *tags = [[CZHTagsView alloc] initWithFrame:CGRectMake(0, CZHNavigationBarHeight, ScreenWidth, CZH_ScaleWidth(150)) style:CZHTagsViewStyleDefault];
    tags.backgroundColor = CZHRGBColor(0xdfdfdf, 0.5);
    tags.dataSource = self;
    tags.delegate = self;
    [self.view addSubview:tags];
    
    //模拟请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [tags reloadData];
        
    
    });
    
}

- (NSArray *)czh_tagsArrayInTagsView:(CZHTagsView *)tagsView {
    
    return @[@"haha",@"啦啦啦", @"aksdjajdasjdlkajdlkasjdlkasjdlkjas",@"哦哦哦",@"打死，打哈哈打开时间",@"奥术大师大技术的",@"😀",@"奥术大师大所",@"啊实打实的zdsdadasdasdasdasdas卡斯柯asdjagjdhgahjsdghjasgd",@"拉删掉了；卡死；打了卡", @"skjdakjdlkasjdlkjadlkjaslkdjaklsdj"];
    
}

- (CGFloat)czh_paddingWidthForItemInTagsView:(CZHTagsView *)tagsView {
    return 10;
}

- (CGFloat)czh_heightForItemInTagsView:(CZHTagsView *)tagsView {
    return 20;
}

- (CGFloat)czh_marginHeightForRowInTagsView:(CZHTagsView *)tagsView {
    return 30;
}

- (CGFloat)czh_marginWithForItemInTagsView:(CZHTagsView *)tagsView {
    return 5;
}

- (UIEdgeInsets)czh_insetForTagsView:(CZHTagsView *)tagsView {
    return UIEdgeInsetsMake(10, 20, 10, 10);
}


- (UIColor *)czh_selectBackgroundColorForItemInTagsView:(CZHTagsView *)tagsView {
    return [UIColor greenColor];
}

- (UIColor *)czh_selectTextColorForItemInTagsView:(CZHTagsView *)tagsView {
    return [UIColor whiteColor];
}

- (UIColor *)czh_selectBorderColorForItemInTagsView:(CZHTagsView *)tagsView {
    return [UIColor redColor];
}

- (void)czh_tagsView:(CZHTagsView *)tagsView didSelectItemWithSelectTagsArray:(NSArray *)selectTagsArray {
    
    NSString *string = [selectTagsArray componentsJoinedByString:@","];
    
    CZHLog(@"---选中的字符串==%@", string);
    
}
```

[博客地址](https://blog.csdn.net/HurryUpCheng)
[简书地址](https://www.jianshu.com/p/882c41abccd1)


