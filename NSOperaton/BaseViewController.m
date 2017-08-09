//
//  BaseViewController.m
//  NSOperaton
//
//  Created by Yang Mr on 2017/7/7.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import "BaseViewController.h"
#import "WebController.h"


@interface BaseViewController ()<UIViewControllerTransitioningDelegate,TTTAttributedLabelDelegate>
/**<#statements#>*/
@end

@implementation BaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.transitioningDelegate = self;
    
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    label.center = self.view.center;
    label.tag = 12306;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor whiteColor];
    label.enabledTextCheckingTypes = NSTextCheckingTypeLink;
//    [label setTextWithLinkAttribute:@"百度地址是:http://www.baidu.com对吗？"];
    label.text = @"这是百度的地址:http://www.baidu.com";
//    [label setTextWithLinkAttribute:label.text];
    label.delegate = self;
    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    
    [label addLinkToURL:[NSURL URLWithString:@"http://www.sina.com"] withRange:NSMakeRange(2, 2)];
    
//    label addLinkWithTextCheckingResult:<#(NSTextCheckingResult *)#>
    
    label.userInteractionEnabled = YES;
    
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpDeep)];
//    [label addGestureRecognizer:tap];
    
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(jumpDeep)];
    [label addGestureRecognizer:swip];
    
    UILongPressGestureRecognizer *back = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(back)];
    [self.view addGestureRecognizer:back];
    
    
    if (self.navigationController && [self.navigationController isKindOfClass:[NavigationController class]]) {
        NavigationController *navi = (NavigationController *)self.navigationController;
        navi.navigationControllerAnimationController = self.navigationControllerAnimationController;
        navi.navigationControllerInteractionController = self.navigationControllerInteractionController;
    }
    
    
//    DLog(@"%@",self.navigationController);
}
- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url{
    WebController *web = [WebController new];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:web];
    web.url = url;
    
    if (self.navigationController) {
        [self.navigationController pushViewController:web animated:YES ];
    }else{
        [self presentViewController:navi animated:YES completion:nil];
    }
}
//- (void)swip{
//    NSString *interC = interactionControllers[arc4random()%interactionControllers.count];
//    NSString *animaC = animationControllers[arc4random()%animationControllers.count];
//    
//    BaseViewController *base = [[BaseViewController alloc] init];
//    base.navigationControllerInteractionController = [[NSClassFromString(interC) alloc] init];
//    base.navigationControllerAnimationController = [[NSClassFromString(animaC) alloc] init];
//    
//    UINavigationController *navi;
//    if (!self.navigationController) {
//        navi = [[NavigationController alloc] initWithRootViewController:self];
//    }else{
//        navi = self.navigationController;
//    }
//    
//    [navi pushViewController:base animated:YES];
//}
- (void)jumpDeep{
    DLog(@"jumpdeep")
    
    NSString *interC = interactionControllers[arc4random()%interactionControllers.count];
    NSString *animaC = animationControllers[arc4random()%animationControllers.count];
    
    BaseViewController *base = [[BaseViewController alloc] init];
    
    if (self.navigationController) {
        base.navigationControllerInteractionController = [[NSClassFromString(interC) alloc] init];
        base.navigationControllerAnimationController = [[NSClassFromString(animaC) alloc] init];
        [self.navigationController pushViewController:base animated:YES];
    }else{
        base.settingsInteractionController = [[NSClassFromString(interC) alloc] init];
        base.settingsAnimationController = [[NSClassFromString(animaC) alloc] init];
        [self presentViewController:base animated:YES completion:nil];
    }
    
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
////    [super touchesBegan:touches withEvent:event];
////    [self back];
//    DLog(@"touchesBegan")
//    
//    
//    
//}
- (void)back{
    if (self.navigationController) {
        
//        if (self.navigationController.viewControllers.count <= 1) {
//            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//        }else{
            [self.navigationController popViewControllerAnimated:YES];
//        }
        
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - UIViewControllerTransitioningDelegate
//
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    DLog(@"\npresented==%@\npresenting==%@\nsource==%@",presented,presenting,source);
    if (self.settingsInteractionController) {
        [self.settingsInteractionController wireToViewController:self forOperation:CEInteractionOperationDismiss];
    }
    
    self.settingsAnimationController.reverse = NO;
    return self.settingsAnimationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.settingsAnimationController.reverse = YES;
    return self.settingsAnimationController;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.settingsInteractionController && self.settingsInteractionController.interactionInProgress ? self.settingsInteractionController : nil;
}

@end
