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
    
    if (_url) {
        [web loadRequest:[NSURLRequest requestWithURL:_url]];
    }else{
        if (_localHtmlData) {
            [web loadHTMLString:_localHtmlData baseURL:nil];
        }
    }
    
    
    
    if (!self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStylePlain target:self action:@selector(dismissBack)],[[UIBarButtonItem alloc] initWithTitle:@"Pop" style:UIBarButtonItemStylePlain target:self action:@selector(popBack)]];
    }
    
    
    
}
- (void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dismissBack{
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
