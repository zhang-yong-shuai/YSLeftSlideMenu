# YSLeftSlideMenu
YSLeftSlideMenu仿照QQ左侧菜单栏，实现了左滑展示菜单的功能。
用法示例：
```
// 下面的slideVC就是一个集成了左侧菜单栏的VC
UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[MainViewController new]];
YSLeftSlideMenuController *slideVC = [[YSLeftSlideMenuController alloc] initWithMainVC:nav leftMenuVC:[MenuViewController new]];
```
