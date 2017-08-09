//
//  PDFView.h
//  NSOperaton
//
//  Created by Yang Mr on 2017/8/9.
//  Copyright © 2017年 Yang Mr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFView : UIView{
    CGPDFDocumentRef pdfDocument;
    int pageNO;
}

-(id)initWithFrame:(CGRect)frame atPage:(int)index withPDFDoc:(CGPDFDocumentRef) pdfDoc;

@end
