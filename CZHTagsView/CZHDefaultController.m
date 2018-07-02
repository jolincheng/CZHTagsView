//
//  CZHDefaultController.m
//  CZHTagsView
//
//  Created by 程召华 on 2018/6/25.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "CZHDefaultController.h"
#import "CZHTagsView.h"
#import "Header.h"
@interface CZHDefaultController ()<CZHTagsViewDelegate, CZHTagsViewDataSource>

@end

@implementation CZHDefaultController

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

@end
