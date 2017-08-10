//
//  PDFViewController.m
//  NSOperaton
//
//  Created by Yang Mr on 2017/8/9.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import "PDFViewController.h"
#import "PDFView.h"

@interface PDFViewController ()<UIPageViewControllerDataSource>
@property (nonatomic) CGPDFDocumentRef pdfDocument;
@property (nonatomic) NSInteger pageNo;
@end

@implementation PDFViewController
CGPDFDocumentRef getDocumentRef(NSString *filename){
    CFURLRef pdfURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), (__bridge CFStringRef)filename, NULL, NULL);
    CGPDFDocumentRef pdfDocument = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
    CFRelease(pdfURL);
    return pdfDocument;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *filename = @"list.pdf";
    self.title = filename;
    _pdfDocument = getDocumentRef(filename);
    
    
    NSDictionary *options = [NSDictionary dictionaryWithObject:
                             [NSNumber numberWithInteger: UIPageViewControllerSpineLocationMin]
                                                        forKey: UIPageViewControllerOptionSpineLocationKey];
    UIPageViewController *pageViewCtrl = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
                                                                         navigationOrientation:UIPageViewControllerNavigationOrientationVertical
                                                                                       options:options];
    UIViewController *initialViewController = [self viewControllerAtIndex:1];
    NSArray * viewPageControllers = [NSArray arrayWithObject:initialViewController];
    [pageViewCtrl setDataSource:self];
    
    [pageViewCtrl setViewControllers:viewPageControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    [self addChildViewController:pageViewCtrl];
    [self.view addSubview:pageViewCtrl.view];
    [pageViewCtrl didMoveToParentViewController:self];
    
}
#pragma mark - CGContexDrawPDFPage
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger index = self.pageNo;
    if ((index == 1) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSUInteger index = self.pageNo;
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    long pageSum = CGPDFDocumentGetNumberOfPages(_pdfDocument);
    if (index >= pageSum+1) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)pageNO {
    // Return the data view controller for the given index.
    self.pageNo = pageNO;
    long pageSum = CGPDFDocumentGetNumberOfPages(_pdfDocument);
    if (pageSum== 0 || pageNO >= pageSum+1) {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    UIViewController *pageController = [[UIViewController alloc] init];
    //    pageController.pdfDocument = pdfDocument;
    //    pageController.pageNO  = pageNO;
    PDFView *pdfView = [[PDFView alloc] initWithFrame:self.view.bounds atPage:(int)self.pageNo withPDFDoc:self.pdfDocument];
    pdfView.backgroundColor=[UIColor whiteColor];
    [pageController.view addSubview:pdfView];
    return pageController;
}

@end
