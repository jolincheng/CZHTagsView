//
//  AppDelegate+CZHRootController.m
//  CZHTagsView
//
//  Created by 程召华 on 2018/6/25.
//  Copyright © 2018年 程召华. All rights reserved.
//

#import "AppDelegate+CZHRootController.h"
#import "CZHRootController.h"
@implementation AppDelegate (CZHRootController)

- (void)czh_setRootController {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[CZHRootController new]];
    
}

@end
