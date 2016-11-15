//
//  MainViewController.m
//  YSLeftSlideMenuDemo
//
//  Created by zys on 2016/11/15.
//  Copyright © 2016年 张永帅. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"MainVC";
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(menuBtnClicked:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button actions
- (void)menuBtnClicked:(UIBarButtonItem *)item {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.slideVC switchMenu];
}

@end
