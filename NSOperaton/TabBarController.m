//
//  TabBarController.m
//  NSOperaton
//
//  Created by Yang Mr on 2018/1/22.
//  Copyright © 2018年 Yang Mr. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()
/**<#statements#>*/
@property (nonatomic, strong) NSArray * btns;
/**<#statements#>*/
@property (nonatomic, strong) UIImageView * grayBackImgView;
@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.title = @"test01";
    vc1.view.backgroundColor = COLOR_RANDOM;
    UINavigationController *vc1Navi = [[UINavigationController alloc] initWithRootViewController:vc1];
    //    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"001" image:nil tag:0];
    //    vc1.tabBarItem = item1;
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.title = @"test02";
    vc2.view.backgroundColor = COLOR_RANDOM;
    UINavigationController *vc2Navi = [[UINavigationController alloc] initWithRootViewController:vc2];
    //    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"001" image:nil tag:0];
    //    vc2.tabBarItem = item2;
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label1.textColor = [UIColor blackColor];
    label1.numberOfLines = 0;
    label1.text = [NSString stringWithFormat:@"%@",@"test01\n旋转屏幕\ncmd+<"];
    label1.translatesAutoresizingMaskIntoConstraints = NO;
    label1.backgroundColor = [UIColor colorWithRed:((arc4random()%255)*1.0/255) green:((arc4random()%255)*1.0/255) blue:((arc4random()%255)*1.0/255) alpha:1.0];
    [vc1.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label2.textColor = [UIColor blackColor];
    label2.numberOfLines = 0;
    label2.text = [NSString stringWithFormat:@"%@",@"test02\n旋转屏幕\ncmd+>"];
    label2.translatesAutoresizingMaskIntoConstraints = NO;
    label2.backgroundColor = [UIColor colorWithRed:((arc4random()%255)*1.0/255) green:((arc4random()%255)*1.0/255) blue:((arc4random()%255)*1.0/255) alpha:1.0];
    [vc2.view addSubview:label2];
    
    self.viewControllers = @[vc1Navi,vc2Navi];
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.tabBar.backgroundColor = [UIColor grayColor];
    // 设置tabbar 的frame
    self.tabBar.frame = CGRectMake(0, 0, 49, screenHeight);
    //    UIView *transitionView = [[self.view subviews] objectAtIndex:0];
    //    transitionView.frame = CGRectMake(80, 0, screenWidth-80, screenHeight);   // 设置UIViewController 的可视区域
    // 重置背景图片
    self.tabBar.backgroundImage = [[UIImage alloc] init];
    self.tabBar.selectionIndicatorImage = [[UIImage alloc] init];
    UIImageView *tabbarBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    tabbarBg.backgroundColor = [UIColor grayColor];
    tabbarBg.frame = self.tabBar.bounds;
    [self.tabBar insertSubview:tabbarBg atIndex:0];
    _grayBackImgView = tabbarBg;
    //去掉不用的系统默认的tabbar item
    NSInteger count = self.viewControllers.count;
    NSInteger startIndex = self.tabBar.subviews.count-count;
    NSInteger i;
    for (i=startIndex; i<startIndex+count; i++) {
        if (i < self.tabBar.subviews.count) {
            UIView *subView = [self.tabBar.subviews objectAtIndex:i];
            [subView removeFromSuperview];
        }
    }
    NSArray *unselImages = @[];
    //添加新的tabbar item，就是你自己的按钮。
    CGFloat btnH = screenHeight / count;
    NSMutableArray *btns = [NSMutableArray array];
    for (i=0; i<count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 40+70*i, 60, 60)];
        //        [btn setBackgroundImage:[unselImages objectAtIndex:i] forState:UIControlStateNormal];
        //        [btn setBackgroundImage:nil forState:UIControlStateHighlighted];
        [btn setBackgroundColor:[UIColor colorWithRed:((arc4random()%255)*1.0/255) green:((arc4random()%255)*1.0/255) blue:((arc4random()%255)*1.0/255) alpha:1.0]];
        btn.tag = i;
        [btn addTarget:self action:@selector(tabbarItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:btn];
        [btns addObject:btn];
        //        [self.tabbarItems addObject:btn];
        //        btn.frame = CGRectMake(0, btnH * i, 49, btnH);
    }
    _btns = btns;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange:)name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
}
- (void)viewWillLayoutSubviews{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeRight) // home键靠右
    {
        self.tabBar.frame = CGRectMake(0, 0, 80, [UIScreen mainScreen].bounds.size.height);
        for (int i = 0;i < _btns.count; i ++) {
            UIButton *btn = _btns[i];
            btn.frame = CGRectMake(10, 40+70*i, 60, 60);
        }
    }
    if (orientation ==UIInterfaceOrientationLandscapeLeft) // home键靠左
    {
        self.tabBar.frame = CGRectMake(0, 0, 80, [UIScreen mainScreen].bounds.size.height);
        for (int i = 0;i < _btns.count; i ++) {
            UIButton *btn = _btns[i];
            btn.frame = CGRectMake(10, 40+70*i, 60, 60);
        }
    }
    if (orientation == UIInterfaceOrientationPortrait){
        self.tabBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 80, [UIScreen mainScreen].bounds.size.width, 80);
        for (int i = 0;i < _btns.count; i ++) {
            UIButton *btn = _btns[i];
            btn.frame = CGRectMake(40+70*i,10, 60, 60);
        }
    }
    if (orientation == UIInterfaceOrientationPortraitUpsideDown){
        self.tabBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 80, [UIScreen mainScreen].bounds.size.width, 80);
        for (int i = 0;i < _btns.count; i ++) {
            UIButton *btn = _btns[i];
            btn.frame = CGRectMake(40+70*i,10, 60, 60);
        }
    }
    _grayBackImgView.frame = self.tabBar.bounds;
}
- (void)tabbarItemClicked:(UIButton *)btn{
    NSInteger index = btn.tag;
    [self setSelectedIndex:index];
}

- (void)statusBarOrientationChange:(NSNotification *)notification{
    [self viewWillLayoutSubviews];
}

@end
