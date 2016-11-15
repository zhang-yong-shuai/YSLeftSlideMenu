//
//  YSLeftSlideMenuController.m
//  YSLeftSlideMenuDemo
//
//  Created by zys on 2016/11/15.
//  Copyright © 2016年 张永帅. All rights reserved.
//

#import "YSLeftSlideMenuController.h"

#define YSWeakSelf()        __weak typeof (self) weakself = self
#define kScreenSize         [UIScreen mainScreen].bounds.size
#define kScreenWidth        kScreenSize.width
#define kScreenHeight       kScreenSize.height
#define kMainVCShowWidth    kScreenWidth * .25f// when open left menu, main view width

NSTimeInterval const kYSSlideMenuDuration = .2f;

@interface YSLeftSlideMenuController ()

@property (nonatomic, strong) UIViewController *mainVC;
@property (nonatomic, strong) UIViewController *leftMenuVC;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, assign) BOOL menuOpened;

@end

@implementation YSLeftSlideMenuController

#pragma mark - life cycle
- (instancetype)initWithMainVC:(UIViewController *)mainVC leftMenuVC:(UIViewController *)leftMenuVC {
    if (self = [super init]) {
        self.menuOpened = NO;
        self.mainVC = mainVC;
        self.leftMenuVC = leftMenuVC;
        [self.view addSubview:self.mainVC.view];
        [self.view insertSubview:self.leftMenuVC.view belowSubview:self.mainVC.view];
        [self addPanGestureToMainVC];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - open / close left menu
- (void)switchMenu {
    if (self.menuOpened == NO) {
        [self openLeftMenu];
    } else {
        [self closeLeftMenu];
    }
}

- (void)openLeftMenu {
    self.menuOpened = YES;
    [self addTapGestureToMainVC];
    YSWeakSelf();
    [UIView animateWithDuration:kYSSlideMenuDuration animations:^{
        weakself.mainVC.view.center = CGPointMake(kScreenWidth + kScreenWidth / 2.f - kMainVCShowWidth, kScreenHeight / 2.f);
    }];
    
}

- (void)closeLeftMenu {
    self.menuOpened = NO;
    [self removeTapGestureFromMainVC];
    YSWeakSelf();
    [UIView animateWithDuration:kYSSlideMenuDuration animations:^{
        weakself.mainVC.view.center = CGPointMake(kScreenWidth / 2.f, kScreenHeight / 2.f);
    }];
}

#pragma mark - add / remove gestures
- (void)addTapGestureToMainVC {
    [self.mainVC.view addGestureRecognizer:self.tapGesture];
}

- (void)removeTapGestureFromMainVC {
    [self.mainVC.view removeGestureRecognizer:self.tapGesture];
}

- (void)addPanGestureToMainVC {
    [self.mainVC.view addGestureRecognizer:self.panGesture];
}

- (void)removePanGestureFromMainVC {
    [self.mainVC.view removeGestureRecognizer:self.panGesture];
}

#pragma mark - handle gestures
- (void)handleTapGesture:(UITapGestureRecognizer *)tap {
    if (self.menuOpened) {
        [self closeLeftMenu];
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)pan {
    // move pan.view with finger
    CGPoint offsetPoint = [pan translationInView:pan.view];
    pan.view.center = CGPointMake(pan.view.center.x + offsetPoint.x, pan.view.center.y);
    [pan setTranslation:CGPointZero inView:self.view];
    
    // fix pan.view center when slide end
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat mainVCLeft = pan.view.frame.origin.x;
        if (mainVCLeft < kScreenWidth / 2.f) {
            [self closeLeftMenu];
        } else {
            [self openLeftMenu];
        }
    }
}

#pragma mark - getters
- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    }
    return _tapGesture;
}

- (UIPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    }
    return _panGesture;
}

@end
