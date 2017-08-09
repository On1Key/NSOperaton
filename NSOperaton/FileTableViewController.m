//
//  FileTableViewController.m
//  NSOperaton
//
//  Created by Yang Mr on 2017/8/8.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import "FileTableViewController.h"
#import <QuickLook/QuickLook.h>
#import "PDFViewController.h"

@interface FileTableViewController ()<UIDocumentInteractionControllerDelegate,QLPreviewControllerDelegate,QLPreviewControllerDataSource>
/**<#statements#>*/
@property (nonatomic, strong) UIWebView * webView;
/**<#statements#>*/
@property (nonatomic, strong) NSArray * files;

/**<#statements#>*/
@property (nonatomic, strong) NSArray * dataArr;

@end

@implementation FileTableViewController
- (UIWebView *)webView{
    if (!_webView) {
        UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
        CGRect frame = webview.frame;
        frame.origin.y += 64;
        webview.frame = frame;
        _webView = webview;
    }
    return _webView;
}
- (NSArray *)files{
    if (!_files) {
        _files = @[[[NSBundle mainBundle] pathForResource:@"num_excel" ofType:@"xlsx"],
                   [[NSBundle mainBundle] pathForResource:@"num_numbers" ofType:@"numbers"],
                   [[NSBundle mainBundle] pathForResource:@"error" ofType:@"csv"],
                   [[NSBundle mainBundle] pathForResource:@"list" ofType:@"pdf"]];
    }
    return _files;
}
- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[@"UIWebView",
                     @"QLPreviewController",
                     @"UIDocumentInteractionController",
                     @"CGContexDrawPDFPage"];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
    
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"testnum" ofType:@"xlsx"];
    NSString *path = self.files[arc4random()%4];
    NSURL *pathUrl = [NSURL fileURLWithPath:path];
    switch (indexPath.row) {
        case 0:{
            
            UIViewController *webVC = [[UIViewController alloc] init];
            webVC.view.backgroundColor = [UIColor whiteColor];
            [webVC.view addSubview:self.webView];
            [self.webView loadRequest:[NSURLRequest requestWithURL:pathUrl]];
            [self.navigationController pushViewController:webVC animated:YES];
            
        }break;
        case 1:{
            
            QLPreviewController *preVC = [[QLPreviewController alloc] init];
            preVC.view.backgroundColor = self.view.backgroundColor;
            preVC.delegate = self;
            preVC.dataSource = self;
            [self.navigationController pushViewController:preVC animated:YES];
            
            //            [preVC reloadData];
        }break;
        case 2:{
            
            UIDocumentInteractionController *docVC = [UIDocumentInteractionController interactionControllerWithURL:pathUrl];
            docVC.delegate = self;
            [docVC presentPreviewAnimated:YES];
        }break;
        case 3:{
            PDFViewController *preVC = [[PDFViewController alloc] init];
            [self.navigationController pushViewController:preVC animated:YES];
        }break;
            
        default:
            break;
    }
    
}


#pragma mark - UIDocumentInteractionController
- (UIViewController*)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController*)controller
{
    return self;
}
- (UIView*)documentInteractionControllerViewForPreview:(UIDocumentInteractionController*)controller
{
    return self.view;
}
- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController*)controller
{
    return self.view.frame;
}
//点击预览窗口的“Done”(完成)按钮时调用

- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController*)_controller
{
}

#pragma QLPreviewController
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return self.files.count;
}
- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    return [NSURL fileURLWithPath:self.files[index]];
}

@end
