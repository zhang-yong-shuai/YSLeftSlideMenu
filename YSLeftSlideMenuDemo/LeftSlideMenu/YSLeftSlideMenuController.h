//
//  YSSlideMenuController.h
//  YSSlideMenuDemo
//
//  Created by zys on 2016/11/15.
//  Copyright © 2016年 张永帅. All rights reserved.
//

/**
 *  仿照QQ侧边菜单栏
 */

#import <UIKit/UIKit.h>

@interface YSLeftSlideMenuController : UIViewController

/// init methods
- (instancetype)initWithMainVC:(UIViewController *)mainVC leftMenuVC:(UIViewController *)leftMenuVC;

/// open / close menu
- (void)switchMenu;

@end
