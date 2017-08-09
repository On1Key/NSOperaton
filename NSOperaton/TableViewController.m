//
//  TableViewController.m
//  NSOperaton
//
//  Created by Yang Mr on 2017/5/24.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import "TableViewController.h"
#import "UIImageView+WebCache.h"
#import "NSObject+url.h"
#import "TableViewCell.h"
//#import "CEFlipAnimationController.h"
//#import "CEHorizontalSwipeInteractionController.h"
#import "CEFoldAnimationController.h"
#import "CEHorizontalSwipeInteractionController.h"

@interface TableViewController ()///<UIViewControllerTransitioningDelegate>

/**<#statements#>*/
//@property (nonatomic, strong) NSArray * arr;
/**<#statements#>*/
@property (nonatomic, strong) NSMutableArray * models;

/**<#statements#>*/
@property (nonatomic, strong) CEReversibleAnimationController * animationController;
/**<#statements#>*/
@property (nonatomic, strong) CEBaseInteractionController * interactionController;

/**<#statements#>*/
@property (nonatomic) NSInteger animationIndex;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    DLog(@"%@",self.navigationController);
//    self.transitioningDelegate = self;
//    _animationController = [[CEFlipAnimationController alloc] init];
//    _interactionController = [[CEHorizontalSwipeInteractionController alloc] init];
    
//    _arr = @[@"1.jpg",@"2.png",@"3.jpg",@"4.png",@"5.png"];
    
    _models = [NSMutableArray arrayWithArray:[CellModel allModels]];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"REFRESH" style:UIBarButtonItemStylePlain target:self action:@selector(refresh)];
//    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"1212"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"1212"];
    [self.tableView reloadData];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"BACK" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    [self refresh];
    
}
- (void)back{
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)refresh{
    _animationIndex ++;
    
    NSInteger interIndex = _animationIndex % interactionControllers.count;
    NSInteger animaIndex = _animationIndex % animationControllers.count;
    
    NSString *interC = interactionControllers[interIndex];
    NSString *animaC = animationControllers[animaIndex];
    
    DLog(@"%@:%ld==%@:%ld",interC,interIndex,animaC,animaIndex);
    
    _interactionController = [[NSClassFromString(interC) alloc] init];
    _animationController = [[NSClassFromString(animaC) alloc] init];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _models.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"1212"];
//    if (!cell) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil] lastObject];
//    }
    cell.cellModel = _models[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BOOL push = indexPath.row % 2 == 0;
    BaseViewController *newVC = [[BaseViewController alloc] init];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:newVC];
    NSLog(@"%@",self.navigationController);
    if (push) {
        [self.navigationController pushViewController:newVC animated:YES];
    }else{
//        newVC.transitioningDelegate = self;
        newVC.settingsInteractionController = _interactionController;
        newVC.settingsAnimationController = _animationController;
        [self presentViewController:newVC animated:YES completion:nil];
//        [self.navigationController pushViewController:newVC animated:YES];
    }
}

#pragma mark - UIViewControllerTransitioningDelegate

//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//    DLog(@"\npresented==%@\npresenting==%@\nsource==%@",presented,presenting,source);
//    if (_interactionController) {
//        [_interactionController wireToViewController:presented forOperation:CEInteractionOperationDismiss];
//    }
//    
//    _animationController.reverse = NO;
//    return _animationController;
//}
////
//- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
//    self.animationController.reverse = YES;
//    return self.animationController;
//}
//
//- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
//    return self.interactionController && self.interactionController.interactionInProgress ? self.interactionController : nil;
//}

@end
