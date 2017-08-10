//
//  PDFView.m
//  NSOperaton
//
//  Created by Yang Mr on 2017/8/9.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import "PDFView.h"

@implementation PDFView

-(id)initWithFrame:(CGRect)frame atPage:(int)index withPDFDoc:(CGPDFDocumentRef) pdfDoc{
    self = [super initWithFrame:frame];
    pageNO = index;
    pdfDocument = pdfDoc;
    return self;
}

-(void)drawInContext:(CGContextRef)context atPageNo:(int)page_no{
    // PDF page drawing expects a Lower-Left coordinate system, so we flip the coordinate system
    // before we start drawing.
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    NSInteger pageSum = CGPDFDocumentGetNumberOfPages(pdfDocument);
    NSLog(@"pageSum = %zd", pageSum);
    if (pageNO == 0) {
        pageNO = 1;
    }
    CGPDFPageRef page = CGPDFDocumentGetPage(pdfDocument, pageNO);
    CGContextSaveGState(context);
    CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(page, kCGPDFCropBox, self.bounds, 0, true);
    CGContextConcatCTM(context, pdfTransform);
    CGContextDrawPDFPage(context, page);
    CGContextRestoreGState(context);
}

- (void)drawRect:(CGRect)rect {
    [self drawInContext:UIGraphicsGetCurrentContext() atPageNo:pageNO];
}

//http://blog.csdn.net/yiyaaixuexi/article/details/7645725

//CGPDFDocumentRef GetPDFDocumentRef(NSString *filename)
//{
//    CFStringRef path;
//    CFURLRef url;
//    CGPDFDocumentRef document;
//    size_t count;
//
//    path = CFStringCreateWithCString (NULL, [filename UTF8String], kCFStringEncodingUTF8);
//    url = CFURLCreateWithFileSystemPath (NULL, path, kCFURLPOSIXPathStyle, 0);
//
//    CFRelease (path);
//    document = CGPDFDocumentCreateWithURL (url);
//    CFRelease(url);
//    count = CGPDFDocumentGetNumberOfPages (document);
//    if (count == 0) {
//        printf("[%s] needs at least one page!\n", [filename UTF8String]);
//        return NULL;
//    } else {
//        printf("[%ld] pages loaded in this PDF!\n", count);
//    }
//    
//    
//    return document;
//}
//
//void DisplayPDFPage (CGContextRef myContext, size_t pageNumber, NSString *filename)
//{
//    CGPDFDocumentRef document;
//    CGPDFPageRef page;
//    
//    ////    这样显示出来的pdf单页是倒立的，Quartz坐标系和UIView坐标系不一样所致，调整坐标系，使pdf正立
//    //    CGContextRef context = UIGraphicsGetCurrentContext();
//    //    CGContextTranslateCTM(context, 80, self.frame.size.height-60);
//    //    CGContextScaleCTM(context, 1, -1);
//
//    document = GetPDFDocumentRef (filename);
//    page = CGPDFDocumentGetPage (document, pageNumber);
//    CGContextDrawPDFPage (myContext, page);
//    CGPDFDocumentRelease (document);
//}

@end
