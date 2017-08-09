//
//  WebController.m
//  NSOperaton
//
//  Created by Yang Mr on 2017/7/12.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import "WebController.h"

@interface WebController ()

@end

@implementation WebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:web];
    
    [web loadRequest:[NSURLRequest requestWithURL:_url]];
    
    if (!self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(back)];
    }
    
    
    
}

- (void)back{
//    if (self.navigationController) {
//        
//        //        if (self.navigationController.viewControllers.count <= 1) {
//        //            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//        //        }else{
//        [self.navigationController popViewControllerAnimated:YES];
//        //        }
//        
//    }else{
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
