//
//  CZHRootController.m
//  CZHTagsView
//
//  Created by 程召华 on 2018/6/25.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "CZHRootController.h"
#import "Header.h"
#import "CZHFitController.h"
#import "CZHDefaultController.h"
@interface CZHRootModel : NSObject
///<#注释#>
@property (nonatomic, copy) NSString *title;
///<#注释#>
@property (nonatomic, copy) void (^selectHandler)(void);

+ (instancetype)czh_modelWithTitle:(NSString *)title selectHandler:(void (^)(void))selectHandler;

@end


@implementation CZHRootModel

+ (instancetype)czh_modelWithTitle:(NSString *)title selectHandler:(void (^)(void))selectHandler {
    
    return [[self alloc] initWithTitle:title selectHandler:selectHandler];
}

- (instancetype)initWithTitle:(NSString *)title selectHandler:(void (^)(void))selectHandler {
    
    if (self = [super init]) {
        self.title = title;
        self.selectHandler = selectHandler;
    }
    return self;
}

@end


@interface CZHRootController ()<UITableViewDataSource, UITableViewDelegate>
///
@property (nonatomic, weak) UITableView *tableView;
///<#注释#>
@property (nonatomic, strong) NSMutableArray *listArray;
@end

@implementation CZHRootController

- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [NSMutableArray array];
        CZHWeakSelf(self);
        CZHRootModel *modelOne = [CZHRootModel czh_modelWithTitle:@"标签宽度自适应字符串以及单选" selectHandler:^{
            CZHStrongSelf(self);
            
            CZHDefaultController *defaultVc = [[CZHDefaultController alloc] init];
            [self.navigationController pushViewController:defaultVc animated:YES];
            
        }];
        
        CZHRootModel *modelTwo = [CZHRootModel czh_modelWithTitle:@"标签宽度自适应view最大宽度以及多选中" selectHandler:^{
            CZHStrongSelf(self);
            
            CZHFitController *fitVc = [[CZHFitController alloc] init];
            [self.navigationController pushViewController:fitVc animated:YES];
        }];
        
        [_listArray addObject:modelOne];
        [_listArray addObject:modelTwo];
    }
    return _listArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self czh_setUpView];
}


- (void)czh_setUpView {
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.tableFooterView = [[UIView alloc] init];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    CZHRootModel *model = self.listArray[indexPath.row];
    
    cell.textLabel.text = model.title;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CZHRootModel *model = self.listArray[indexPath.row];
    
    if (model.selectHandler) {
        model.selectHandler();
    }
    
}


@end
